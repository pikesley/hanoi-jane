module Hanoi
  module Jane
    module Formatters
      class Matrix < Array
        def initialize towers
          @stacks = towers.stacks
          @digits = towers.rebased

          populate
        end

        def stacks= stacks
          @stacks = stacks
          populate
        end

        def populate
          7.times do |i|
            self[i] = [0] * 45
          end

          offset = 0
          @stacks.each do |stack|
            total = 0
            stack.each do |disc|
              if disc
                shim = ((5 - (disc + 1)) / 2).round
                (disc + 1).times do |i|
                  self[6 - total][i + offset + shim] = 1
                end
              end
              total += 1
            end
            offset += 8
          end

          @bit_offset = 24
          @bit_side = :right
          @digits.chars.each do |bit|
            digit bit

            if @bit_side == :right
              @bit_side = :left
              @bit_offset += 8
            else
              @bit_side = :right
            end
          end
        end

        def digit value
          digits = {
            0 => [
              [1, 1, 1],
              [1, 0, 1],
              [1, 1, 1]
            ],

            1 => [
              [0, 1, 0],
              [0, 1, 0],
              [0, 1, 0]
            ],

            2 => [
              [1, 1, 0],
              [0, 1, 0],
              [0, 1, 1]
            ]
          }

          @column = @bit_offset
          @row = 0
          if @bit_side == :right
            @column += 2
            @row = 4
          end

          insert digits[value.to_i]

        end

        def insert grid
          3.times do |i|
            3.times do |j|
              self[@row + i][@column + j] = grid[i][j]
            end
          end
        end
      end
    end
  end
end
