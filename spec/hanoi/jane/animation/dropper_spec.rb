module Hanoi
  module Jane
    describe Dropper do
      context 'find the position to insert the item' do
        it 'inserts at the top if the item is not present' do
          expect(Dropper.position [1, nil, nil], 0).to eq 2
        end

        it 'inserts below an already-present item' do
          expect(Dropper.position [1, nil, 0], 0).to eq 1
        end
      end

      context 'drop an item' do
        d = Dropper.new [1, nil, nil], 0

        [
          [1, nil, 0],
          [1, 0, nil]
        ].each_with_index do |state, index|
          specify 'state #%d is correct' % index do
            d.drop
            expect(d).to eq state
          end
        end
      end

      context 'iterator' do
        d = Dropper.new [2, 1, nil, nil, nil], 0

        it 'exposes an iterator' do
          count = 1
          d.each do
            count += 1
          end
          expect(count).to eq 3
        end
      end
    end
  end
end
