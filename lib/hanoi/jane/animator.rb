module Hanoi
  module Jane
    class Animator
      def initialize towers
        puts towers.console
        @stacks = towers.stacks.clone.map { |s| s.clone }
        towers.move
        l = Lifter.new @stacks[towers.inspect[:moved][:from]]
        l.each do |lifting|
          @stacks[towers.inspect[:moved][:from]] = lifting.stack
          puts Formatters::Console.new towers.discs, @stacks, towers.fancy
        end

        # towers.each do |state|
        #   @stacks = towers.stacks.clone.map { |s| s.clone }
        #
        # end
      end

      class Lifter
        attr_reader :stack

        include Enumerable

        def initialize stack
          @stack = stack
          @lifted = false
        end

        def liftee
          z = nil
          @stack.reverse.each_with_index do |item, i|
            z = i
            break if item
          end

          @stack.length - z - 1
        end

        def lift
          @l = liftee unless @l
          mover = @stack[liftee]
          @stack[@l] = nil

          @l += 1

          if @l == @stack.length
            @lifted = true
          else
            @stack[@l] = mover
          end
        end

        def each
          until @lifted
            lift
            yield self
          end
        end
      end
    end
  end
end
