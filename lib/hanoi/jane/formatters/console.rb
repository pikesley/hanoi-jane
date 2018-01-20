module Hanoi
  module Jane
    module Formatters
      class Console
        attr_accessor :stacks

        CHARS = Config.instance.config.chars['regular']

        def initialize
          yield self if block_given?
        end

        def to_s
          require "pry" ; binding.pry
        end

        def Console.assemble stacks
          (Console.rotate stacks).map do |r|
            Console.row r, widest: Console.biggest(stacks)
          end
        end

        def Console.biggest stacks
          stacks.map { |s| s.compact.max }.compact.max
        end

        def Console.disc size, width
          return [CHARS['space']] * Console.scale(width) unless size
          content = Console.scale size
          gap = (Console.scale(width) - content) / 2

          output = [CHARS['disc']] * content

          gap.times do
            [:unshift, :push].each do |method|
              output.send(method, CHARS['space'])
            end
          end

          output
        end

        def Console.row starter, widest:, space: 1
          starter.map { |d|
            Console.disc d, widest
          }.flat_map { |d|
            [d, CHARS['space']]
          }.unshift(CHARS['space']).flatten
        end

        def Console.scale size
          (size * 2) + 1
        end

        def Console.rotate stacks
          stacks.map { |s| s.clone }.transpose.reverse
        end
      end
    end
  end
end
