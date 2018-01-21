module Hanoi
  module Jane
    describe RegularTowers do
      it 'exposes an iterator' do
        towers = RegularTowers.new 3

        goal = towers.stacks[0].clone

        towers.each do |state|
          towers.stacks.each do |stack|
            expect(stack.sort.reverse).to eq stack
          end
        end
        expect(towers.stacks[1]).to eq goal
        expect(towers.total).to eq 7
      end

      it 'responds to #map' do
        towers = RegularTowers.new do |t|
          t.discs = 2
        end

        expect(towers.map { |state| state.inspect }).to eq [
          {stacks: [[], [], [1, 0]], moves: 0, binary: '00', moved: {disc: nil, from: nil, to: nil}},
          {stacks: [[], [], [1, 0]], moves: 1, binary: '01', moved: {disc: 0, from: 0, to: 1}},
          {stacks: [[], [], [1, 0]], moves: 2, binary: '10', moved: {disc: 1, from: 0, to: 2}},
          {stacks: [[], [], [1, 0]], moves: 3, binary: '11', moved: {disc: 0, from: 1, to: 2}}
        ]
      end
    end

    describe ConstrainedTowers do
      it 'exposes an iterator' do
        towers = ConstrainedTowers.new do |t|
          t.discs = 4
        end
        goal = towers.stacks[0].clone

        towers.each do |state|
          towers.stacks.each do |stack|
            expect(stack.sort.reverse).to eq stack
          end
        end
        expect(towers.stacks[2]).to eq goal
        expect(towers.total).to eq 80
      end
    end
  end
end
