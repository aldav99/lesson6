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
    "Номер вагона: #{self.number}. Тип вагона: #{self.type}. Свободные места: #{self.places}. Занятые места: #{self.occupied}."
  end

  def take_a_places
    self.places = [self.places - 1, 0].max
  end
  
  def occupied
    @max_places - self.places
  end

  protected

  attr_writer :places

end