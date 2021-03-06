module Hanoi
  module Jane
    describe RegularTowers do
      context 'constructor' do
        it 'has default values' do
          towers = RegularTowers.new 3
          expect(towers.base).to eq 2
        end

        it 'takes a block' do
          towers = RegularTowers.new do |t|
            t.discs = 4
          end
          expect(towers.discs).to eq 4
        end

        it 'makes a starter stack set' do
          expect(RegularTowers.starter_stacks 3).to eq [[2, 1, 0], [], []]
        end
      end

      context 'clone' do
        it 'deep-clones itself' do
          template = RegularTowers.new 3
          impression = template.clone

          template.stacks[0][0] = :bananas
          expect(impression.stacks[0][0]).to eq 2
        end
      end

      context 'JSON' do
        towers = RegularTowers.new do |t|
          t.discs = 2
        end
        it 'represents as JSON' do
          expect(towers.to_json).to eq '{"stacks":[[1,0],[],[]],"moves":0,"binary":"00","moved":{"disc":null,"from":null,"to":null}}'
        end
      end

      context 'find a disc' do
        stacks = [[2, 1], [0], []]

        it 'finds a valid disc' do
          expect(RegularTowers.find_disc stacks, 0).to eq 1
          expect(RegularTowers.find_disc stacks, 1).to eq 0
        end

        it 'barfs on a bad search' do
          expect { RegularTowers.find_disc stacks, 4 }.to raise_exception do |ex|
            expect(ex).to be_a SearchException
            expect(ex.text).to eq '4 not found in stacks'
          end
        end
      end

      context 'find a destination stack' do
        it 'finds the next-door stack' do
          stacks = [[2, 1, 0], [], []]
          expect(RegularTowers.find_stack stacks: stacks, from: 0, disc: 0).to eq 1
        end

        it 'finds the next-but-one stack' do
          stacks = [[2, 1], [0], []]
          expect(RegularTowers.find_stack stacks: stacks, from: 0, disc: 1).to eq 2
        end

        it 'wraps around correctly' do
          stacks = [[], [2], [1, 0]]
          expect(RegularTowers.find_stack stacks: stacks, from: 1, disc: 2).to eq 0
        end
      end

      context 'rebase a number' do
        it 'makes a binary string' do
          expect(RegularTowers.rebase 12, 2, 5).to eq '01100'
        end

        it 'makes a ternary string' do
          expect(RegularTowers.rebase 19, 3, 4).to eq '0201'
        end
      end

      context 'diff strings' do
        it 'diffs a binary string' do
          expect(RegularTowers.diff '001', '010').to eq 1
        end

        it 'diffs a ternary string' do
          expect(RegularTowers.diff '011', '012').to eq 0
        end
      end
    end
  end
end
