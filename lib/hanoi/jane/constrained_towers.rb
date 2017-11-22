module Hanoi
  module Jane
    class ConstrainedTowers < Towers
      def initialize discs
        super
        @base = 3

        @directions = {}
        @stacks[0].each do |disc|
          @directions[disc] = :right
        end
      end

      def ternary
        rebased
      end
      
      def find_stack
        case @source
        when 0
          @directions[@disc] = :right
          return 1
        when 2
          @directions[@disc] = :left
          return 1
        when 1
          if @directions[@disc] == :right
            return 2
          else
            return 0
          end
        end
      end
    end
  end
end
