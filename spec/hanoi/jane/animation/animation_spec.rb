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

        # [
        #   [[1, nil, 0], [nil, nil, nil], [nil, nil, nil]],
        #   [[1, nil, nil], [nil, nil, nil], [nil, nil, nil]]
        # ].each_with_index do |state, index|
        #   specify 'state #d is correct' % index do
        #     anim.animate
        #     expect(anim.stacks).to eq state
        #   end
        # end

        anim.each do |frame|
          puts frame.stacks.inspect
        end
      end
    end
  end
end
