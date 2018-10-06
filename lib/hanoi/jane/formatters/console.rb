module Hanoi
  module Jane
    module Formatters
      class Console
        attr_accessor :stacks, :fancy

        def initialize
          @fancy = false

          yield self if block_given?
        end

        def to_s
          (Console.populate stacks, @fancy).map { |r| r.join '' }.join "\n"
        end

        def Console.assemble stacks
          a = []
          (Console.rotate stacks).each_with_index do |r, index|
            divided = (index + 1) == stacks.first.length ? true : false
            a.push Console.row r, widest: Console.biggest(stacks), divided: divided
          end

          a.push [:horiz_divider] * a[0].length

          a
        end

        def Console.populate stacks, fancy = false
          charset = fancy ? 'fancy' : 'regular'
          (Console.assemble stacks).map do
            |r| r.map do |c|
              Config.instance.config.chars[charset][c.to_s]
            end
          end
        end

        def Console.biggest stacks
          stacks.map { |s| s.compact.max }.compact.max
        end

        def Console.disc size, width
          return [:space] * Hanoi::Jane.scale(width) unless size
          content = Hanoi::Jane.scale size
          gap = (Hanoi::Jane.scale(width) - content) / 2

          output = [:disc] * content

          gap.times do
            [:unshift, :push].each do |method|
              output.send(method, :space)
            end
          end

          output
        end

        def Console.row starter, widest:, spacing: 1, divided: false
          filler = [:space] * spacing
          filler = [:vert_divider] if divided

          starter.map { |d|
            Console.disc d, widest
          }.flat_map { |d|
            [d, filler]
          }.unshift(filler).flatten
        end
        
        def Console.rotate stacks
          stacks.map { |s| s.clone }.transpose.reverse
        end
      end
    end
  end
end
