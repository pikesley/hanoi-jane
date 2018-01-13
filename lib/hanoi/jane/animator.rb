module Hanoi
  module Jane
    class Animator
      def initialize towers, delay = 0.1
        @towers = towers
        @delay = delay
      end

      def run
        until @towers.solved do
          system('clear')
          puts @towers.console
          sleep @delay

          @stacks = @towers.stacks.clone.map { |s| s.clone }
          @towers.move
          l = Lifter.new @stacks[@towers.inspect[:moved][:from]], @towers.discs

          l.each do |lifting|
            @stacks[@towers.inspect[:moved][:from]] = lifting.stack
            system('clear')
            puts Formatters::Console.new @towers.discs, @stacks, @towers.fancy
            sleep @delay
          end

          d = Dropper.new @stacks[@towers.inspect[:moved][:to]], @towers.discs, @towers.inspect[:moved][:disc]
          d.each do |dropping|
            @stacks[@towers.inspect[:moved][:to]] = dropping.stack
            system('clear')
            puts Formatters::Console.new @towers.discs, @stacks, @towers.fancy
            sleep @delay
          end
        end

        system('clear')
        puts @towers.console
      end

      def self.pad stack, length
        stack + Array.new(length - stack.length)
      end

      class Lifter
        attr_reader :stack

        include Enumerable

        def initialize stack, discs
          @stack = Animator.pad stack, discs
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

      class Dropper
        attr_reader :stack

        include Enumerable

        def initialize stack, discs, droppee
          @size = stack.length
          @stack = Animator.pad stack, discs
          @droppee = droppee
          @position = @stack.length
        end

        def dropped
          @position - @size <= 1
        end

        def drop
          @stack[@position] = nil if @position < @stack.length
          @position -= 1
          @stack[@position] = @droppee
        end

        def each
          until dropped
            drop
            yield self
          end
        end
      end
    end
  end
end
