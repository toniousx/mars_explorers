require 'mars_rovers'

describe MarsRovers do
  let(:input)                { "5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
  let(:mars_rovers_instance) { described_class.new(input) }
  let(:input_array)          { mars_rovers_instance.input }

  describe 'input' do
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
      let(:input)                { "5 5\n6 7 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
      let(:mars_rovers_instance) { described_class.new(input) }
      let(:invalid_scope_rovers) { mars_rovers_instance.rovers_validator }

      it 'has coordenates are out the plateau' do
        expect(invalid_scope_rovers).to eq(false)
      end
    end

    context 'when rover validator items are not 3' do
      let(:input)                      { "5 5\n4 2 3 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
      let(:invalid_big_size_rovers)    { mars_rovers_instance.rovers_validator }
      let(:small_input)                { "5 5\n 3 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
      let(:mars_rovers_instance_small) { described_class.new(small_input) }
      let(:invalid_small_size_rovers)  { mars_rovers_instance_small.rovers_validator }

      it 'has more than 3 items' do
        expect(invalid_big_size_rovers).to eq(false)
      end

      it 'has less than 3 items' do
        expect(invalid_small_size_rovers).to eq(false)
      end
    end

    context 'when rover has incorrect data' do
      let(:input)               { "5 5\nD A -3\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM" }
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
      let(:input)               { "5 5\n1 2 N\n1234ABC\n3 3 E\nSDD" }
      let(:invalid_data_rovers) { mars_rovers_instance.commands_validator }

      it 'has any kind of items except commands' do
        expect(invalid_data_rovers).to eq(false)
      end
    end

    context 'when commands have spaces' do
      let(:input)               { "5 5\n1 2 N\nLM LM LMLMM\n3 3 E\nMMR MMRMRRM" }
      let(:invalid_data_rovers) { mars_rovers_instance.commands_validator }

      it 'items are correct except space' do
        expect(invalid_data_rovers).to eq(false)
      end
    end
  end

  describe '#move' do
    let(:rover) { mars_rovers_instance.rover_controller }
    let(:rovers_block) { mars_rovers_instance.rovers_block }

    it 'has a valid rover' do
      expect(mars_rovers_instance.rover_controller).to eq(nil)
    end

    context 'when rover is not valid' do
      let(:input)               { "5 5\n1 2 N\n1234ABC\n3 3 E\nSDD" }
      let(:invalid_data_rovers) { mars_rovers_instance.rover_controller }

      it 'raise an error comment' do
        expect(invalid_data_rovers).to start_with('Houston we have a problem')
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
      let(:present_status_n)      { '1 2 N' }
      let(:command_move)          { 'M' }
      let(:commander_move_n_action) { mars_rovers_instance.commander(present_status_n, command_move) }

      it 'has status N and command M will move (x, y + 1)' do
        expect(commander_move_n_action).to eq('1 3 N')
      end
    end

    context 'when commander has M input' do
      let(:present_status_w)      { '1 2 W' }
      let(:command_move)          { 'M' }
      let(:commander_move_w_action) { mars_rovers_instance.commander(present_status_w, command_move) }

      it 'has status N and command M will move (x, y + 1)' do
        expect(commander_move_w_action).to eq('0 2 W')
      end
    end
  end

  # describe 'rover_controller' do
  # end
end
