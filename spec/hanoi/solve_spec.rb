module Hanoi
  module Jane
    describe Towers do
      let(:towers) { Towers.new 12 }

      it 'follows the rules' do
        until towers.solved do
          towers.move
          towers.stacks.each do |stack|
            expect(stack.sort.reverse).to eq stack
          end
        end
      end
    end

    describe ConstrainedTowers do
      context 'follow the rules' do
        [2, 3, 4, 5, 6, 7, 8].each do |discs|
          it "plays by the rules with %s discs" % discs do
            towers = ConstrainedTowers.new discs
            goal = towers.stacks[0].clone
            until towers.solved do
              towers.move
              towers.stacks.each do |stack|
                expect(stack.sort.reverse).to eq stack
              end
            end

            expect(towers.stacks[2]).to eq goal
            expect(towers.count).to eq (3 ** discs) - 1
          end
        end
      end
    end
  end
end
