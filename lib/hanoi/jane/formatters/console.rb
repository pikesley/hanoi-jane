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
          (Console.assemble stacks).map { |r| r.join '' }.join "\n"
        end

        def Console.assemble stacks
          a = []
          (Console.rotate stacks).each_with_index do |r, index|
            divided = (index + 1) == stacks.first.length ? true : false
            a.push Console.row r, widest: Console.biggest(stacks), divided: divided
          end

          a.push ['-'] * a[0].length

          a
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

        def Console.row starter, widest:, spacing: 1, divided: false
          filler = [CHARS['space']] * spacing
          filler = [CHARS['vert_divider']] if divided
          starter.map { |d|
            Console.disc d, widest
          }.flat_map { |d|
            [d, filler]
          }.unshift(filler).flatten
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
