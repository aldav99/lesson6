require_relative 'instance_counter'

class Route
  
  
  include InstanceCounter 
       
  
  attr_reader :stations

  def initialize(start, terminate)
    @stations = [start, terminate]
    validate!
    register_instance
  end
  
  def valid?
    validate!
    true
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
    raise "Start has invalid format" unless start.is_a?( Station ) 
    raise "Terminate has invalid format" unless terminate.is_a?( Station )
  end
end