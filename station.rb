require_relative 'instance_counter'
require_relative 'validation'
require_relative 'acessors'

class Station
  include InstanceCounter
  include Validation
  extend Acessors

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

  validate :name, :presence
  validate :name, :format, NAME_FORMAT
  
  def each_train
    @trains.each do |train|
      yield train
    end
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
end
