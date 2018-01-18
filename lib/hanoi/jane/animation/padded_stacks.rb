module Hanoi
  module Jane
    class PaddedStacks < Array
      def initialize stacks, height = 7
        stacks.clone.each do |s|
          self.push PaddedStacks.pad s.clone, height
        end
      end

      def PaddedStacks.pad stack, height
        stack + Array.new(height - stack.length)
      end
    end
  end
end
