module Validation

  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def validate(name, type_validate, pattern = nil)
      case type_validate
        when :presence
          raise "не может быть nil или пустым" if name.nil? || name.empty?
        when :format
          raise "не соответствует шаблону" unless pattern =~ name
        when :type
          raise "не соответствует типу" unless name.class == pattern
      end
      true
    end
  end

  def validate!(attribute, type_validate, pattern = nil)
    @valid ||= [true]
    name_value = self.send(attribute)
    self.class.validate(name_value, type_validate, pattern  )
  rescue StandardError => e
    str = "Атрибут #{attribute} " + e.message
    puts str
    @valid << false
  raise 
  end

  def valid?
    !@valid.member? false
  end
end


