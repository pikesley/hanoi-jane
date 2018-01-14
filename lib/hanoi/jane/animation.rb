module Hanoi
  module Jane
    class Animation
      include Enumerable

      attr_reader :stacks

      def initialize towers
        @height = towers.discs
        @stacks = Animation.pad towers.old_stacks, @height
        @disc = towers.disc
        @source = towers.source
        @destination = towers.sink
        @fancy = towers.fancy

        @lift = true
        @drop = false
        @done = false
      end

      def animate
        @drop = true unless @lift
        if @lift
          stack = @stacks[@source]
          @position = stack.index @disc
          stack[@position] = nil

          if @position + 1 >= @height
            @lift = false
          else
            stack[@position + 1] = @disc
          end

          @stacks[@source] = stack
        end

        if @drop
          stack = @stacks[@destination]
          @position = -1 unless @position

          stack[@position] = @disc
          stack[(stack.index @disc) + 1] = nil

          @position -= 1

          @stacks[@destination] = stack.take @height

          if stack[@position] || @position == 0
            @drop = false
            @done = true
          end
        end
      end

      def to_s
        (Formatters::Console.new @height, @stacks, @fancy).to_s
      end

      def each
        until @done
          animate
          yield self
        end
      end

      def Animation.pad stacks, height
        stacks.map { |stack| stack + Array.new(height - stack.length) }
      end
    end
  end
end
