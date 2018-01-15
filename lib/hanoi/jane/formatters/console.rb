module Hanoi
  module Jane
    module Formatters
      class Console
        attr_accessor :height
        attr_reader   :stacks

        @@chars = Config.instance.config.chars['regular']

        def initialize
          @height = 0

          yield self if block_given?
        end

        def stacks= stacks
          @stacks = stacks.clone.map { |s| s.clone }
        end

        # def fancy= fancy
        #   @@chars = Config.instance.config.chars.fancy if fancy
        # end

        def to_s
          s = ''
          joiner = @@chars['space']

          (Console.rotate @stacks.map { |s| (Console.pad s, @discs).reverse }).each_with_index do |stack, i|
            joiner = @@chars['vert_divider'] if i == @discs

            s += "%s%s%s\n" % [
              joiner,
              stack.map { |s| Console.make_disc s, (Console.scale @discs) }.join(joiner),
              joiner
            ]

          end

          s += "%s\n" % [@@chars['horiz_divider'] * (4 + (Console.scale @discs) * 3)]
        end

        def Console.pad array, length
          Array.new(length - array.length) + array.reverse
        end

        def Console.make_disc width, space
          char = @@chars['disc']
          unless width
            width = 0
            char = @@chars['pole']
          end

          count = Console.scale width
          padding = (space - count) / 2

          '%s%s%s' % [
            @@chars['space'] * padding,
            char * count,
            @@chars['space'] * padding
          ]
        end

        def Console.scale size
          (size * 2) + 1
        end

        def Console.rotate stacks
          stacks.map { |s| s.clone }.transpose.reverse
        end

        def Console.fancify number
          fancy_digits = '012'
          number.chars.map { |d| fancy_digits[d] }.join ' '
        end
      end
    end
  end
end
