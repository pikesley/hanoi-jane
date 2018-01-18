module Hanoi
  module Jane
    describe AnimatedTowers do
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
    end
  end
end
