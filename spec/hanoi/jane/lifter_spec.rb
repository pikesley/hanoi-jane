module Hanoi
  module Jane
    class Animator
      describe Lifter do
        context 'find the thing to lift' do
          it 'does an easy case' do
            l = Lifter.new [1, 0], 4
            expect(l.liftee).to eq 1
          end
        end

        context 'lift the thing' do
          l = Lifter.new [1, 0], 4

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

        context 'lift a different thing' do
          l = Lifter.new [1], 3

          it 'lifts it once' do
            l.lift
            expect(l.stack).to eq [nil, 1, nil]
          end
        end

        context 'iterator' do
          l = Lifter.new [1, 0], 4

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
