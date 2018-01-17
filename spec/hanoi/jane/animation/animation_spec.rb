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

        it 'produces the correct frames' do
          anim.each_with_index do |frame, index| 
            expect(frame.stacks).to eq expected[index]
          end
        end
      end
    end
  end
end
