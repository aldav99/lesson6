module Acessors

  def attr_accessor_with_history(*methods)
    
    define_method(:history) do
      @history ||= {}
    end

    methods.each do |method|
      raise TypeError.new("method name is not symbol") unless method.is_a?(Symbol)
      define_method(method) do
        instance_variable_get("@#{method}")
      end
      define_method("#{method}=") do |v|
        instance_variable_set("@#{method}", v)
        if !history.key?(method)
          then 
            history[method] = [].push v
          else
            history[method].push v
        end
      end
      define_method("#{method}_history") do
        history[method]
      end
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) do
      instance_variable_get(var_name)
    end
    define_method("#{name}=".to_sym) do |v|
      raise TypeError.new("method #{name} is not #{class_name}") unless v.is_a?(class_name)
      instance_variable_set(var_name, v)
    end
  end
end



