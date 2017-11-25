module Hanoi
  module Jane
    class ConstrainedTowers < Towers
      def initialize discs
        super
        @base = 3
      end

      def ternary
        rebased
      end

      def inspect
        i = super

        i.delete :binary
        i[:ternary] = rebased

        i
      end

      private

      def find_stack
        parity = rebased.chars.inject(0) { |sum,x| sum + x.to_i } % 2

        case @source
        when 0
          return 1

        when 2
          return 1

        when 1
           if parity == 0
            return 2
          else
            return 0
          end
        end
      end
    end
  end
end
