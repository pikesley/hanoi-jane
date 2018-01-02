module Hanoi
  module Jane
    class Towers
      include Enumerable

      attr_reader :total, :stacks, :discs

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
        Formatters::Matrix.new self
      end

      def console
        (Formatters::Console.new self).to_s
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
    end
  end
end
