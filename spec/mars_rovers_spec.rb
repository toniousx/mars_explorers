require 'mars_rovers'

describe MarsRovers do
  let(:input) { "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
  let(:mars_rovers_instance) { described_class.new(input) }
  let(:input_array) { mars_rovers_instance.input }

  describe 'Input' do
    let(:rovers) { mars_rovers_instance.rovers }

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

    describe '#rovers' do
      it 'has rovers' do
        expect(rovers).to eq(['1 2 N', 'LMLMLMLMM', '3 3 E', 'MMRMMRMRRM'])
      end
    end

    describe '#rovers_validator' do
      let(:valid_rovers) { mars_rovers_instance.rovers_validator }

      it 'has a valid rover' do
        expect(valid_rovers).to eq(true)
      end
    end

    context 'when rover validator is out of scope' do
      let(:input) { "5 5\n6 7 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
      let(:mars_rovers_instance) { described_class.new(input) }
      let(:invalid_scope_rovers) { mars_rovers_instance.rovers_validator }

      it 'has coordenates are out the plateau' do
        expect(invalid_scope_rovers).to eq(false)
      end
    end

    context 'when rover validator items are not 3' do
      let(:input) { "5 5\n4 2 3 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
      let(:invalid_big_size_rovers) { mars_rovers_instance.rovers_validator }
      let(:small_input) { "5 5\n 3 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
      let(:mars_rovers_instance_small) { described_class.new(small_input) }
      let(:invalid_small_size_rovers) { mars_rovers_instance_small.rovers_validator }

      it 'has more than 3 items' do
        expect(invalid_big_size_rovers).to eq(false)
      end

      it 'has less than 3 items' do
        expect(invalid_small_size_rovers).to eq(false)
      end
    end

    context 'when rover has incorrect data' do
      let(:input) { "5 5\nD A -3\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
      let(:invalid_data_rovers) { mars_rovers_instance.rovers_validator }

      it 'has strings instead integres and integers instead strings' do
        expect(invalid_data_rovers).to eq(false)
      end
    end

    describe '#commands_validator' do
      let(:valid_commands) { mars_rovers_instance.commands_validator }

      it 'has valid commands' do
        expect(valid_commands).to eq(true)
      end
    end

    context 'when commands are not valid' do
      let(:input) { "5 5\n1 2 N\n1234ABC\n3 3 E\nSDD" }
      let(:invalid_data_rovers) { mars_rovers_instance.commands_validator }

      it 'has any kind of items except commands' do
        expect(invalid_data_rovers).to eq(false)
      end
    end

    context 'when commands have spaces' do
      let(:input) { "5 5\n1 2 N\nLM LM LMLMM\n3 3 E\nMMR MMRMRRM" }
      let(:invalid_data_rovers) { mars_rovers_instance.commands_validator }

      it 'items are correct except space' do
        expect(invalid_data_rovers).to eq(false)
      end
    end
  end
end
