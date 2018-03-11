CARDINAL_POINTS = %w[N S E W].freeze
COMMANDS = %w[L R M].freeze
PLATEAU_LOWER_LEFT_COORDINATES = [0, 0].freeze

# robotic rover instructions to drive inside Mars plateau
class MarsRovers
  attr_reader :input

  def initialize(input)
    @input = input.split(/\n/)
  end

  def plateau_upper_right_coordinates
    input.first.split.map(&:to_i)
  end

  def rovers
    input[1, input.size]
  end

  def relative_direction_type_validator(line)
    relative_direction = line.split
    position           = [relative_direction[0].to_i, relative_direction[1].to_i]
    direction          = relative_direction[2]
    position.all?(Integer) && CARDINAL_POINTS.include?(direction)
  end

  def rel_direction_sizer(line)
    line.split.length == 3
  end

  def rover_x_coordinate_validator(line)
    rover_x_coordinate = line.split[0].to_i
    max_x              = plateau_upper_right_coordinates.first
    min_x              = PLATEAU_LOWER_LEFT_COORDINATES.first
    rover_x_coordinate.between?(min_x, max_x)
  end

  def rover_y_coordinate_validator(line)
    rover_y_coordinate = line.split[1].to_i
    max_y              = plateau_upper_right_coordinates.last
    min_y = PLATEAU_LOWER_LEFT_COORDINATES.last
    rover_y_coordinate.between?(min_y, max_y)
  end

  def plateau_scope_validator(line)
    rover_x_coordinate_validator(line) && rover_y_coordinate_validator(line)
  end

  def rovers_validator
    rel_direction_values  = []
    plateau_scope_results = []
    rel_dir_size_results  = []

    rovers.each_with_index do |line, index|
      next unless (index + 1).odd?
      rel_direction_values  << relative_direction_type_validator(line)
      plateau_scope_results << plateau_scope_validator(line)
      rel_dir_size_results  << rel_direction_sizer(line)
    end
    plateau_scope_results.all?(true) && rel_direction_values.all?(true) && rel_dir_size_results.all?(true)
  end

  def command_values(line)
    line.split('').map { |i| COMMANDS.include?(i) }
  end

  def commands_validator
    command_value_results = []

    rovers.each_with_index do |line, index|
      next unless (index + 1).even?
      command_value_results << command_values(line)
    end
    command_value_results.flatten.all?(true)
  end

  def rovers_block
    rovers.each_slice(2).to_a
  end

  def right(rel_direction_status)
    last_coordinate = rel_direction_status.split.last
    case last_coordinate
    when 'N'
      rel_direction_status.tr('N', 'E')
    when 'E'
      rel_direction_status.tr('E', 'S')
    when 'S'
      rel_direction_status.tr('S', 'W')
    when 'W'
      rel_direction_status.tr('W', 'N')
    end
  end

  def left(rel_direction_status)
    last_coordinate = rel_direction_status.split.last
    case last_coordinate
    when 'N'
      rel_direction_status.tr('N', 'W')
    when 'W'
      rel_direction_status.tr('W', 'S')
    when 'S'
      rel_direction_status.tr('S', 'E')
    when 'E'
      rel_direction_status.tr('E', 'N')
    end
  end

  def move(rel_direction_status)
    ary_status = rel_direction_status.split
    x_position = ary_status[0].to_i
    y_position = ary_status[1].to_i
    last_coordinate = ary_status.last

    case last_coordinate
    when 'N'
      ary_status[1]  = (y_position + 1).to_s
    when 'W'
      ary_status[0]  = (x_position - 1).to_s
    when 'S'
      ary_status[1]  = (y_position - 1).to_s
    when 'E'
      ary_status[0]  = (x_position + 1).to_s
    end
    rel_direction_status = ary_status.join(' ')
  end

  def commander(rel_direction_status, commands)
    commands.split('').each do |command|
      if command == 'L'
        return left(rel_direction_status)
      elsif command == 'R'
        return right(rel_direction_status)
      else
      end
    end
  end

  def rover_coordinates_filter#( present_status = nil, next_commad = nil)
    rovers_block.each do |rover|
      rover.each_cons(2) do |present_status, commands|
        commander(present_status, commands)
      end
    end
  end

  def rover_controller
    if commands_validator && rovers_validator
      # rovers_block.each do |rover|
      #   initial_movement = rover.first
      #   next_movement = rover.split('').each do |movement|
      #   case movement
      #   when 'L'
      #     left(command)
      #   when 'R'
      #     right(command)
      #   when 'M'
      #     # pending
      #   end
      # end
    else
      'Houston we have a problem: Please check your given input for possible errors'
    end
  end
end
