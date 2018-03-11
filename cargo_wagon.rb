require_relative 'wagon'

class CargoWagon < Wagon
  def initialize(volume)
    @free_volume = volume
    @total_volume = volume
  end

  attr_reader :free_volume

  def type
    :cargo
  end

  def take_a_volume(volume)
    self.free_volume = [free_volume - volume, 0].max
  end

  def to_s
    wagon_date_output = "Номер вагона: #{number}. Тип вагона: #{type}."
    volume_free_output = "Свободный объем: #{free_volume}."
    volume_occupied_output = " Занятый объем: #{occupied}."
    wagon_date_output + volume_free_output + volume_occupied_output
  end

  def occupied
    @total_volume - free_volume
  end

  protected

  attr_writer :free_volume
end
