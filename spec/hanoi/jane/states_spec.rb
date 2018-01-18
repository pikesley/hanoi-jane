module Hanoi
  module Jane
    describe Towers do
      towers = Towers.new do |t|
        t.discs = 3
      end

      it 'has the correct initial state' do
        expect(towers.binary).to eq '000'
        expect(towers.stacks).to eq [[2, 1, 0], [], []]
      end

      it 'has the correct first state' do
        towers.move
        expect(towers.binary).to eq '001'
        expect(towers.stacks).to eq [[2, 1], [0], []]
      end

      it 'has the correct second state' do
        towers.move
        expect(towers.binary).to eq '010'
        expect(towers.stacks).to eq [[2], [0], [1]]
      end

      it 'has the correct third state' do
        towers.move
        expect(towers.binary).to eq '011'
        expect(towers.stacks).to eq [[2], [], [1, 0]]
      end

      it 'has the correct fourth state' do
        towers.move
        expect(towers.binary).to eq '100'
        expect(towers.stacks).to eq [[], [2], [1, 0]]
      end

      it 'has the correct fifth state' do
        towers.move
        expect(towers.binary).to eq '101'
        expect(towers.stacks).to eq [[0], [2], [1]]
      end

      it 'has the correct sixth state' do
        towers.move
        expect(towers.binary).to eq '110'
        expect(towers.stacks).to eq [[0], [2, 1], []]
      end

      it 'has the correct final state' do
        towers.move
        expect(towers.binary).to eq '111'
        expect(towers.stacks).to eq [[], [2, 1, 0], []]
      end
    end
  end
end
