module Hanoi
  module Jane
    class ConstrainedTowers < Towers
      extend ConstrainedStackFinder
      include Constraints
    end
  end
end
