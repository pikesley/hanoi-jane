module Hanoi
  module Jane
    class Towers
      extend RegularSearches

      attr_reader   :stacks, :total, :base, :disc, :from, :to
      attr_accessor :discs

      def initialize discs = 3
        @discs = discs
        @total = 0
        @base = 2
        @stacks = [(0...@discs).to_a.reverse, [], []]

        yield self if block_given?
      end

      def discs= discs
        @discs = discs
        @stacks = [(0...@discs).to_a.reverse, [], []]
      end

      def move
        before = binary
        @total += 1
        after = binary

        @disc = Towers.diff before, after

        @from = Towers.find_disc @stacks, @disc
        @to = self.class.find_stack stacks: @stacks, from: @from, disc: @disc, total: @total
        @stacks[@to].push @stacks[@from].pop
      end

      def solved
        rebased.chars.all? { |digit| digit.to_i == @base - 1 }
      end

      def inspect
        {
          stacks: @stacks,
          moves: @total,
          binary: rebased,
          moved: {
            disc: @disc,
            from: @from,
            to: @to
          }
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

      def Towers.diff this, that
        this.chars.reverse.each_with_index do |bit, index|
          if bit < that.chars.reverse[index]
          return index
          end
        end
      end

      def Towers.rebase value, base, width
        '%0*d' % [width, value.to_s(base)]
      end

      def Towers.find_disc stacks, disc
        stacks.each_with_index do |stack, index|
          return index if stack.index disc
        end

        raise SearchException.new '%s not found in stacks' % disc
      end
    end

    class SearchException < Exception
      attr_reader :text

      def initialize text
        @text = text
      end
    end
  end
end
