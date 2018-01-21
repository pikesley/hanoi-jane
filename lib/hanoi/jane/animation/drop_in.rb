module Hanoi
  module Jane
    class DropIn
      include Enumerable

      attr_accessor :height, :discs
      attr_reader   :stacks, :disc, :animtype

      def initialize
        @height = 7
        @discs = 3
        @animtype = :tween
        yield self if block_given?

        @stacks = PaddedStacks.new [[], [], []], @height
        @disc = discs - 1
        @dropper = Dropper.new @stacks[0], @disc, true
      end

      def value
        '0' * (@discs - @disc)
      end

      def each
        while @disc >= 0
          @dropper = Dropper.new @stacks[0], @disc, (@disc == 0 ? false : true)
          @dropper.each do |state|
            @stacks[0] = state.to_a
            yield self
          end
          @disc -= 1
        end
      end

      def to_dots
        Formatters::Matrix.new do |m|
          m.stacks = @stacks
          m.digits = '0' * (@discs - @disc)
        end
      end
    end
  end
end
