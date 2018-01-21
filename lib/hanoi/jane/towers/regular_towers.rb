module Hanoi
  module Jane
    class RegularTowers
      include Enumerable

      extend StackFinder

      attr_reader   :total, :base, :disc, :from, :to, :discs
      attr_accessor :stacks

      def initialize discs = 3
        @discs = discs
        @total = 0
        @base = 2
        @stacks = self.class.starter_stacks @discs

        yield self if block_given?
      end

      def discs= discs
        @discs = discs
        @stacks = self.class.starter_stacks @discs
      end

      def move
        before = binary
        @total += 1
        after = binary

        @disc = self.class.diff before, after

        @from = self.class.find_disc @stacks, @disc
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

      def clone
        c = self.dup
        c.stacks = self.stacks.clone.map { |s| s.clone }
        c
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

      def to_json
        inspect.to_json
      end

      def binary
        rebased
      end

      def rebased
        self.class.rebase @total, @base, @discs
      end

      def RegularTowers.starter_stacks discs
        [(0...discs).to_a.reverse, [], []]
      end

      def RegularTowers.diff this, that
        this.chars.reverse.each_with_index do |bit, index|
          if bit < that.chars.reverse[index]
          return index
          end
        end
      end

      def RegularTowers.rebase value, base, width
        '%0*d' % [width, value.to_s(base)]
      end

      def RegularTowers.find_disc stacks, disc
        stacks.each_with_index do |stack, index|
          return index if stack.index disc
        end

        raise SearchException.new '%s not found in stacks' % disc
      end
    end
  end
end
