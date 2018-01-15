module Hanoi
  module Jane
    module Formatters
      class Matrix < Array
        VALID_DIGITS = {
          '0' => [
            [1, 1, 1],
            [1, 0, 1],
            [1, 1, 1]
          ],

          '1' => [
            [0, 1, 0],
            [0, 1, 0],
            [0, 1, 0]
          ],

          '2' => [
            [1, 1, 0],
            [0, 1, 0],
            [0, 1, 1]
          ]
        }

        attr_accessor :stacks
        attr_reader   :digits

        def initialize
          @digits = '0'
          @stacks = [[]]

          @bit_offset = 24
          @bit_side = :right

          yield self if block_given?

          #populate
        end

        def digits= digits
          if digits.chars.reject { |d| VALID_DIGITS.keys.include? d }.length > 0
            raise MatrixException.new '%s is not a valid value for digits' % digits
          end

          if digits.length > 5
            raise MatrixException.new '%s is longer than 5 chars' % digits
          end

          @digits = digits
        end

        def wipe
          7.times do |i|
            self[i] = [0] * 45
          end
        end

        def draw_disc disc, height = 0, offset = 0
          if disc
            (disc + 1).times do |i|
              self[6 - height][i + offset + (Matrix.shim disc)] = 1
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

        def populate
          wipe
          draw_stacks
          draw_digits
        end

        def draw_stacks
          offset = 0
          @stacks.each do |stack|
            draw_stack stack, offset
            offset += 8
          end
        end

        def draw_digits
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
          @column = @bit_offset
          @row = 0
          if @bit_side == :right
            @column += 2
            @row = 4
          end

          insert value, @row, @column
        end

        def insert value, row = 0, column = 0
          3.times do |i|
            3.times do |j|
              self[row + i][column + j] = VALID_DIGITS[value][i][j]
            end
          end
        end

        def Matrix.shim size
          ((5 - (size + 1)) / 2).round
        end
      end

      class MatrixException < Exception
        attr_reader :text

        def initialize text
          @text = text
        end
      end
    end
  end
end
