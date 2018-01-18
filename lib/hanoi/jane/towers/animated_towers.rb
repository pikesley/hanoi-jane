module Hanoi
  module Jane
    class AnimatedTowers
      include Enumerable

      attr_accessor :towers, :discs, :height

      def initialize
        yield self if block_given?

        @towers = @towers.new @discs
      end

      def each
        until @towers.solved
          stacks = PaddedStacks.new @towers.stacks, @height

          @towers.move
          yield Frame.new stacks, :key

          @anim = Animation.new do |a|
            a.stacks = stacks
            a.disc = @towers.disc
            a.from = @towers.source
            a.to = @towers.sink
            a.height = @height
          end

          @anim.each do |frame|
            yield Frame.new frame.stacks, :tween
          end
        end

        yield Frame.new (PaddedStacks.new @towers.stacks, @height), :key
      end
    end

    class Frame
      attr_reader :stacks, :type
      def initialize stacks, type
        @stacks = stacks
        @type = type
      end

      def to_s
        "%5s: %s" % [@type, @stacks.inspect]
      end
    end
  end
end
