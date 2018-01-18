module Hanoi
  module Jane
    module Formatters
      describe Matrix do
        context 'constructor' do
          it 'has default values' do
            matrix = Matrix.new
            expect(matrix.digits).to eq '0'
            expect(matrix.stacks).to eq [[]]
          end

          it 'takes a block' do
            matrix = Matrix.new do |m|
              m.stacks = [[2, 1, 0], [], []]
              m.digits = '000'
            end

            expect(matrix.digits).to eq '000'
            expect(matrix.stacks).to eq [[2, 1, 0], [], []]
          end
        end

        context 'digits' do
          matrix = Matrix.new

          ['00', '01', '2001'].each do |number|
            it 'accepts %s as valid' % number do
              expect { matrix.digits = number }.to_not raise_exception
            end
          end

          ['123', 'abc', '0xDEAD'].each do |string|
            it 'rejects %s as invalid' % string do
              expect { matrix.digits = string }.to raise_exception do |ex|
                expect(ex).to be_a MatrixException
                expect(ex.text).to eq '%s is not a valid value for digits' % string
              end
            end
          end

          it 'rejects 121212 as too long' do
            expect { matrix.digits = '121212' }.to raise_exception do |ex|
              expect(ex).to be_a MatrixException
              expect(ex.text).to eq '121212 is longer than 5 chars'
            end
          end
        end

        context 'populate grid' do
          matrix = Matrix.new do |m|
            m.stacks = [[4, 3, 2, 1, 0], [], []]
            m.digits = '00000'
          end

          it 'wipes the slate before we begin' do
            matrix.wipe
            # this is a super-elaborate way to check that every value is a zero
            expect(matrix.map { |row| row.all? { |digit| digit == 0} }.all? { |b| b } ).to be true
          end

          context 'stacks' do
            shims = [2, 1, 1, 0, 0].each_with_index do |shim, size|
              it 'makes a size-%d shim for a size-%d disc' % [size, shim] do
                expect(Matrix.shim size).to eq shim
              end
            end

            it 'draws a disc' do
              matrix.draw_disc 4
              expect(matrix[6][0..5]).to eq [1, 1, 1, 1, 1, 0]
            end

            it 'draws a stack' do
              matrix.wipe
              matrix.draw_stack [1, 0]
              expect(matrix[5..6].map { |a| a[0..5] }).to eq [
                [0, 0, 1, 0, 0, 0],
                [0, 1, 1, 0, 0, 0]
              ]
            end
          end

          context 'digit grids' do
            it 'inserts a 0' do
              matrix.wipe
              matrix.insert '0'
              expect(matrix[0..2].map { |a| a[0..2] }).to eq [
                [1, 1, 1],
                [1, 0, 1],
                [1, 1, 1]
              ]
            end

            it 'inserts a 2 with an offset' do
              matrix.wipe
              matrix.insert '2', 1, 3
              expect(matrix[1..3].map { |a| a[3..5] }).to eq [
                [1, 1, 0],
                [0, 1, 0],
                [0, 1, 1]
              ]
            end
          end

          context 'alignment' do
            it 'switches left to eight' do
              expect(matrix.realign :left).to eq :right
            end

            it 'moves the offset when switching right to left' do
              offset = matrix.bit_offset
              expect(matrix.realign :right).to eq :left
              expect(matrix.bit_offset).to eq offset + 8
            end
          end
        end

        context 'lights' do
          it 'has the correct matrix' do
            matrix = Matrix.new do |m|
              m.stacks = [[4, 3, 2, 1, 0], [], []]
              m.digits = '00000'
            end

            matrix.populate

            expect(matrix).to eq [
              [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0],
              [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0],
              [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0],
              [0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
              [0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1],
              [1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1],
              [1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1]
            ]
          end
        end
      end
    end
  end
end
