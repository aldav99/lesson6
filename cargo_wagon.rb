require_relative 'wagon'

class CargoWagon < Wagon
  
  def initialize(value)
    @value = value
    @occupied_value = value
  end

  def type 
    :cargo
  end
  
  def value
    @value 
  end

  def value=(value)
    @value = value
  end

  def take_a_value(value)
    if self.value - value > 0
      self.value -= value
    else 
      self.value = 0
    end
  end

  
  def occupied
    @occupied_value - self.value
  end
end