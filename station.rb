require_relative 'instance_counter'

class Station
  include InstanceCounter

  NAME_FORMAT = /^[А-Я]{1}[а-я]*$/

  def self.stations
    @stations ||= []
  end

  def self.all
    stations
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    validate!
    Station.stations << self
    register_instance
  end

  def each_train
    @trains.each do |train|
      yield train
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add_train(train)
    @trains << train
  end

  def delete_train(train)
    @trains.delete(train)
  end

  def list_by_type(type)
    trains.select { |train| train.type == type }
  end

  protected

  def validate!
    raise "Name can't be nil" if name.nil?
    raise 'Name has invalid format' if name !~ NAME_FORMAT
  end
end
