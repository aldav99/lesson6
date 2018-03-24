require_relative 'instance_counter'
require_relative 'validation'
require_relative 'acessors'

class Route
  include InstanceCounter
  include Validation
  include Acessors


  attr_reader :stations, :start, :terminate

  def initialize(start, terminate)
    @stations = [start, terminate]
    @start = start
    @terminate = terminate
    validate! :start, :presence 
    validate! :terminate, :presence 
    validate! :start, :type, Station 
    validate! :terminate, :type, Station 
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(name)
    return if [start.name, terminate.name].include? name
    @stations.delete_if { |station| station.name == name }
  end
end
