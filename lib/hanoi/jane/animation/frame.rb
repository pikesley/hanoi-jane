module Hanoi
  module Jane
    class Frame
      attr_reader :stacks, :animtype, :value

      def initialize stacks, value, type
        @stacks = stacks
        @value = value
        @animtype = type
      end

      def to_dots
        Formatters::Matrix.new do |m|
          m.stacks = @stacks
          m.digits = @value
        end
      end
    end
  end
end
