require 'validator_spec'

describe MarsRovers do
  let(:rovers_block)         { mars_rovers_instance.rovers_block }
  let(:rover)                { mars_rovers_instance.rover_controller }
  let(:input_array)          { mars_rovers_instance.input }
  let(:mars_rovers_instance) { described_class.new(input) }
  let(:input)                { "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }

  it_behaves_like 'Validator'

  describe 'input' do
    let(:rovers) { mars_rovers_instance.rovers }

    it 'is an Array' do
      expect(input_array).to be_an(Array)
    end

    describe '#rovers' do
      it 'has rovers' do
        expect(rovers).to eq(['1 2 N', 'LMLMLMLMM', '3 3 E', 'MMRMMRMRRM'])
      end
    end
  end

  context 'when rover is not valid' do
    let(:input)               { "5 5\n1 2 N\n1234ABC\n3 3 E\nSDD" }
    let(:invalid_data_rovers) { mars_rovers_instance.rover_controller }

    it 'raise an error comment' do
      expect(invalid_data_rovers).to start_with('Houston we have a problem')
    end
  end

  context 'when rover is valid and has only one movement' do
    describe '#rover_controller' do
      let(:input)                         { "5 5\n1 2 N\nL" }
      let(:one_movement_rover_controller) { mars_rovers_instance.rover_controller }

      it 'has W switching from N with one left movement' do
        expect(one_movement_rover_controller).to eq('1 2 W')
      end
    end
  end

  context 'when rover is valid and there is only one rover' do
    describe '#rover_controller' do
      let(:input)                      { "5 5\n1 2 N\nLMLMLMLMM" }
      let(:one_valid_rover_controller) { mars_rovers_instance.rover_controller }

      it 'has W switching from N with one left movement' do
        expect(one_valid_rover_controller).to eq('1 3 N')
      end
    end
  end

  context 'when rover is valid and there are more rovers' do
    describe '#rover_controller' do
      let(:input)                       { "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
      let(:two_valid_rover_controllers) { mars_rovers_instance.rover_controller }

      it 'has W switching from N with one left movement' do
        expect(two_valid_rover_controllers).to eq('1 3 N \n 5 1 E')
      end
    end
  end

  describe '#rovers_block' do
    let(:rovers_block) { mars_rovers_instance.rovers_block }

    it 'has all the rovers position' do
      expect(rovers_block).to eq([['1 2 N', 'LMLMLMLMM'], ['3 3 E', 'MMRMMRMRRM']])
    end
  end

  describe '#right' do
    let(:north_right_movement)  { mars_rovers_instance.right('1 2 N') }
    let(:east_right_movement)   { mars_rovers_instance.right('1 2 E') }
    let(:south_right_movement)  { mars_rovers_instance.right('1 2 S') }
    let(:west_right_movement)   { mars_rovers_instance.right('1 2 W') }

    it "have from previous 'N' movement 90 degrees to the right to 'E'" do
      expect(north_right_movement).to eq('1 2 E')
    end

    it "have from previous 'E' movement 90 degrees to the right to 'S'" do
      expect(east_right_movement).to eq('1 2 S')
    end

    it "have from previous 'S' movement 90 degrees to the right to 'W'" do
      expect(south_right_movement).to eq('1 2 W')
    end

    it "have from previous 'W' movement 90 degrees to the right to 'N'" do
      expect(west_right_movement).to eq('1 2 N')
    end
  end

  describe '#left' do
    let(:north_left_movement)  { mars_rovers_instance.left('1 2 N') }
    let(:west_left_movement)   { mars_rovers_instance.left('1 2 W') }
    let(:south_left_movement)  { mars_rovers_instance.left('1 2 S') }
    let(:east_left_movement)   { mars_rovers_instance.left('1 2 E') }

    it "have from previous 'N' movement 90 degrees to the left to 'W'" do
      expect(north_left_movement).to eq('1 2 W')
    end

    it "have from previous 'W' movement 90 degrees to the left to 'S'" do
      expect(west_left_movement).to eq('1 2 S')
    end

    it "have from previous 'S' movement 90 degrees to the left to 'E'" do
      expect(south_left_movement).to eq('1 2 E')
    end

    it "have from previous 'E' movement 90 degrees to the left to 'N'" do
      expect(east_left_movement).to eq('1 2 N')
    end
  end

  describe '#move' do
    let(:north_move_action)  { mars_rovers_instance.move('1 2 N') }
    let(:west_move_action)   { mars_rovers_instance.move('1 2 W') }
    let(:south_move_action)  { mars_rovers_instance.move('1 2 S') }
    let(:east_move_action)   { mars_rovers_instance.move('1 2 E') }

    it "have from previous 'N' movement 90 degrees to the left to 'W'" do
      expect(north_move_action).to eq('1 3 N')
    end

    it "have from previous 'W' action 90 degrees to the move to 'S'" do
      expect(west_move_action).to eq('0 2 W')
    end

    it "have from previous 'S' action 90 degrees to the move to 'E'" do
      expect(south_move_action).to eq('1 1 S')
    end

    it "have from previous 'E' action 90 degrees to the move to 'N'" do
      expect(east_move_action).to eq('2 2 E')
    end
  end

  describe '#status_hash' do
    let(:north_move_action) { mars_rovers_instance.status_hash('1 2 N') }

    it 'has a hash' do
      expect(north_move_action).to eq(x: '1', y: '2', direction: 'N')
    end
  end

  describe '#commander' do
    context 'when commander has L input' do
      let(:present_status_n)      { '1 2 N' }
      let(:command_left)          { 'LL' }
      let(:commander_left_action) { mars_rovers_instance.commander(present_status_n, command_left) }

      it 'has status N and command L till W ' do
        expect(commander_left_action).to eq('1 2 W')
      end
    end

    context 'when commander has R input' do
      let(:present_status_n)      { '1 2 N' }
      let(:command_left)          { 'RR' }
      let(:commander_left_action) { mars_rovers_instance.commander(present_status_n, command_left) }

      it 'has status N and command R till E' do
        expect(commander_left_action).to eq('1 2 E')
      end
    end

    context 'when commander has M input' do
      let(:present_status_n)        { '1 2 N' }
      let(:command_move)            { 'M' }
      let(:commander_move_n_action) { mars_rovers_instance.commander(present_status_n, command_move) }

      it 'has status N and command M will move (x, y + 1)' do
        expect(commander_move_n_action).to eq('1 3 N')
      end
    end

    context 'when commander has M input' do
      let(:present_status_w)        { '1 2 W' }
      let(:command_move)            { 'M' }
      let(:commander_move_w_action) { mars_rovers_instance.commander(present_status_w, command_move) }

      it 'has status N and command M will move (x, y + 1)' do
        expect(commander_move_w_action).to eq('0 2 W')
      end
    end
  end

  describe '#rover_locator' do
    let(:input)                       { "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
    let(:two_valid_rover_controllers) { mars_rovers_instance.rover_locator }

    it 'has W switching from N with one left movement' do
      expect(two_valid_rover_controllers).to eq('1 3 N \n 5 1 E')
    end
  end
end
