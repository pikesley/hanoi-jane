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
            t.discs = 3
          end
          expect(towers.discs).to eq 3
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
          expect(Towers.find_stack stacks, 0, 0, 0).to eq 1

        end
      end
    end
  end
end
