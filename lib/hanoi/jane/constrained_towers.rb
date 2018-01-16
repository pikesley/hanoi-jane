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
        i[:ternary] = i.delete :binary
        i
      end

      private

      def ConstrainedTowers.find_stack stacks, source, disc, total
        # if we're in the middle
        if source == 1
          # we always move to the right on an even total
          if total % 2 == 0
            return 2
          else
            return 0
          end
        end
        # otherwise we're at the edges and can only move to the middle
        1
      end
    end
  end
end
