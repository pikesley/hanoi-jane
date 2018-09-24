require 'hanoi/jane'

module Hanoi
  module Jane
    class CLI < ::Thor
      desc 'version', 'Print hanoi version'
      def version
        puts "hanoi version #{VERSION}"
      end
      map %w(-v --version) => :version

      desc 'phat', "Solve the towers against the pHAT's webserver"
      option :phat, type: :string, required: true, desc: 'Address of the pHAT you want to hit'
      option :discs, type: :numeric, default: 5, desc: 'Number of discs'
      option :constrained, type: :boolean, desc: 'Solve the constrained variant'
      option :interval, type: :numeric, default: 0.1, desc: 'Time between frames (ish)'

      def phat
        grid = JSON.parse(HTTParty.get('http://%s/lights' % options[:phat]).body)['matrix']
        squeegee = Wiper::Squeegee.new do |s|
          s.grid = grid unless grid == []
          s.interval = 0.01
        end

        squeegee.each do |frame|
          Hanoi::Jane.hit_phat frame, options[:phat]
          sleep frame.interval
        end

        drop_in = DropIn.new do |d|
          d.height = 7
          d.discs = options[:discs]
        end

        towers = AnimatedTowers.new do |a|
          a.towers = ConstrainedTowers
          a.discs = options[:discs]
          a.height = 7
        end

        [drop_in, towers].each do |source|
          Hanoi::Jane.render_to_phat source, options[:interval], options[:phat]
        end
      end

      desc 'console', 'Solve the towers on the console'
      option :discs, type: :numeric, default: 3, desc: 'Number of discs'
      option :constrained, type: :boolean, default: true, desc: 'Solve the constrained variant'
      option :interval, type: :numeric, default: 0.5, desc: 'Time between frames (ish)'
      option :height, type: :numeric, default: 2, desc: 'Additional height above towers'
      option :fancy, type: :boolean, default: false, desc: 'Draw the towers using emojis'

      def console
        begin
          drop_in = DropIn.new do |d|
            d.height = options[:discs] + options[:height]
            d.discs = options[:discs]
          end

          towers = AnimatedTowers.new do |a|
            a.towers = options[:constrained] ? ConstrainedTowers : RegularTowers
            a.discs = options[:discs]
            a.height = options[:discs] + options[:height]
          end

          [drop_in, towers].each do |source|
            Hanoi::Jane.render_to_console source, options[:interval], options[:fancy]
          end

          puts '%d moves to solve for %d discs' % [towers.towers.total, towers.discs]

        rescue HanoiException => he
          puts he.text
          system('exit')
        end
      end

      desc 'github', 'Render data suitable for drawing on the Github contribution graph'
      option :discs, type: :numeric, default: 6, desc: 'Number of discs'
      option :save_path, type: :string, required: true, desc: 'Where to store the state between moves'

      def github
        begin
          towers = ConstrainedTowers.deserialise options[:save_path]
        rescue Errno::ENOENT => e
          if e.message == "No such file or directory @ rb_sysopen - #{options[:save_path]}"
            towers = ConstrainedTowers.new options[:discs]
          end
        end

        h = Hanoi::Jane.render_to_github towers
        Gitpaint.paint h, 'towers', message: towers.ternary

        towers.move
        towers.serialise options[:save_path]
      end
    end
  end
end
