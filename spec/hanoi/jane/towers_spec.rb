module Hanoi
  module Jane
    describe Towers do
      context 'constructor' do
        it 'has default values' do
          towers = Towers.new 3
          expect(towers.base).to eq 2
        end

        it 'takes a block' do
          towers = Towers.new do |t|
            t.discs = 4
          end
          expect(towers.discs).to eq 4
        end
      end

      context 'find a disc' do
        stacks = [[2, 1], [0], []]

        it 'finds a valid disc' do
          expect(Towers.find_disc stacks, 0).to eq 1
          expect(Towers.find_disc stacks, 1).to eq 0
        end

        it 'barfs on a bad search' do
          expect { Towers.find_disc stacks, 4 }.to raise_exception do |ex|
            expect(ex).to be_a SearchException
            expect(ex.text).to eq '4 not found in stacks'
          end
        end
      end

      context 'find a destination stack' do
        it 'finds the next-door stack' do
          stacks = [[2, 1, 0], [], []]
          expect(Towers.find_stack stacks: stacks, source: 0, disc: 0).to eq 1
        end

        it 'finds the next-but-one stack' do
          stacks = [[2, 1], [0], []]
          expect(Towers.find_stack stacks: stacks, source: 0, disc: 1).to eq 2
        end

        it 'wraps around correctly' do
          stacks = [[], [2], [1, 0]]
          expect(Towers.find_stack stacks: stacks, source: 1, disc: 2).to eq 0
        end
      end

      context 'rebase a number' do
        it 'makes a binary string' do
          expect(Towers.rebase 12, 2, 5).to eq '01100'
        end

        it 'makes a ternary string' do
          expect(Towers.rebase 19, 3, 4).to eq '0201'
        end
      end

      context 'diff strings' do
        it 'diffs a binary string' do
          expect(Towers.diff '001', '010').to eq 1
        end

        it 'diffs a ternary string' do
          expect(Towers.diff '011', '012').to eq 0
        end
      end
    end
  end
end
