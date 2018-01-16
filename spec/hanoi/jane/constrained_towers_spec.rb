module Hanoi
  module Jane
    describe ConstrainedTowers do
      context 'constructor' do
        it 'has default values' do
          towers = ConstrainedTowers.new 3
          expect(towers.base).to eq 3
        end

        it 'takes a block' do
          towers = ConstrainedTowers.new do |t|
            t.discs = 3
          end
          expect(towers.discs).to eq 3
        end
      end

      context 'find a destination stack' do
        it 'moves from the right to the middle' do
          stacks = [[2, 1], [], [0]]
          expect(ConstrainedTowers.find_stack stacks: stacks, source: 2, total: 0).to eq 1
        end

        it 'moves from the left to the middle' do
          stacks = [[2, 1], [], [0]]
          expect(ConstrainedTowers.find_stack stacks: stacks, source: 0, total: 0).to eq 1
        end

        it 'moves left on an odd total' do
          stacks = [[], [2], [1, 0]]
          expect(ConstrainedTowers.find_stack stacks: stacks, source: 1, total: 3).to eq 0
        end

        it 'moves right on an odd total' do
          stacks = [[1, 0], [2], []]
          expect(ConstrainedTowers.find_stack stacks: stacks, source: 1, total: 6).to eq 2
        end
      end
    end
  end
end
