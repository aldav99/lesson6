require_relative 'train'

class CargoTrain < Train
  def initialize(name, number, wagons = [], _route = [])
    super(name, :cargo, number, wagons)
  end
end
