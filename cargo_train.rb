require_relative 'train'

class CargoTrain < Train

  def initialize(name, wagons = [], route = [], number)
    super(name, :cargo, wagons, route, number)
  end
end