module Hanoi
  module Jane
    class Console
      attr_reader :content

      def initialize towers
        @discs = towers.discs
        @stacks = towers.stacks.clone.map { |s| s.clone }
      end

      def to_s
        s = ''
        (Console.rotate @stacks.map { |s| (Console.pad s, @discs).reverse }).each do |stack|
          s += stack.map { |s| Console.make_disc s, (Console.scale @discs) }.join ' '
          s += "\n"
        end

        s 
      end

      def Console.pad array, length
        until array.length == length
          array.push nil
        end

        array.reverse
      end

      def Console.make_disc width, space, char = 'o'
        unless width
          return ' ' * space
        end

        count = Console.scale width
        padding = (space - count) / 2

        '%s%s%s' % [
          ' ' * padding,
          char * count,
          ' ' * padding
        ]
      end

      def Console.scale size
        (size * 2) + 1
      end

      def Console.rotate stacks
        stacks.map { |s| s.clone }.transpose.reverse
      end
    end
  end
end
