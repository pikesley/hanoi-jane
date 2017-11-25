module Hanoi
  module Jane
    describe Towers do
      it 'exposes an iterator' do
        towers = Towers.new 3
        goal = towers.stacks[0].clone

        towers.each do |state|
          towers.stacks.each do |stack|
            expect(stack.sort.reverse).to eq stack
          end
        end
        expect(towers.stacks[1]).to eq goal
        expect(towers.total).to eq 7
      end
    end

    describe ConstrainedTowers do
      it 'exposes an iterator' do
        towers = ConstrainedTowers.new 4
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
