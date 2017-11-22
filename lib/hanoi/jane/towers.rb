module Hanoi
  module Jane
    class Towers
      attr_reader :count, :stacks

      def initialize discs
        @discs = discs
        @count = 0
        @base = 2
        @stacks = [(0...discs).to_a.reverse, [], []]
      end

      def move
        @disc = Towers.diff Towers.rebase(@count, @base, @discs),
                           Towers.rebase(@count += 1, @base, @discs)
        @source = find_disc

        @stacks[find_stack].push @stacks[@source].pop
      end

      def binary
        rebased
      end

      def rebased
        Towers.rebase @count, @base, @discs
      end

      def solved
        rebased.chars.all? { |digit| digit.to_i == @base - 1 }
      end

      def matrix
        Matrix.new self
      end

      def find_disc
        @stacks.each_with_index do |stack, index|
          return index if stack.index @disc
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

      def inspect
        {
          stacks: @stacks,
          count: rebased
        }
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

      def Towers.rebase value, base, width
        '%0*d' % [width, value.to_s(base)]
      end

      def Towers.diff first, second
        first.chars.reverse.each_with_index do |bit, index|
          if bit < second.chars.reverse[index]
            return index
          end
        end
      end
    end
  end
end
