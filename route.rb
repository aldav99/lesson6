require_relative 'instance_counter'
require_relative 'validation'
require_relative 'acessors'

class Route
  include InstanceCounter
  include Validation
  extend Acessors


  attr_reader :stations, :start, :terminate

  def initialize(start, terminate)
    @stations = [start, terminate]
    @start = start
    @terminate = terminate
    validate!
    register_instance
  end

  def prove
    [
    [:start, :presence],
    [:terminate, :presence],
    [:start, :type, Station],
    [:terminate, :type, Station]
    ]
  end

  def history
    @history ||= {}
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(name)
    return if [start.name, terminate.name].include? name
    @stations.delete_if { |station| station.name == name }
  end
end
