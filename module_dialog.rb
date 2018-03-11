require_relative 'dialog_wagon'
require_relative 'dialog_train'

module ModuleDialog
  include DialogWagon
  include DialogTrain
  def station_input
    puts 'Введите название станции'
    station_name = gets.chomp
    @stations << Station.new(station_name)
    puts "Создана станция. Название: #{station_name}"
  rescue StandardError => e
    puts e.message
    puts 'Объект не создан.'
    station_input
  end

  def station_list
    puts 'Список пуст' if @stations.empty?
    @stations.each_index { |index| puts "#{index}   #{@stations[index].name}" }
  end

  def select_station_for_add
    puts 'Введите номер маршрута'
    id = gets.to_i
    puts 'Введите номер начальной станции из списка станций'
    start = gets.to_i
    puts 'Введите номер конечной станции из списка станций'
    terminate = gets.to_i
    [id, start, terminate]
  end

  def add_route
    id, start, terminate = select_station_for_add
    @routes[id] = Route.new(@stations[start], @stations[terminate])
    puts "Маршрут:#{id} #{@stations[start].name}-#{@stations[terminate].name}"
  rescue StandardError => e
    puts e.message
    puts 'Объект не создан.'
    add_route
  end

  def route_list
    puts 'Список пуст' if @routes.empty?
    routes_content(@routes)
  end

  def add_route_station
    puts 'Введите номер маршрута'
    id = gets.to_i
    puts 'Введите номер станции из списка станций для добавления'
    station_index = gets.to_i
    station = @stations[station_index]
    return if @routes[id].stations.include?(station)
    @routes[id].add_station(station)
  end

  def select_station_for_delete(id)
    puts 'Выберите станцию для удаления'
    @routes[id].stations.each { |station| puts station.name.to_s }
    gets.chomp
  end

  def delete_route_station
    puts 'Введите номер маршрута'
    id = gets.to_i
    station = select_station_for_delete(id)
    if @routes[id].delete_station(station)
      puts "Удалена станция #{station}"
    else
      puts 'Конечные точки нельзя удалять'
    end
  end

  def routes_content(_routes)
    @routes.each do |id, value|
      puts id.to_s
      value.stations.each { |station| puts station.name.to_s }
    end
  end
end
