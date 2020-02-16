module Hanoi
  module Jane
    module Formatters
      describe Longruner do
        it 'has default values' do
          runer = described_class.new
          expect(runer.stacks).to eq [[]]
        end

        it 'takes a block' do
          runer = described_class.new do |r|
            r.stacks = [[2, 1, 0], [], []]
          end

          expect(runer.stacks).to eq [[2, 1, 0], [], []]
        end

        context 'populate grid' do
          runer = described_class.new do |r|
            r.stacks = [[4, 3, 2, 1, 0], [], []]
          end

          it 'wipes the slate before we begin' do
            runer.wipe
            # this is a super-elaborate way to check that every value is a zero
            expect(runer.map { |row| row.all? { |item| item == :none} }.all? { |b| b } ).to be true
          end

          context 'stacks' do
            it 'draws discs' do
              {
                3 => 9,
                2 => 7,
                1 => 5,
                0 => 3
              }.each_pair do |disc, expected_width|
                runer.wipe
                runer.draw_disc disc
                expect(runer[7][0..expected_width - 1]).to eq [:disc] * expected_width
                expect(runer[7][expected_width]).to eq :none
              end
            end

            it 'draws a stack' do
              runer.wipe
              runer.draw_stack [1, 0]
              expect(runer[7][0..8]).to eq [
                :none, :none, :disc, :disc, :disc, :disc, :disc, :none, :none
              ]
              expect(runer[6][0..8]).to eq [
                :none, :none, :none, :disc, :disc, :disc, :none, :none, :none
              ]
            end
          end

          context 'poles' do
            it 'draws the poles' do
              runer.wipe
              runer.draw_poles
              for row in runer[1..7]
                expect(row).to eq [:none] * 4 + [:pole] + [:none] * 10 + [:pole] + [:none] * 10 + [:pole] + [:none] * 5
              end
            end
          end
        end

        context 'lights' do
          it 'has the correct matrix' do
            runer = described_class.new do |r|
              r.stacks = [[3, 2], [0], [1]]
            end

            expect(runer).to eq [
              [:none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none],
              [:none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none],
              [:none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none],
              [:none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none],
              [:none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none],
              [:none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none],
              [:none, :disc, :disc, :disc, :disc, :disc, :disc, :disc, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none],
              [:disc, :disc, :disc, :disc, :disc, :disc, :disc, :disc, :disc, :none, :none, :none, :none, :none, :disc, :disc, :disc, :none, :none, :none, :none, :none, :none, :none, :disc, :disc, :disc, :disc, :disc, :none, :none, :none]
            ]
          end

          it 'has the correct matrix for a tween frame' do
            runer = described_class.new do |r|
              r.stacks = [[3, nil, 2], [0], [1]]
            end

            expect(runer).to eq [
              [:none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none],
              [:none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none],
              [:none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none],
              [:none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none],
              [:none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none],
              [:none, :disc, :disc, :disc, :disc, :disc, :disc, :disc, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none],
              [:none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none, :none, :none, :none, :none, :none, :pole, :none, :none, :none, :none, :none],
              [:disc, :disc, :disc, :disc, :disc, :disc, :disc, :disc, :disc, :none, :none, :none, :none, :none, :disc, :disc, :disc, :none, :none, :none, :none, :none, :none, :none, :disc, :disc, :disc, :disc, :disc, :none, :none, :none]
            ]
          end
        end

        context 'mapping' do
          it 'maps its values to colours' do
            runer = described_class.new do |r|
              r.stacks = [[3, 2], [0], [1]]
            end

            expect(runer.colourised [255, 0, 0], [0, 255, 0]).to eq [
              [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]],
              [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]],
              [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]],
              [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]],
              [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]],
              [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]],
              [[0, 0, 0], [255, 0, 0], [255, 0, 0], [255, 0, 0], [255, 0, 0], [255, 0, 0], [255, 0, 0], [255, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 255, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]],
              [[255, 0, 0], [255, 0, 0], [255, 0, 0], [255, 0, 0], [255, 0, 0], [255, 0, 0], [255, 0, 0], [255, 0, 0], [255, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [255, 0, 0], [255, 0, 0], [255, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [255, 0, 0], [255, 0, 0], [255, 0, 0], [255, 0, 0], [255, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]]]
          end
        end
      end
    end
  end
end
