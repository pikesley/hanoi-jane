module Hanoi
  module Jane
    describe Towers do
      towers = Towers.new 3

      it 'has the correct initial content' do
        expect(towers.console).to eq "   o                   \n  ooo                  \n ooooo                 \n"
      end

      it 'has the correct first-state content' do
        towers.move
        expect(towers.console).to eq "                       \n  ooo                  \n ooooo     o           \n"
      end

      it 'has the correct second-state content' do
        towers.move
        expect(towers.console).to eq "                       \n                       \n ooooo     o      ooo  \n"
      end
    end

    describe Console do
      it 'rotates the initial state' do
        expect(Console.rotate [[2, 1, 0], [nil, nil, nil], [nil, nil, nil]]).to eq [
          [0, nil, nil],
          [1, nil, nil],
          [2, nil, nil]
        ]
      end

      it 'rotates the first state' do
        expect(Console.rotate [[2, 1, nil], [0, nil, nil], [nil, nil, nil]]).to eq [
          [nil, nil, nil],
          [1, nil, nil],
          [2, 0, nil]
        ]
      end

      it 'rotates the second state' do
        expect(Console.rotate [[2, nil, nil], [0, nil, nil], [1, nil, nil]]).to eq [
          [nil, nil, nil],
          [nil, nil, nil],
          [2, 0, 1]
        ]
      end

      it 'pads an array' do
        expect(Console.pad [0], 3).to eq [nil, nil, 0]
      end

      it 'makes a disc' do
        expect(Console.make_disc 0, 5).to eq '  o  '
        expect(Console.make_disc nil, 5). to eq '     '
      end

      it 'scales a size' do
        expect(Console.scale 0).to eq 1
        expect(Console.scale 1).to eq 3
        expect(Console.scale 2).to eq 5
      end
    end
  end
end
