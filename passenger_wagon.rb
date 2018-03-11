require_relative 'wagon'

class PassengerWagon < Wagon
  def initialize(places)
    @places = places
    @max_places = places
  end

  def type
    :passenger
  end

  attr_reader :places

  def to_s
    number = "Номер вагона: #{self.number}."
    type = " Тип вагона: #{self.type}."
    free_places = " Свободные места: #{places}."
    occupied_places = " Занятые места: #{occupied}."
    number + type + free_places + occupied_places
  end

  def take_a_places
    self.places = [places - 1, 0].max
  end

  def occupied
    @max_places - places
  end

  protected

  attr_writer :places
end
