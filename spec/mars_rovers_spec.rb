require 'mars_rovers'

describe MarsRovers do
  let(:input) { "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
  let(:mars_rovers_instance) { described_class.new(input) }
  let(:input_array) { mars_rovers_instance.input }

  describe 'Input' do
    it 'is an Array' do
      expect(input_array).to be_an(Array)
    end

    describe '#plateau_upper_right_coordinates' do
      let(:plateau_upper_right_coordinates) { mars_rovers_instance.plateau_upper_right_coordinates }

      it 'has only integers inside the array' do
        expect(plateau_upper_right_coordinates).to include(5, 5)
      end

      it 'has 2 items as (x, y)' do
        expect(plateau_upper_right_coordinates.size).to eq(2)
      end
    end

    describe '#land_rovers' do
      let(:land_rovers) { mars_rovers_instance.land_rovers }

      it 'has land rovers' do
        expect(land_rovers).to eq(['1 2 N', 'LMLMLMLMM', '3 3 E', 'MMRMMRMRRM'])
      end
    end
  end
end
