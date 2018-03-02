class Dialog

  def initialize(stations = [], trains = [], routes = {})
    @stations = stations
    @trains = trains
    @routes = routes
  end

  def output
    loop do

      puts "Что Вы хотите сделать?"
      puts "-- Введите 1 'станция' для добавления станции."
      puts "-- Введите 2 'список станций' для просмотра списка станций."
      puts "-- Введите 3 'поезд' для добавления поезда."
      puts "-- Введите 4 'маршрут' для создания маршрута."
      puts "-- Введите 5 'список маршрутов' для просмотра маршрутов."
      puts "-- Введите 6 'добавить в маршрут' для добавления станции в маршрут."
      puts "-- Введите 7 'удалить из маршрута' для удаления станции из маршрута."
      puts "-- Введите 8'назначить маршрут' для назначения маршрута поезду."
      puts "-- Введите 9 'поезда на станции' для просмотра поездов на станции."
      puts "-- Введите 10 'поезд вперед' для продвижения поезда вперед на одну станцию."
      puts "-- Введите 11 'поезд назад' для продвижения поезда назад на одну станцию."
      puts "-- Введите 12 'добавить вагон' для добавления вагона к поезду."
      puts "-- Введите 13 'отцепить вагон' для отцепления вагона от поезда."
      puts "-- Введите 14 'стоп' для выхода из программы."

      choice = gets.to_i

      case choice

        when 1
          station_input
        when 2
          station_list
        when 3
          add_train
        when 4
          add_route
        when 5
          route_list
        when 6
          add_route_station
        when 7
          delete_route_station
        when 8
          train_add_route
        when 9
          trains_at_the_station
        when 10
          train_move_forward
        when 11
          train_move_back
        when 12
          add_wagon
        when 13
          del_wagon
        when 14
          break
        else
          puts "Error!"
      end
    end
  end

  private

  def station_input
    puts "Введите название станции"
    station_name = gets.chomp
    @stations << Station.new(station_name)
  end

  def station_list
    puts "Список пуст" if @stations.empty?
    @stations.each_index { |index| puts "#{index}     #{@stations[index].name}" }
  end

  def add_train
    begin
      puts "Введите название поезда. Русские буквы, первая - заглавная"
      name = gets.chomp
      puts "Введите номер поезда. Формат: 3 цифры или буквы, необязательный дефис, 2 цифры или буквы"
      number = gets.chomp
      puts "Введите тип поезда (1 - Пассажирский или 2 - Грузовой)"
      type = gets.to_i
      if type == 1
        @trains << PassengerTrain.new(name, number)
        print_type = "Пассажирский"
      elsif type == 2
        @trains << CargoTrain.new(name, number)
        print_type = "Грузовой"
      else
        raise
      end
      puts "Создан поезд. Название: #{name}. Тип: #{print_type}; Номер: #{number}"
    rescue
      puts "Объект не создан."
      add_train
    end
  end

  def add_route
    puts "Введите номер маршрута"
    id = gets.to_i
    puts "Введите номер начальной станции из списка станций"
    start = gets.to_i
    puts "Введите номер конечной станции из списка станций"
    terminate = gets.to_i
    @routes[id] = Route.new(@stations[start], @stations[terminate])
  end

  def route_list
    puts "Список пуст" if @routes.empty?
    routes_content(@routes)
  end

  def add_route_station
    puts "Введите номер маршрута"
    id = gets.to_i
    puts "Введите номер станции из списка станций для добавления"
    station_index = gets.to_i
    station = @stations[station_index]
    return if @routes[id].stations.include?(station)
    @routes[id].add_station(station)
  end

  def delete_route_station
    puts "Введите номер маршрута"
    id = gets.to_i
    puts "Выберите станцию для удаления"
    @routes[id].stations.each { |station| puts "#{station.name}" }
    station = gets.chomp
    if @routes[id].delete_station(station)
      puts "Удалена станция #{station}"
    else
      puts "Конечные точки нельзя удалять"
    end
  end

  def train_add_route
    puts "Выберите поезд из списка поездов"
    trains_content(@trains)
    puts
    train_name = gets.chomp
    puts "Выберите маршрут из списка маршрутов"
    routes_content(@routes)
    puts
    id = gets.to_i
    route = @routes[id]
    train = @trains.find { |train| train.name == train_name }
    train.route = route
  end

  def trains_at_the_station
    puts "Введите номер станции из списка станций"
    station_index = gets.to_i
    station = @stations[station_index]
    station.trains.each {|train| puts train.name } 
  end

  def train_from_list
    puts "Выберите поезд из списка поездов"
    trains_content(@trains)
    puts
    name = gets.chomp
  end

  def train_move_forward
    train_name = train_from_list
    train = @trains.find { |train| train.name == train_name }
    train.go_forward
  end

  def train_move_back
    train_name = train_from_list
    train = @trains.find { |train| train.name == train_name }
    train.go_back
  end

  def add_wagon
    train_name = train_from_list
    train = @trains.find { |train| train.name == train_name }
    if train.type == :passenger 
      pw = PassengerWagon.new
      train.attach_wagon(pw)
      puts train.wagons.size
    else
      cw = CargoWagon.new
      train.attach_wagon(cw)
      puts train.wagons.size
    end
  end

  def del_wagon
    train_name = train_from_list
    train = @trains.find { |train| train.name == train_name }
    train.deattach_wagon
    puts train.wagons.size
  end

  def trains_content(arr)
    arr.each { |element| print "#{element.name}   " }
  end

  def routes_content(routes)
    @routes.each do |id, value|
      puts "#{id}"
      value.stations.each { |station| puts "#{station.name}" }
    end
  end
end
