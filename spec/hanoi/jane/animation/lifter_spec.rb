module Hanoi
  module Jane
    describe Lifter do
      context 'find the index of the item to be lifted' do
        it 'finds a lone item at the bottom' do
          expect(Lifter.position [0, nil, nil]).to eq 0
        end

        it 'finds the top item of a stack' do
          expect(Lifter.position [2, 1, nil, nil]).to eq 1
        end

        it 'finds an alread-lifted item' do
          expect(Lifter.position [1, nil, 0, nil]).to eq 2
        end
      end

      context 'lift an item' do
        context 'simple case' do
          l = Lifter.new [0, nil, nil]

          [
            [nil, 0, nil],
            [nil, nil, 0],
            [nil, nil, nil]
          ].each_with_index do |state, index|
            specify 'state #%d is correct' % index do
              l.lift
              expect(l).to eq state
            end
          end
        end

        context 'trickier case' do
          l = Lifter.new [2, 1, nil, nil]

          [
            [2, nil, 1, nil],
            [2, nil, nil, 1],
            [2, nil, nil, nil]
          ].each_with_index do |state, index|
            specify 'state #%d is correct' % index do
              l.lift
              expect(l).to eq state
            end
          end
        end
      end

      context 'iterator' do
        l = Lifter.new [2, nil, nil, nil, nil]

        it 'exposes an iterator' do
          count = 0
          l.each do
            count += 1
          end
          expect(count).to eq 5
          expect(l).to eq [nil, nil, nil, nil, nil]
        end
      end
    end
  end
end
