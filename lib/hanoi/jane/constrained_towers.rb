module Hanoi
  module Jane
    class ConstrainedTowers < Towers
      def initialize discs
        super
        @ternary = ConstrainedTowers.ternarise @count, @discs
        @directions = {}
        @stacks[0].each do |disc|
          @directions[disc] = :right
        end
      end

      def move
        @flip = Towers.diff ConstrainedTowers.ternarise(@count, @discs),
                           ConstrainedTowers.ternarise(@count += 1, @discs)
        @source = find_disc

        @stacks[find_stack].push @stacks[@source].pop
      end

      def find_disc
        @stacks.each_with_index do |stack, index|
          return index if stack.index @flip
        end
      end

      def find_stack
        case @source
        when 0
          @directions[@flip] = :right
          return 1
        when 2
          @directions[@flip] = :left
          return 1
        when 1
          if @directions[@flip] == :right
            return 2
          else
            return 0
          end
        end
      end

      def binary
        ternary
      end

      def ternary
        ConstrainedTowers.ternarise @count, @discs
      end

      def solved
        ternary.chars.all? { |trit| trit.to_i == 2 }
      end

      def inspect
        {
          stacks: @stacks,
          count: ternary
        }
      end

      def ConstrainedTowers.ternarise value, width
        '%0*d' % [width, value.to_s(3)]
      end
    end
  end
end
