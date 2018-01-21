module Hanoi
  module Jane
    module Formatters
      class Matrix < Array
        attr_accessor :stacks
        attr_reader   :digits, :bit_offset

        def initialize
          @digits = '0'
          @stacks = [[]]

          @bit_offset = 24
          @bit_side = :right
          @valid_digits = Config.instance.config.digits

          yield self if block_given?

          #populate
        end

        def digits= digits
          if digits.chars.reject { |d| @valid_digits.keys.include? d }.length > 0
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
            @bit_side = realign @bit_side
          end
        end

        def realign side
          if side == :right
            @bit_offset += 8
            return :left
          end
          :right
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
              self[row + i][column + j] = @valid_digits[value][i][j]
            end
          end
        end

        def Matrix.shim size
          ((5 - (size + 1)) / 2).round
        end
      end
    end
  end
end
