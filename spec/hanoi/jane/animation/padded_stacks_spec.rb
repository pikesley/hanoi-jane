module Hanoi
  module Jane
    describe PaddedStacks do
      it 'clones the stacks' do
        start = [['a', 'b', 'c', 'd']]
        ps = PaddedStacks.new start

        # edit the original array
        start[0][0] = 'x'
        expect(ps[0][0]).to eq 'a'
      end

      it 'pads a stack' do
        expect(PaddedStacks.pad [2, 1], 4).to eq [2, 1, nil, nil]
      end

      it 'pads all the stacks to a given height' do
        stacks = [
          [2, 1],
          [0],
          []
        ]
        ps = PaddedStacks.new stacks, 4
        expect(ps).to eq [
          [2, 1, nil, nil],
          [0, nil, nil, nil],
          [nil, nil, nil, nil]
        ]
      end
    end
  end
end
