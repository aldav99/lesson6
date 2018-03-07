require_relative 'wagon'

class PassengerWagon < Wagon
  

  def initialize(places)
    @places = places
    @occupied_places = places
  end
  
  def type 
    :passenger
  end

  def places
    @places 
  end

  def places=(value)
    @places = value
  end

  def take_a_places
    (self.places > 0)? self.places-= 1 : 0
  end
  
  def occupied
    @occupied_places - self.places
  end

end