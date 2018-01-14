module Hanoi
  module Jane
    describe Animation do
      a = Animation.new [[1, 0], [], []], 0, 0, 1, 3

      it 'has the correct initial state' do
        expect(a.stacks).to eq [
          [1, 0, nil],
          [nil, nil, nil],
          [nil, nil, nil]
        ]
      end

      it 'has the correct first state' do
        a.animate
        expect(a.stacks).to eq [
          [1, nil, 0],
          [nil, nil, nil],
          [nil, nil, nil]
        ]
      end

      it 'has the correct second state' do
        a.animate
        expect(a.stacks).to eq [
          [1, nil, nil],
          [nil, nil, nil],
          [nil, nil, nil]
        ]
      end

      it 'has the correct third state' do
        a.animate
        expect(a.stacks).to eq [
          [1, nil, nil],
          [nil, nil, 0],
          [nil, nil, nil]
        ]
      end

      it 'has the correct fourth state' do
        a.animate
        expect(a.stacks).to eq [
          [1, nil, nil],
          [nil, 0, nil],
          [nil, nil, nil]
        ]
      end

      it 'has the correct fifth state' do
        a.animate
        expect(a.stacks).to eq [
          [1, nil, nil],
          [0, nil, nil],
          [nil, nil, nil]
        ]
      end

      context 'iterator' do
        an = Animation.new [[2, 0], [1], []], 0, 0, 1, 3

        it 'exposes an iterator' do
          count = 0
          an.each do
            count += 1
          end
          expect(count).to eq 4
        end

      end
    end
  end
end
