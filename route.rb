require_relative 'instance_counter'

class Route
  
  
  include InstanceCounter 
       
  
  attr_reader :stations

  def initialize(start, terminate)
    @stations = [start, terminate]
    register_instance
    validate!
  end
  
  def valid?
    validate!
  rescue
    false
  end

  def start
    @stations[0] 
  end

  def terminate
    @stations[-1]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end
  
  def delete_station(name)
    return if start.name == name || terminate.name == name
    @stations.delete_if {|station| station.name == name }
  end
  
  def validate!
    raise "Start can't be nil" if start.nil?
    raise "Terminate can't be nil" if terminate.nil?
    raise "Start has invalid format" if start.class != Station
    raise "Terminate has invalid format" if terminate.class != Station
    true
  end
end