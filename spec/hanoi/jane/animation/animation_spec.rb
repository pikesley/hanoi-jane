module Hanoi
  module Jane
    describe Animation do
      context 'constructor' do
        it 'takes a block' do
          stacks = [
            [2, 1, 0], [], []
          ]
          anim = Animation.new do |a|
            a.stacks = stacks
            a.disc = 0
            a.height = 7
          end

          expect(anim.stacks).to eq [
            [2, 1, 0, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil]
          ]
        end
      end

      context 'animate' do
        it 'produces the correct frames' do
        stacks = [
          [1, 0], [], []
        ]

        anim = Animation.new do |a|
          a.stacks = stacks
          a.disc = 0
          a.from = 0
          a.to = 1
          a.height = 3
        end

        expected = [
          [[1, nil, 0], [nil, nil, nil], [nil, nil, nil]],
          [[1, nil, nil], [nil, nil, nil], [nil, nil, nil]],
          [[1, nil, nil], [nil, nil, 0], [nil, nil, nil]],
          [[1, nil, nil], [nil, 0, nil], [nil, nil, nil]]
        ]

          anim.each_with_index do |frame, index|
            expect(frame.stacks).to eq expected[index]
          end
        end

        it 'deals with different from and to stacks' do
          stacks = [
            [2], [1], []
          ]

          anim = Animation.new do |a|
            a.stacks = stacks
            a.disc = 1
            a.from = 1
            a.to = 2
            a.height = 3
          end

          expected = [
            [[2, nil, nil], [nil, 1, nil], [nil, nil, nil]],
            [[2, nil, nil], [nil, nil, 1], [nil, nil, nil]],
            [[2, nil, nil], [nil, nil, nil], [nil, nil, nil]],
            [[2, nil, nil], [nil, nil, nil], [nil, nil, 1]],
            [[2, nil, nil], [nil, nil, nil], [nil, 1, nil]]
          ]

          anim.each_with_index do |frame, index|
            expect(frame.stacks).to eq expected[index]
          end
        end

        it 'handles a 2-to-1 case' do
          stacks = [
            [], [1], [0]
          ]

          anim = Animation.new do |a|
            a.stacks = stacks
            a.disc = 1
            a.from = 2
            a.to = 1
            a.height = 2
          end

          expected = [
            [[nil, nil], [1, nil], [nil, 0]],
            [[nil, nil], [1, nil], [nil, nil]]
          ]

          anim.each_with_index do |frame, index|
            expect(frame.stacks).to eq expected[index]
          end
        end
      end
    end
  end
end
