module Hanoi
  module Jane
    describe RegularTowers do
      SAVE_PATH = 'tmp/towers.marshal'

      before :all do
        FileUtils.mkdir_p 'tmp'
      end

      context 'serialise state' do
        towers = RegularTowers.new
        it 'serialises itself' do
          towers.serialise SAVE_PATH
        end

        it 'deserialises itself' do
          t = RegularTowers.deserialise SAVE_PATH
          expect(t).to eq towers
        end
      end
    end
  end
end
