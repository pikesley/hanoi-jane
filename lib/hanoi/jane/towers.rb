module Hanoi
  module Jane
    class Towers
      attr_reader :count, :stacks

      def initialize discs
        @discs = discs
        @count = 0
        @binary = Towers.binarise @count, @discs
        @stacks = [(0...discs).to_a.reverse, [], []]
      end

      def move
        flip = Towers.diff Towers.binarise(@count, @discs),
                           Towers.binarise(@count += 1, @discs)
        source = Towers.find_disc flip, @stacks

        @stacks[Towers.find_stack flip, source, @stacks].push @stacks[source].pop
      end

      def binary
        Towers.binarise @count, @discs
      end

      def solved
        binary.chars.all? { |bit| bit.to_i == 1 }
      end

      def matrix
        matrix = []
        7.times do
          matrix.push [0] * 45
        end

        bit_offset = 0
        bit_side = :right
        binary.chars.each do |bit|
          little_bit bit, matrix, 24 + bit_offset, bit_side

          if bit_side == :right
            bit_side = :left
            bit_offset += 8
          else
            bit_side = :right
          end
        end

        offset = 0
        @stacks.each do |stack|
          count = 0
          stack.each do |disc|
            shim = ((5 - (disc + 1)) / 2).round
            (disc + 1).times do |i|
              matrix[6 - count][i + offset + shim] = 1
            end
            count += 1
          end
          offset += 8
        end

        matrix
      end

      def little_bit value, matrix, offset, side
        column = offset + 1
        row = 0
        if side == :right
          column = offset + 3
          row = 4
        end

        case value.to_i
        when 0
          3.times do |i|
            (-1..1).each do |j|
              matrix[row + i][column + j] = 1
            end
          end
          matrix[row + 1][column] = 0
        when 1
          for i in (row..row + 2) do
            matrix[i][column] = 1
          end
        when 2
          for i in (row..row + 2) do
            matrix[i][column] = 1
          end
          matrix[row][column - 1] = 1
          matrix[row + 2][column + 1] = 1
        end
      end

      def inspect
        {
          stacks: @stacks,
          count: binary
        }
      end

      def Towers.binarise value, width
        '%0*b' % [width, value]
      end

      def Towers.diff first, second
        first.chars.reverse.each_with_index do |bit, index|
          if bit < second.chars.reverse[index]
            return index
          end
        end
      end

      def Towers.find_disc needle, stacks
        stacks.each_with_index do |stack, index|
          return index if stack.index needle
        end
      end

      def Towers.find_stack disc, source, stacks
        if stacks[(source + 1) % 3] == []
          return (source + 1) % 3
        end

        if stacks[(source + 1) % 3][-1] < disc
          return (source + 2) % 3
        end

        return (source + 1) % 3
      end
    end
  end
end
