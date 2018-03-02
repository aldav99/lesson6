module InstanceCounter
  
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
  
  module ClassMethods
  
  def instances
    @instances ||= 0
  end

  def instances=(value)
    @instances = value
  end

  def increment_instances
    self.instances += 1
  end
end 

  module InstanceMethods
    protected
    def register_instance
      self.class.increment_instances
    end
  end
end