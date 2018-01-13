module Hanoi
  module Jane
    class Animator

      describe Lifter do
        context 'find the thing to lift' do
          it 'does an easy case' do
            l = Lifter.new [1, 0, nil, nil]
            expect(l.liftee).to eq 1
          end

          it 'does a tricker case' do
            l = Lifter.new [1, nil, 0, nil]
            expect(l.liftee).to eq 2
          end
        end

        context 'lift the thing' do
          l = Lifter.new [1, 0, nil, nil]

          it 'does the first lift' do
            l.lift
            expect(l.stack).to eq [1, nil, 0, nil]
          end

          it 'lifts it to the top' do
            l.lift
            expect(l.stack).to eq [1, nil, nil, 0]
          end

          it 'lifts the thing right out of there' do
            l.lift
            expect(l.stack).to eq [1, nil, nil, nil]
          end
        end

        context 'iterator' do
          l = Lifter.new [1, 0, nil, nil]

          it 'exposes an iterator' do
            count = 0
            l.each do |state|
              count += 1
            end
            expect(count).to eq 3
          end
        end
      end
    end
  end
end
