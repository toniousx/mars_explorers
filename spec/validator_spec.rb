require 'spec_helper'
require 'mars_rovers'

describe Validator do
  let(:plateau_upper_right_coordinates) { [5, 5] }
  let(:rovers)                          { ['1 2 N', 'LMLMLMLMM', '3 3 E', 'MMRMMRMRRM'] }
  let(:validator_instance) { described_class.new(plateau_upper_right_coordinates, rovers) }

  describe '#rovers_validator' do
    let(:valid_rovers) { validator_instance.rovers_validator }

    it 'has a valid rover' do
      expect(valid_rovers).to eq(true)
    end
  end

  describe '#rovers_validator' do
    let(:valid_rovers) { validator_instance.rovers_validator }

    it 'has a valid rover' do
      expect(valid_rovers).to eq(true)
    end
  end

  context 'when rover validator is out of scope' do
    let(:invalid_rovers)        { ['6 7 N', 'LMLMLMLMM', '3 3 E', 'MMRMMRMRRM'] }
    let(:validator_instance)    { described_class.new(plateau_upper_right_coordinates, invalid_rovers) }
    let(:scope_rovers)          { validator_instance.rovers_validator }

    it 'has coordinates are out the plateau' do
      expect(scope_rovers).to eq(false)
    end
  end

  context 'when plateau_upper_right_coordinates is not valid' do
    let(:plateau_upper_right_coordinates) { [-3, 5] }
    let(:validator_instance)    { described_class.new(plateau_upper_right_coordinates, rovers) }
    let(:scope_rovers)          { validator_instance.rovers_validator }

    it 'has coordinates are out the plateau' do
      expect(scope_rovers).to eq(false)
    end
  end

  context 'when rover validator items are not 3' do
    let(:rovers)                     { ['4 2 3 N', 'LMLMLMLMM', '3 3 E', 'MMRMMRMRRM'] }
    let(:oversized_size_rovers)      { validator_instance.rovers_validator }
    let(:small_input)                { ['3 N', 'LMLMLMLMM', '3 3 E', 'MMRMMRMRRM'] }
    let(:validator_instance_small)   { described_class.new(plateau_upper_right_coordinates, small_input) }
    let(:undersized_size_rovers)     { validator_instance_small.rovers_validator }

    it 'has more than 3 items' do
      expect(oversized_size_rovers).to eq(false)
    end

    it 'has less than 3 items' do
      expect(undersized_size_rovers).to eq(false)
    end
  end

  context 'when rover has incorrect data' do
    let(:incorrect_rover_data)  { ['D A -3', 'LMLMLMLMM', '3 3 E', 'MMRMMRMRRM'] }
    let(:validator_instance)    { described_class.new(plateau_upper_right_coordinates, incorrect_rover_data) }
    let(:data_rovers)           { validator_instance.rovers_validator }

    it 'has strings instead integres and integers instead strings' do
      expect(data_rovers).to eq(false)
    end
  end

  describe '#commands_validator' do
    let(:valid_commands) { validator_instance.commands_validator }

    it 'has valid commands' do
      expect(valid_commands).to eq(true)
    end
  end

  context 'when commands are not valid' do
    let(:invalid_rover)         { ['D A -3', 'n1234ABC', '3 3 E', 'SDD'] }
    let(:validator_instance)    { described_class.new(plateau_upper_right_coordinates, invalid_rover) }
    let(:data_rovers)           { validator_instance.commands_validator }

    it 'has any kind of items except commands' do
      expect(data_rovers).to eq(false)
    end
  end

  context 'when commands have spaces' do
    let(:invalid_rover_input)   { ['D A -3', 'LM LM LMLMM', '3 3 E', 'MMR MMRMRRM'] }
    let(:validator_instance)    { described_class.new(plateau_upper_right_coordinates, invalid_rover_input) }
    let(:data_rovers)           { validator_instance.commands_validator }

    it 'items are correct except space' do
      expect(data_rovers).to eq(false)
    end
  end
end
