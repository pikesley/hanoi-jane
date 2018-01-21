module Hanoi
  module Jane
    module RegularSearches
      def find_stack stacks:, from:, disc:, total: nil
        # if the next stack is empty, move there
        if stacks[(from + 1) % 3] == []
          return (from + 1) % 3
        end

        # if the next stack has a smaller top disc than our disc, go one more over
        if stacks[(from + 1) % 3][-1] < disc
          return (from + 2) % 3
        end

        # default to the next one
        return (from + 1) % 3
      end
    end

    module ConstrainedSearches
      def find_stack stacks:, from:, disc: nil, total:
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
