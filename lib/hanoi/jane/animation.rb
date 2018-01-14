module Hanoi
  module Jane
    class Animation
      include Enumerable

      attr_reader :stacks

      def initialize stacks, disc, source, destination, height
        @height = height
        @stacks = Animation.pad stacks, @height
        @disc = disc
        @source = source
        @destination = destination

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
