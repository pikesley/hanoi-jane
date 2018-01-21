module Hanoi
  module Jane
    describe Smoosher do
      context 'smooshing' do
        it 'makes a row' do
          expect(Smoosher.row).to be_an Array
          expect(Smoosher.row.length).to eq 45
        end

        context 'weighting' do
          it 'is all 1s' do
            expect(Smoosher.row 1).to eq [1] * 45
          end

          it 'is all 0s' do
            expect(Smoosher.row 0).to eq [0] * 45
          end

          it 'contains a mixture' do
            # this test is *strictly* non-deterministic, but ¯\_(ツ)_/¯
            expect(Smoosher.row(0.5).include? 1).to be true
            expect(Smoosher.row(0.5).include? 0).to be true
          end
        end

        context 'iterator' do
          it 'exposes an iterator' do
            smoosher = Smoosher.new

            count = 0
            sample = []
            smoosher.each do |frame|
              count += 1
              sample = frame
            end
            expect(count).to eq 21
            expect(sample).to eq [[1] * 45] * 7
          end

          it 'goes the other way' do
            smoosher = Smoosher.new do |s|
              s.direction = :open
            end

            count = 0
            sample = []
            smoosher.each do |frame|
              count += 1
              sample = frame
            end
            expect(count).to eq 21
            expect(sample).to eq [[0] * 45] * 7
          end
        end

        context 'present as dots' do
          smoosher = Smoosher.new

          it 'presents as dots' do
            count = 0
            sample = []
            smoosher.each do |frame|
              count += 1
              sample = frame
            end
            expect(sample.to_dots).to eq [
              [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
              [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
              [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
              [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
              [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
              [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
              [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
            ]
          end
        end
      end
    end
  end
end
