module Hanoi
  module Jane
    describe Towers do
      towers = Towers.new 3

      it 'has the correct initial content' do
        expect(towers.console).to eq "  o            \n ooo           \nooooo          \n"
      end

      it 'has the correct first-state content' do
        towers.move
        expect(towers.console).to eq "               \n ooo           \nooooo  o       \n"
      end

      it 'has the correct second-state content' do
        towers.move
        expect(towers.console).to eq "               \n               \nooooo  o   ooo \n"
      end

      context 'rotates the stacks' do
        it 'rotates the initsal state' do
          expect(Towers.rotate [[2, 1, 0], [nil, nil, nil], [nil, nil, nil]]).to eq [
            [0, nil, nil],
            [1, nil, nil],
            [2, nil, nil]
          ]
        end

        it 'rotates a trickier case' do
          expect(Towers.rotate)
        end
      end

      it 'pads an array' do
        expect(Towers.pad [0], 3).to eq [nil, nil, 0]
      end

      it 'makes a disc' do
        expect(Towers.make_disc 0, 5).to eq '  o  '
        expect(Towers.make_disc nil, 5). to eq '     '
      end

      it 'scales a size' do
        expect(Towers.scale 0).to eq 1
        expect(Towers.scale 1).to eq 3
        expect(Towers.scale 2).to eq 5
      end
    end
  end
end
