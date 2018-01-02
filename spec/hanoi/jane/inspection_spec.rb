module Hanoi
  module Jane
    describe Towers do
      it 'exposes its state nicely' do
        towers = Towers.new 3
        towers.move
        expect(towers.inspect).to eq ({
          stacks: [
            [2, 1],
            [0],
            []
          ],
          moves: 1,
          binary: '001',
          moved: 0
        })
      end
    end

    describe ConstrainedTowers do
      it 'exposes its state nicely' do
        towers = ConstrainedTowers.new 3
        towers.move
        towers.move
        towers.move
        expect(towers.inspect).to eq ({
          stacks: [
            [2],
            [1],
            [0]
          ],
          moves: 3,
          ternary: '010',
          moved: 1          
        })
      end
    end
  end
end
