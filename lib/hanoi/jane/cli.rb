require 'hanoi/jane'

module Hanoi
  module Jane
    class CLI < ::Thor
      desc 'version', 'Print hanoi version'
      def version
        puts 'hanoi version #{VERSION}'
      end
      map %w(-v --version) => :version

      desc 'phat', "Solve the towers against the pHAT's webserver"
      option :phat, type: :string, required: true
      option :constrained, type: :boolean
      option :interval, type: :numeric, default: 0.3

      def phat
        towers = Towers.new 5
        if options[:constrained]
          towers = ConstrainedTowers.new 5
        end

        towers.each do |state|
          Hanoi::Jane.hit_phat towers, options[:phat]
          sleep options[:interval]
        end
      end

      desc 'console', 'Solve the towers on the console'
      option :discs, type: :numeric, default: 3, minimum: 1
      option :constrained, type: :boolean
      option :fancy, type: :boolean, default: false
      option :animated, type: :boolean, default: false
      option :delay, type: :numeric, default: 0.2
      def console
        if options[:discs] < 1
          puts "Solving for %d discs makes no sense" % options[:discs]
          exit 1
        end

        towers = Towers.new options[:discs]

        if options[:constrained]
          towers = ConstrainedTowers.new options[:discs]
        end

        towers.fancy = options[:fancy]
        towers.animated = options[:animated]

        towers.each do |state|


          if options[:animated]
            if state.animation
              count = 0
              state.animation.each do |frame|
                system('clear')
                s = options[:fancy] ? (Formatters::Console.fancify state.rebased) : state.rebased
                puts s
                puts
                puts Formatters::Console.new towers.discs, frame.stacks, towers.fancy
                sleep options[:delay] * 0.2
                count += 1
              end
            end
          end

          system('clear')
          s = options[:fancy] ? (Formatters::Console.fancify state.rebased) : state.rebased
          puts s
          puts
          puts state.console
          sleep options[:delay]
        end

        puts '%d moves to solve for %d discs' % [towers.total, options[:discs]]
      end
    end
  end
end
