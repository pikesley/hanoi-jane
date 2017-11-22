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
      option :phat, type: :string, required: true
      option :constrained, type: :boolean
      option :interval, type: :numeric, default: 0.3

      def phat
        towers = Towers.new 5
        if options[:constrained]
          towers = ConstrainedTowers.new 5
        end

        until towers.solved do
          Hanoi::Jane.hit_phat towers, options[:phat]
          towers.move
          sleep options[:interval]
        end
        Hanoi::Jane.hit_phat towers, options[:phat]
      end

      desc 'console', "Solve the towers one the console"
      option :discs, type: :numeric, default: 3
      option :constrained, type: :boolean
      def console
        towers = Towers.new options[:discs]
        if options[:constrained]
          towers = ConstrainedTowers.new options[:discs]
        end
        until towers.solved do
          puts towers
          towers.move
        end
        puts towers

        puts "%d moves to solve for %d discs" % [towers.count, options[:discs]]
      end
    end
  end
end
