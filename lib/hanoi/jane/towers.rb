module Hanoi
  module Jane
    class Towers
      include Enumerable

      attr_reader :total, :stacks

      def initialize discs
        @discs = discs
        @total = 0
        @base = 2
        @stacks = [(0...discs).to_a.reverse, [], []]
      end

      def move
        diff
        find_disc
        @stacks[find_stack].push @stacks[@source].pop
      end

      def solved
        rebased.chars.all? { |digit| digit.to_i == @base - 1 }
      end

      def matrix
        Matrix.new self
      end

      def console
        s = ''
        x = self.stacks.clone
        y = x.map { |s| s.clone }

        (Towers.rotate y.map { |s| (Towers.pad s, @discs).reverse }).each do |stack|
          s += stack.map { |s| Towers.make_disc s, (Towers.scale @discs) }.join ' '
          s += "\n"
        end

        s
      end

      def inspect
        {
          stacks: @stacks,
          moves: @total,
          binary: rebased,
          moved: @disc
        }
      end

      def each
        yield self if @total == 0
        until solved
          move
          yield self
        end
      end

      def to_s
        s = ''
        @stacks.each do |stack|
          s += stack.to_s
          s += "\n"
        end
        s += '---'

        s
      end

      def binary
        rebased
      end

      def rebased
        Towers.rebase @total, @base, @discs
      end

      private

      def find_disc
        @stacks.each_with_index do |stack, index|
          @source = index if stack.index @disc
        end
      end

      def find_stack #disc, source, stacks
        # if the next stack is empty, move there
        if @stacks[(@source + 1) % 3] == []
          return (@source + 1) % 3
        end

        # if the next stack has a smaller top disc than our disc, go one more over
        if @stacks[(@source + 1) % 3][-1] < @disc
          return (@source + 2) % 3
        end

        # default to the next one
        return (@source + 1) % 3
      end

      def diff
        this = binary
        @total += 1
        that = binary
        this.chars.reverse.each_with_index do |bit, index|
          if bit < that.chars.reverse[index]
            @disc = index
          end
        end
      end

      def Towers.rebase value, base, width
        '%0*d' % [width, value.to_s(base)]
      end

      def Towers.pad array, length
        until array.length == length
          array.push nil
        end

        array.reverse
      end

      def Towers.make_disc width, space, char = 'o'
        unless width
          return ' ' * space
        end

        count = Towers.scale width
        padding = (space - count) / 2

        '%s%s%s' % [
          ' ' * padding,
          char * count,
          ' ' * padding
        ]
      end

      def Towers.scale size
        (size * 2) + 1
      end

      def Towers.rotate stacks
        stacks.map { |s| s.clone }.transpose.reverse
      end
    end
  end
end
