module Hanoi
  module Jane
    class Lifter < Array
      attr_reader :lifted

      def initialize stack
        stack.map { |i| self.push i }

        @lifted = false
      end

      def lift
        start = Lifter.position self

        item = self[start]
        self[start] = nil

        next_pos = start + 1
        if next_pos >= self.length
          @lifted = true
        else
          self[next_pos] = item
        end
      end

      def each
        until @lifted
          lift
          yield self
        end
      end

      def Lifter.position stack
        pos = nil
        stack.reverse.each_with_index do |item, index|
          if item
            pos = index
            break
          end
        end

        stack.length - 1 - pos
      end
    end
  end
end
