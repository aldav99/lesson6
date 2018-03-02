require_relative 'train'

class PassengerTrain < Train

  def initialize(name, wagons = [], route = [], number)
    super(name, :passenger, wagons, route, number)
  end
end