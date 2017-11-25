module Hanoi
  module Jane
    describe Towers do
      context 'follow the rules' do
        [2, 3, 4, 5, 6, 7, 8].each do |discs|
          towers = Towers.new discs
          goal = towers.stacks[0].clone

          it "plays by the rules with %s discs" % discs do
            until towers.solved do
              towers.move
              towers.stacks.each do |stack|
                expect(stack.sort.reverse).to eq stack
              end
            end
            expect(towers.stacks[2 - (discs % 2)]).to eq goal
            expect(towers.total).to eq (2 ** discs) - 1
          end
        end
      end

      context 'it knows when to stop' do
        towers = Towers.new 2

        it 'is not done yet' do
          towers.move
          towers.move
          expect(towers.solved).to eq false
        end

        it 'is done now' do
          towers.move
          expect(towers.solved).to eq true
        end
      end
    end

    describe ConstrainedTowers do
      context 'follow the rules' do
        [2, 3, 4, 5, 6, 7, 8].each do |discs|
          towers = ConstrainedTowers.new discs
          goal = towers.stacks[0].clone

          it "plays by the rules with %s discs" % discs do
            until towers.solved do
              towers.move
              towers.stacks.each do |stack|
                expect(stack.sort.reverse).to eq stack
              end
            end
            expect(towers.stacks[2]).to eq goal
            expect(towers.total).to eq (3 ** discs) - 1
          end
        end
      end
    end
  end
end
