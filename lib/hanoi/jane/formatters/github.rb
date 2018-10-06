module Hanoi
  module Jane
    module Formatters
      class Github < Array
        attr_accessor :stacks

        def initialize towers
          @stacks = towers.stacks

          populate
        end

        def draw_disc disc, height = 0, offset = 0
          if disc
            width = Hanoi::Jane.scale disc
            shim = (15 - width) / 2
            (width).times do |i|
              self[6 - height][i + offset + shim] = 8
            end
          end
        end

        def draw_stack stack, offset = 0
          height = 0
          stack.each do |disc|
            draw_disc disc, height, offset
            height += 1
          end
        end

        def wipe
          7.times do |i|
            self[i] = [0] * 52
          end
        end

        def populate
          wipe
          draw_spindles
          draw_stacks
        end

        def draw_spindles
          self.map do |row|
            offset = 8
            3.times do
              row[offset] = 1
              offset += 16
            end
          end
        end

        def draw_stacks
          offset = 1
          @stacks.each do |stack|
            draw_stack stack, offset
            offset += 16
          end
        end
      end
    end
  end
end
