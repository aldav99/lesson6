module DialogTrain
  def entitle_train
    puts 'Введите название поезда. Русские буквы, первая - заглавная'
    name = gets.chomp
    print 'Введите номер поезда.'
    puts ' Формат: 3 цифры или буквы, необязательный дефис, 2 цифры или буквы'
    number = gets.chomp
    puts 'Введите тип поезда (1 - Пассажирский или 2 - Грузовой)'
    type = gets.to_i
    [name, number, type]
  end

  def create_passenger_train(name, number)
    @trains << PassengerTrain.new(name, number)
    puts "Создан поезд. Название: #{name}. Тип: Пассажирский; Номер: #{number}"
  end

  def create_cargo_train(name, number)
    @trains << CargoTrain.new(name, number)
    puts "Создан поезд. Название: #{name}. Тип: Грузовой; Номер: #{number}"
  end

  def create_train
    name, number, type = entitle_train
    if type == 1
      create_passenger_train(name, number)
    elsif type == 2
      create_cargo_train(name, number)
    else
      puts 'Неверный тип (1 - Пассажирский или 2 - Грузовой)'
      add_train
    end
  end

  def add_train
    create_train
  rescue 
    puts 'Объект не создан.'
    add_train
  end

  def train_add_route
    puts 'Выберите поезд из списка поездов'
    trains_content(@trains)
    train_name = gets.chomp
    puts 'Выберите маршрут из списка маршрутов'
    routes_content(@routes)
    puts
    id = gets.to_i
    route = @routes[id]
    train = @trains.find { |tr| tr.name == train_name }
    train.route = route
  end

  def trains_at_the_station
    puts 'Введите номер станции из списка станций'
    station_index = gets.to_i
    station = @stations[station_index]
    station.each_train { |train| puts train }
  end

  def train_from_list
    puts 'Выберите поезд из списка поездов'
    trains_content(@trains)
    puts
    name = gets.chomp
    @trains.find { |train| train.name == name }
  end

  def train_move_forward
    train = train_from_list
    train.go_forward
  end

  def train_move_back
    train = train_from_list
    train.go_back
  end

  def trains_content(arr)
    arr.each { |element| print "#{element.name}   " }
  end
end
