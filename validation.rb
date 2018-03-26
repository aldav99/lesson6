module Validation

  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def presence(attribute, attribute_value, parametr)
      raise "#{attribute} не может быть nil или пустым" if attribute_value.nil? || attribute_value.empty?
      true
    end

    def format(attribute, attribute_value, pattern)
      raise "#{attribute} не соответствует шаблону" unless pattern =~ attribute_value
      true
    end

    def type(attribute, attribute_value, class_name)
      raise "#{attribute} не соответствует типу" unless attribute_value.class == class_name
      true
    end
  end

  def validate!
    @valid = true
    self.prove.each do |method| 
      attribute = method[0]
      attribute_value = self.send(method[0])
      method_name = method[1]
      method_parameters = method[2] || 0
      self.class.send method_name, attribute, attribute_value, method_parameters
    end
  rescue StandardError => e
    @valid = false
    puts  e.message
    raise
  end

  def valid?
    validate!
    @valid
  end
end


