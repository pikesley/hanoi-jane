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

        it 'drops one position' do
          d.drop
          expect(d).to eq [1, nil, 0]
        end

        it 'does nothing when there is only a single space at the top' do
          d = Dropper.new [2, 1, nil], 0

          count = 0
          d.each do
            count += 1
          end
          expect(count).to eq 0
          expect(d).to eq [2, 1, nil]
        end

        it 'stops dropping one position above the bottom' do
          d = Dropper.new [2, nil, nil, nil, nil], 1

          d.each do
            next
          end
          expect(d).to eq [2, nil, 1, nil, nil]
        end

        context 'drop all the way if we tell it to' do
          it 'drops as far as it can' do
            d = Dropper.new [1, nil, nil, nil], 0, true

            count = 0
            d.each do
              count += 1
            end
            expect(count).to eq 3
            expect(d).to eq [1, 0, nil, nil]
          end

          it 'drops all the way' do
            d = Dropper.new [nil, nil, nil, nil], 2, true

            count = 0
            d.each do
              puts d.inspect
              count += 1
            end
            expect(count).to eq 4
            expect(d).to eq [2, nil, nil, nil]
          end
        end
      end

      context 'iterator' do
        d = Dropper.new [2, 1, nil, nil, nil, nil, nil], 0

        it 'exposes an iterator' do
          count = 0
          d.each do
            count += 1
          end
          expect(count).to eq 4
        end
      end
    end
  end
end
