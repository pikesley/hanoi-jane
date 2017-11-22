module Hanoi
  module Jane
    describe Towers do
      it 'diffs binary numbers' do
        expect(Towers.diff '000', '001').to eq 0
        expect(Towers.diff '001', '010').to eq 1
      end

      context 'diffs ternary numbers' do
        specify 'easy case' do
          expect(Towers.diff '001', '002').to eq 0
        end

        specify 'trickier case' do
          expect(Towers.diff '012', '020').to eq 1
        end
      end
    end
  end
end 
