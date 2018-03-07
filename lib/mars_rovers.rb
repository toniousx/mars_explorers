# robotic rover instructions to drive inside Mars plateau
class MarsRovers
  attr_reader :input

  def initialize(input)
    @input = input.split(/\n/)
  end

  def plateau_upper_right_coordinates
    input.first.split.map(&:to_i)
  end

  def land_rovers
    input[1, input.size]
  end
end
