require_relative 'station'
require_relative 'route'
require_relative 'module_vendor'
require_relative 'instance_counter'

class Train

  include InstanceCounter 
   
  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  include ModuleVendor
  attr_reader :name, :type, :speed, :number
  
  NUMBER_FORMAT = /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}$/i
  NAME_FORMAT = /^[А-Я]{1}[а-я]*$/

  def initialize(name, type, wagons = [], route = [], number)
    @name = name
    @type = type
    @wagons = wagons
    @speed = 0
    @route = route
    @number = number
    validate!
    @@trains[number] = self
    register_instance
  end

  def wagon_to_block(&block)
    @wagons.each do |wagon| 
      yield(wagon)
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def change_speed(speed_delta)
    @speed = [@speed + speed_delta, 0].max
  end

  def wagons
    @wagons 
  end

  def stop
    @speed = 0
  end

  def attach_wagon(wagon)
    return if self.speed > 0
    return if self.type != wagon.type
    @wagons << wagon
  end

  def deattach_wagon
    @wagons.pop if @speed == 0
  end

  def route=(route)
    @route = route
    @index_location = 0
    current_station.add_train(self)
  end

  def go_forward
    return if current_station == @route.terminate
    current_station.delete_train(self)
    @index_location += 1
    current_station.add_train(self)
  end

  def go_back
    return if current_station == @route.start
    current_station.delete_train(self)
    @index_location -= 1
    current_station.add_train(self)
  end

  def current_station
    @route.stations[@index_location]
  end
  
  def back_station
    return if current_station == @route.start
    @route.stations[@index_location - 1]
  end

  def next_station
    return if current_station == @route.terminate
    @route.stations[@index_location + 1]
  end

  protected

  def validate!
    raise "Name can't be nil" if name.nil?
    raise "Name can't be nil" if number.nil?
    raise "Type has invalide value" unless [:passenger, :cargo].include?(type)
    raise "Name has invalid format" if name !~ NAME_FORMAT
    raise "Number has invalid format" if number !~ NUMBER_FORMAT
    true
  end
end  