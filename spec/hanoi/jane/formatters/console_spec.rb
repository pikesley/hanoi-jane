module Hanoi
  module Jane
    module Formatters
      describe Console do
        context 'rotations' do
          {
            [[2, 1, 0], [nil, nil, nil], [nil, nil, nil]] =>
            [[0, nil, nil], [1, nil, nil], [2, nil, nil]],
            [[2, 1, nil], [0, nil, nil], [nil, nil, nil]] =>
            [[nil, nil, nil], [1, nil, nil], [2, 0, nil]],
            [[2, nil, nil], [0, nil, nil], [1, nil, nil]] =>
            [[nil, nil, nil], [nil, nil, nil], [2, 0, 1]]
          }.each_pair do |state, rotation|
            it 'rotates %s' % [state] do
              expect(Console.rotate state).to eq rotation
            end
          end
        end

        context 'make rows' do
          context 'make discs' do
            {
              {disc: 0, width: 2} => [:space, :space, :disc, :space, :space],
              {disc: 1, width: 2} => [:space, :disc, :disc, :disc, :space]
            }.each do |args, disc|
              it 'makes a %d disc for a max width of %d' % [args[:disc], args[:width]] do
                expect(Console.disc args[:disc], args[:width]).to eq disc
              end
            end

            it 'makes a blank space' do
              expect(Console.disc nil, 2).to eq [:space, :space, :space, :space, :space]
            end
          end

          it 'makes a simple row' do
            expect(Console.row [0, nil, nil], widest: 2).to eq (
              [:space, :space, :space, :disc, :space, :space, :space, :space, :space, :space, :space, :space, :space, :space, :space, :space, :space, :space, :space]
            )
          end

          it 'makes a row with different spacing' do
            expect(Console.row [0, nil, nil], widest: 0, spacing: 3).to eq (
              [:space, :space, :space, :disc, :space, :space, :space, :space, :space, :space, :space, :space, :space, :space, :space]
            )
          end

          it 'makes a row with dividers' do
            expect(Console.row [0, nil, nil], widest: 1, divided: true).to eq (
              [:vert_divider, :space, :disc, :space, :vert_divider, :space, :space, :space, :vert_divider, :space, :space, :space, :vert_divider]
            )
          end

          it 'makes a row with dividers and different spacing'
        end

        it 'scales a size' do
          expect(Console.scale 0).to eq 1
          expect(Console.scale 1).to eq 3
          expect(Console.scale 2).to eq 5
        end

        context 'assemble layout' do
          it 'finds the largest member of a stack set' do
            expect(Console.biggest [[2, 1], [0, nil], [nil, nil]]).to eq 2
          end

          it 'makes a layout' do
            expect(Console.assemble [[1, 0], [nil, nil], [nil, nil]]).to eq [
              [' ', ' ', 'o', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
              ['|', 'o', 'o', 'o', '|', ' ', ' ', ' ', '|', ' ', ' ', ' ', '|'],
              ['-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-']
            ]
          end

          it 'makes another layout' do
            expect(Console.assemble [[2, 1, nil], [nil, nil, nil], [0, nil, nil]]).to eq [
              [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
              [' ', ' ', 'o', 'o', 'o', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
              ['|', 'o', 'o', 'o', 'o', 'o', '|', ' ', ' ', ' ', ' ', ' ', '|', ' ', ' ', 'o', ' ', ' ', '|'],
              ['-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-']
            ]
          end
        end

        context 'as a string' do
          it 'produces a string artefact' do
            console = Console.new do |c|
              c.stacks = [[2, nil, nil], [1, nil, nil], [0, nil, nil]]
            end
            expect(console.to_s).to eq "                   \n                   \n|ooooo| ooo |  o  |\n-------------------"
          end

          it 'produces a fancy string' do
            console = Console.new do |c|
              c.stacks = [[2, nil, nil], [1, nil, nil], [0, nil, nil]]
              c.fancy = true
            end

            expect(console.to_s).to eq "                   \n                   \n🔺🎾🎾🎾🎾🎾🔺 🎾🎾🎾 🔺  🎾  🔺\n🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻"
          end
        end
      end
    end
  end
end
