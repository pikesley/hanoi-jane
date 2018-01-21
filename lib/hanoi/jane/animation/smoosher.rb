module Hanoi
  module Jane
    class Smoosher < Array
      include Enumerable

      attr_accessor :direction
      attr_reader   :animtype

      def initialize
        @direction = :close
        @step = 0.05
        @animtype = :tween

        yield self if block_given?
      end

      def each
        @range = (0..1).step(0.05).to_a
        @range.reverse! if @direction == :open
        @range.each do |weight|
          populate weight
          yield self
        end
      end

      def populate weight
        7.times do |i|
          self[i] = Smoosher.row weight
        end
      end

      def to_dots
        self
      end

      def Smoosher.row weight = 0
        a = []
        45.times do
          a.push (weight > Random.rand) ? 1 : 0
        end
        a
      end
    end
  end
end
