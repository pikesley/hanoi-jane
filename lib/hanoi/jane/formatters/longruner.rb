module Hanoi
  module Jane
    module Formatters
      class Longruner < Array
        attr_accessor :stacks

        def initialize
          @stacks = [[]]

          yield self if block_given?

          populate
        end

        def populate
          wipe
          draw_poles
          draw_stacks
        end

        def wipe
          8.times do |i|
            self[i] = [:none] * 32
          end
        end

        def draw_disc disc, elevation = 0, offset = 0
          if disc
            ((disc * 2) + 3).times do |i|
              self[7 - elevation][i + offset] = :disc
            end
          end
        end

        def draw_stack stack, offset = 0
          elevation = 0
          stack.each do |disc|
            if disc
              draw_disc disc, elevation, offset + (9 - ((disc * 2) + 3)) / 2
            end
            elevation += 1
          end
        end

        def draw_stacks
          offset = 0
          @stacks.each do |stack|
            draw_stack stack, offset
            offset += 11
          end
        end

        def draw_poles
          7.times do |i|
            self[i + 1] = [:none] * 4 + [:pole] + [:none] * 10 + [:pole] + [:none] * 10 + [:pole] + [:none] * 5
          end
        end

        def colourised disc_colour, pole_colour
          colours = {
            pole: pole_colour,
            disc: disc_colour,
            none: [0, 0, 0]
          }

          self.map { |row| row.map { |item| colours[item] } }
        end
      end
    end
  end
end
