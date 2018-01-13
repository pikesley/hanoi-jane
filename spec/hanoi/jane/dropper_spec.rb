module Hanoi
  module Jane
    class Animator
      describe Dropper do
        d = Dropper.new [1], 3, 0

        it 'does the first drop' do
          d.drop
          expect(d.stack).to eq [1, nil, 0]
        end

        it 'drops right in' do
          d.drop
          expect(d.stack).to eq [1, 0, nil]
        end

        it 'knows when to stop dropping' do
          d = Dropper.new [1], 3, 0
          d.drop
          expect(d.dropped).to be true
        end

        context 'iterator' do
          dr = Dropper.new [2, 1], 4, 0

          it 'exposes an iterator' do
            count = 0
            dr.each do |state|
              count += 1
            end
            expect(count).to eq 1
          end
        end
      end
    end
  end
end
