require_relative 'station'
require_relative 'route'
require_relative 'module_vendor'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'acessors'

class Train
  include InstanceCounter
  include Validation
  extend Acessors

  def self.trains
    @trains ||= {}
  end

  def self.find(number)
    trains[number]
  end

  include ModuleVendor
  attr_reader :name, :type, :speed, :number

  NUMBER_FORMAT = /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}$/i
  NAME_FORMAT = /^[А-Я]{1}[а-я]*$/

  def initialize(name, type, number, wagons = [], route = [])
    @name = name
    @type = type
    @wagons = wagons
    @speed = 0
    @route = route
    @number = number
    validate! 
    Train.trains[number] = self
    register_instance
  end

  def prove
    [
    [:name, :presence],
    [:name, :format, NAME_FORMAT],
    [:number, :presence],
    [:number, :format, NUMBER_FORMAT]
    ]
  end

  def history
    @history ||= {}
  end

  def each_wagon
    @wagons.each do |wagon|
      yield wagon
    end
  end

  def to_s
    name = "Имя поезда:  #{@name}."
    type = " Тип: #{@type}."
    number = " Номер: #{@number}."
    length_train = " Количество вагонов:#{wagons.length}"
    name + type + number + length_train
  end

  def change_speed(speed_delta)
    @speed = [@speed + speed_delta, 0].max
  end

  attr_reader :wagons

  def stop
    @speed = 0
  end

  def attach_wagon(wagon)
    return if speed > 0
    return if type != wagon.type
    @wagons << wagon
  end

  def deattach_wagon
    @wagons.pop if @speed.zero?
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
end
