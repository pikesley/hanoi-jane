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
      option :interval, type: :numeric, default: 0.1

      def phat
        towers = AnimatedTowers.new do |a|
          a.towers = ConstrainedTowers
          a.discs = 5
          a.height = 7
        end

        towers.each do |state|
          Hanoi::Jane.hit_phat state.stacks, options[:phat]
          sleep options[:interval]
        end
      end
    end
  end
end
