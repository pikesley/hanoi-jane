module Hanoi
  module Jane
    class Animation

      # def animate
      #   @drop = true unless @lift
      #   if @lift
      #     stack = @stacks[@source]
      #     @position = stack.index @disc
      #     stack[@position] = nil
      #
      #     if @position + 1 >= @height
      #       @lift = false
      #     else
      #       stack[@position + 1] = @disc
      #     end
      #
      #     @stacks[@source] = stack
      #   end
      #
      #   if @drop
      #     stack = @stacks[@destination]
      #     @position = -1 unless @position
      #
      #     stack[@position] = @disc
      #     stack[(stack.index @disc) + 1] = nil
      #
      #     @position -= 1
      #
      #     @stacks[@destination] = stack.take @height
      #
      #     if stack[@position] || @position == 0
      #       @drop = false
      #       @done = true
      #     end
      #   end
      # end
    end
  end
end
