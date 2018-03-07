require_relative 'module_vendor'

class Wagon

  include ModuleVendor

  def number
    @number ||= rand(100)
  end
end