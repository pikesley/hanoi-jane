module Hanoi
  module Jane
    class ConstrainedTowers < RegularTowers
      def initialize discs = 3
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

      def ConstrainedTowers.find_stack stacks:, from:, disc: nil, total:
        # if we're in the middle
        if from == 1
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
