require_relative 'wagon'

class CargoWagon < Wagon
  
  def initialize(volume)
    @volume = volume
    @max_volume = volume 
    # @max_volume - переменная для сохранения начального объема вагона
    # Это промежуточная переменная для вычисления ЗАНЯТОГО объема.
  end

  attr_reader :volume

  def type 
    :cargo
  end
  
  def take_a_volume(volume)
    self.volume = [self.volume - volume, 0].max
  end

  def to_s
    "Номер вагона: #{self.number}. Тип вагона: #{self.type}. Свободный объем: #{self.volume}. Занятый объем: #{self.occupied}."
  end
  
  def occupied
    @max_volume - self.volume
  end

  protected

  attr_writer :volume

end