module Hanoi
  module Jane
    class AnimatedTowers
      include Enumerable

      attr_accessor :towers, :discs, :height

      def initialize
        yield self if block_given?

        if @discs > @height
          raise HanoiException.new 'number_of_discs (%d) > height (%d)' % [@discs, @height]
        end

        @towers = @towers.new @discs
      end

      def each
        until @towers.solved
          stacks = PaddedStacks.new @towers.stacks, @height
          value = @towers.rebased
          @towers.move
          yield Frame.new stacks, value, :key

          @anim = Animation.new do |a|
            a.stacks = stacks
            a.disc = @towers.disc
            a.from = @towers.from
            a.to = @towers.to
            a.height = @height
          end

          @anim.each do |frame|
            yield Frame.new frame.stacks, @towers.rebased, :tween
          end
        end

        yield Frame.new (PaddedStacks.new @towers.stacks, @height), @towers.rebased, :key
      end
    end

    class Frame
      attr_reader :stacks, :type, :value

      def initialize stacks, value, type
        @stacks = stacks
        @value = value
        @type = type
      end
    end
  end
end
