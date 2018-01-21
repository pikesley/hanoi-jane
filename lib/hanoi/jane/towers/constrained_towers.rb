module Hanoi
  module Jane
    class ConstrainedTowers < Towers
      extend ConstrainedSearches

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
    end
  end
end
