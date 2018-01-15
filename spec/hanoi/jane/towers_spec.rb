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
    end
  end
end
