require 'validator'

# robotic rover instructions to drive inside Mars plateau
class MarsRovers
  include Validator
  attr_reader :input

  def initialize(input)
    @input = input.split(/\n/)
  end

  def rovers
    input[1, input.size]
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

  def coordinate(rel_direction_status)
    rel_direction_status.split.last
  end

  def right(rel_direction_status)
    case coordinate(rel_direction_status)
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
    case coordinate(rel_direction_status)
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

  def movement(axis_position, abscissa_and_ordinate, operator)
    abscissa_and_ordinate[axis_position].to_i.send(operator, 1).to_s
  end

  def status_hash(rel_direction)
    rel_direction_ary = rel_direction.split
    [[:x, rel_direction_ary[0]], [:y, rel_direction_ary[1]], [:direction, rel_direction_ary[2]]].to_h
  end

  def move(rel_direction)
    status = status_hash(rel_direction)
    case status[:direction]
    when 'N'
      status[:y] = movement(1, [status[:x], status[:y]], :+)
    when 'W'
      status[:x] = movement(0, [status[:x], status[:y]], :-)
    when 'S'
      status[:y] = movement(1, [status[:x], status[:y]], :-)
    when 'E'
      status[:x] = movement(0, [status[:x], status[:y]], :+)
    end
    status.values.join(' ')
  end

  def commander(rel_direction_status, commands)
    commands.split('').each do |command|
      return left(rel_direction_status)  if command == 'L'
      return right(rel_direction_status) if command == 'R'
      return move(rel_direction_status)  if command == 'M'
    end
  end

  def rover_locator
    rovers_new_stored_location = []
    rovers_block.each do |rover|
      rover.each_cons(2) do |rel_direction_status, commands|
        rover_new_location = [rel_direction_status]
        commands.split('').each do |command|
          rover_new_location << commander(rover_new_location.last, command)
        end
        rovers_new_stored_location << rover_new_location.last
      end
    end
    rovers_new_stored_location.join(' \n ')
  end

  def rover_controller
    if commands_validator && rovers_validator
      rover_locator
    else
      'Houston we have a problem: Please check your given input for possible errors'
    end
  end
end
