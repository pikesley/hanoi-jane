module Hanoi
  module Jane
    class Animation
      include Enumerable

      attr_accessor :stacks, :disc, :from, :to, :height

      def initialize
        @stacks = [[0]]
        @disc = 0
        @from = 0
        @to = 1
        @height = 7

        yield self if block_given?

        @stacks = PaddedStacks.new @stacks, @height
        @lifter = Lifter.new @stacks[@from]
        @dropper = Dropper.new @stacks[@to], @disc
      end

      def each
        @lifter.each do |state|
          @stacks[@from] = state
          yield self
        end

        @dropper.each do |state|
          @stacks[@to] = state
          yield self
        end
      end
    end
  end
end
