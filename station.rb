require_relative 'instance_counter'

class Station

  include InstanceCounter 

  NAME_FORMAT = /^[А-Я]{1}[а-я]*$/

  @@stations = []

  def self.all
    @@stations
  end

  attr_reader :name, :trains
  
  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def add_train(train)
    @trains << train
  end

  def delete_train(train)
    @trains.delete(train)
  end

  def list_by_type(type)
    self.trains.select { |train| train.type == type }
  end

  protected

  def validate!
    raise "Name can't be nil" if name.nil?
    raise "Name has invalid format" if name !~ NAME_FORMAT
  end
end