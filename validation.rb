module Validation

    def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    
    def prove
      @prove ||= []
    end
    
    def validate(*args)
      self.prove << args
    end
  end
    
  def validate_presence(attribute, attribute_value, _ )
    raise "#{attribute} не может быть nil или пустым" if attribute_value.nil? || attribute_value.empty?
  end

  def validate_format(attribute, attribute_value, pattern)
    raise "#{attribute} не соответствует шаблону" unless pattern =~ attribute_value
  end

  def validate_type(attribute, attribute_value, class_name)
    raise "#{attribute} не соответствует типу" unless attribute_value.class == class_name
  end
  

  def validate!
    self.class.prove.each do |(attr_name, rule, args)| 
      attribute_value = send(attr_name)
      method_name = 'validate_' + rule.to_s
      method_parameters = args || 0
      send method_name, attr_name, attribute_value, method_parameters
    end
    
  rescue StandardError => e
    puts e.message
    raise
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end

