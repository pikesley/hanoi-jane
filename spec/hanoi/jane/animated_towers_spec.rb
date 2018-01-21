module Hanoi
  module Jane
    describe AnimatedTowers do
      context 'constructor' do
        it 'rejects more discs than height' do
          expect { at = AnimatedTowers.new do |a|
            a.towers = ConstrainedTowers
            a.discs = 4
            a.height = 3
          end }.to raise_exception do |ex|
            expect(ex).to be_a HanoiException
            expect(ex.text).to eq 'number_of_discs (4) > height (3)'
          end
        end

        it 'rejects negative height' do
          expect { at = AnimatedTowers.new do |a|
            a.towers = ConstrainedTowers
            a.discs = 4
            a.height = -3
          end }.to raise_exception do |ex|
            expect(ex).to be_a HanoiException
            expect(ex.text).to eq 'number_of_discs (4) > height (-3)'
          end
        end
      end

      context 'animate' do
        it 'animates a simple set' do
          at = AnimatedTowers.new do |a|
            a.towers = ConstrainedTowers
            a.discs = 2
            a.height = 2
          end
          expect(at.towers).to be_a ConstrainedTowers

          states = [
            [[1, 0], [nil, nil], [nil, nil]],
            [[1, nil], [nil, nil], [nil, nil]],
            [[1, nil], [nil, 0], [nil, nil]],
            [[1, nil], [0, nil], [nil, nil]],
            [[1, nil], [nil, 0], [nil, nil]],
            [[1, nil], [nil, nil], [nil, nil]],
            [[1, nil], [nil, nil], [nil, 0]],
            [[1, nil], [nil, nil], [0, nil]],
            [[nil, 1], [nil, nil], [0, nil]],
            [[nil, nil], [nil, nil], [0, nil]],
            [[nil, nil], [nil, 1], [0, nil]],
            [[nil, nil], [1, nil], [0, nil]],
            [[nil, nil], [1, nil], [nil, 0]],
            [[nil, nil], [1, nil], [nil, nil]],
            [[nil, nil], [1, 0], [nil, nil]],
            [[nil, nil], [1, nil], [nil, nil]],
            [[nil, 0], [1, nil], [nil, nil]],
            [[0, nil], [1, nil], [nil, nil]],
            [[0, nil], [nil, 1], [nil, nil]],
            [[0, nil], [nil, nil], [nil, nil]],
            [[0, nil], [nil, nil], [nil, 1]],
            [[0, nil], [nil, nil], [1, nil]],
            [[nil, 0], [nil, nil], [1, nil]],
            [[nil, nil], [nil, nil], [1, nil]],
            [[nil, nil], [nil, 0], [1, nil]],
            [[nil, nil], [0, nil], [1, nil]],
            [[nil, nil], [nil, 0], [1, nil]],
            [[nil, nil], [nil, nil], [1, nil]],
            [[nil, nil], [nil, nil], [1, 0]]
          ]

          at.each_with_index do |frame, i|
            expect(frame.stacks).to eq states[i]
          end
        end
      end

      context 'present as dots' do
        at = AnimatedTowers.new do |a|
          a.towers = ConstrainedTowers
          a.discs = 2
          a.height = 2
        end

        it 'presents as dots' do
          count = 0
          sample = []
          at.each do |frame|
            count += 1
            sample = frame
          end

          expect(sample.to_dots).to eq [
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0,
              0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0,
              0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
          ]
        end
      end
    end
  end
end
