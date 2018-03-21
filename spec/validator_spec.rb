require 'spec_helper'
require 'mars_rovers'

shared_examples_for 'Validator' do
  describe '#plateau_upper_right_coordinates' do
    let(:plateau_upper_right_coordinates) { mars_rovers_instance.plateau_upper_right_coordinates }

    it 'has only integers inside the array' do
      expect(plateau_upper_right_coordinates).to include(5, 5)
    end

    it 'has 2 items as (x, y)' do
      expect(plateau_upper_right_coordinates.size).to eq(2)
    end
  end

  let(:input) { "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
  let(:mars_rovers_instance) { described_class.new(input) }
  describe '#rovers_validator' do
    let(:valid_rovers) { mars_rovers_instance.rovers_validator }

    it 'has a valid rover' do
      expect(valid_rovers).to eq(true)
    end
  end

  describe '#rovers_validator' do
    let(:valid_rovers) { mars_rovers_instance.rovers_validator }

    it 'has a valid rover' do
      expect(valid_rovers).to eq(true)
    end
  end

  context 'when rover validator is out of scope' do
    let(:invalid_input)         { "5 5\n6 7 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
    let(:mars_rovers_instance)  { described_class.new(invalid_input) }
    let(:scope_rovers)          { mars_rovers_instance.rovers_validator }

    it 'has coordinates are out the plateau' do
      expect(scope_rovers).to eq(false)
    end
  end

  context 'when rover validator items are not 3' do
    let(:input)                      { "5 5\n4 2 3 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
    let(:oversized_size_rovers)      { mars_rovers_instance.rovers_validator }
    let(:small_input)                { "5 5\n 3 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
    let(:mars_rovers_instance_small) { described_class.new(small_input) }
    let(:undersized_size_rovers)     { mars_rovers_instance_small.rovers_validator }

    it 'has more than 3 items' do
      expect(oversized_size_rovers).to eq(false)
    end

    it 'has less than 3 items' do
      expect(undersized_size_rovers).to eq(false)
    end
  end

  context 'when rover has incorrect data' do
    let(:incorrect_input_data)  { "5 5\nD A -3\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
    let(:mars_rovers_instance)  { described_class.new(incorrect_input_data) }
    let(:data_rovers)           { mars_rovers_instance.rovers_validator }

    it 'has strings instead integres and integers instead strings' do
      expect(data_rovers).to eq(false)
    end
  end

  context 'when rover has strings in coordinates' do
    let(:invalid_input)         { "5 5\n'S' 'D' 3\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
    let(:mars_rovers_instance)  { described_class.new(invalid_input) }
    let(:data_rovers)           { mars_rovers_instance.rovers_validator }

    it 'has strings instead integres and integers instead strings' do
      expect(data_rovers).to eq(false)
    end
  end
end
