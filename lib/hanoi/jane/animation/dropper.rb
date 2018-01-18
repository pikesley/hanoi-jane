module Hanoi
  module Jane
    class Dropper < Array
      def initialize stack, item
        stack.map { |i| self.push i }
        @item = item
      end

      def drop
        pos = Dropper.position self, @item
        self[pos] = @item

        unless pos >= self.length - 1
          self[pos + 1] = nil
        end
      end

      def dropped
        (self[(Dropper.position self, @item) - 1] || self[(Dropper.position self, @item)]) || (Dropper.position self, @item) == 0
      end

      def each 
        until dropped
          drop
          yield self
        end
      end

      def Dropper.position stack, item
        pos = stack.index item
        return stack.length - 1 unless pos
        pos - 1
      end
    end
  end
end
