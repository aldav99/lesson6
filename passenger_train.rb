require_relative 'train'

class PassengerTrain < Train
  def initialize(name, number, wagons = [], route = [])
    super(name, :passenger, number, wagons, route)
  end
end
