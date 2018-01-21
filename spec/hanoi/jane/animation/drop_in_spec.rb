module Hanoi
  module Jane
    describe DropIn do
      context 'constructor' do
        di = DropIn.new do |d|
          d.height = 4
          d.discs = 2
        end

        it 'starts with empty stacks' do
          expect(di.stacks).to eq [
            [nil, nil, nil, nil],
            [nil, nil, nil, nil],
            [nil, nil, nil, nil]
          ]
        end
      end

      context 'drop the discs in' do
        di = DropIn.new do |d|
          d.height = 3
          d.discs = 2
        end

        it 'drops the discs' do
          expected = [
            [[nil, nil, 1], [nil, nil, nil], [nil, nil, nil]],
            [[nil, 1, nil], [nil, nil, nil], [nil, nil, nil]],
            [[1, nil, nil], [nil, nil, nil], [nil, nil, nil]],
            [[1, nil, 0], [nil, nil, nil], [nil, nil, nil]]
          ]

          di.each_with_index do |state, index|
            expect(state.stacks).to eq expected[index]
          end
        end

        it 'drops a bigger stack' do
          di = DropIn.new do |d|
            d.height = 7
            d.discs = 5
          end

          count = 0
          di.each do
            count += 1
          end
          expect(count).to eq 24
        end

        it 'has the correct value' do
          di = DropIn.new do |d|
            d.height = 7
            d.discs = 5
          end

          di.each do
            case di.disc
            when 4
              expect(di.value).to eq '0'
            when 3
              expect(di.value).to eq '00'
            when 2
              expect(di.value).to eq '000'
            when 1
              expect(di.value).to eq '0000'
            when 0
              expect(di.value).to eq '00000'
            end
          end
        end
      end

      context 'present as dots' do
        di = DropIn.new do |d|
          d.height = 3
          d.discs = 2
        end

        it 'presents as dots' do
          count = 0
          sample = []
          di.each do |frame|
            count += 1
            sample = frame
          end

          expect(sample.to_dots).to eq [
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
              0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0]
          ]
        end
      end
    end
  end
end
