module DialogWagon
  def add_wagon
    train = train_from_list
    if train.type == :passenger
      pw = create_passenger
      train.attach_wagon(pw)
    else
      cw = create_cargo
      train.attach_wagon(cw)
    end
  end

  def create_passenger
    puts 'Введите число пассажиромест'
    places = gets.to_f
    PassengerWagon.new(places)
  end

  def create_cargo
    puts 'Введите общий объем'
    volume = gets.to_f
    CargoWagon.new(volume)
  end

  def list_wagon
    train = train_from_list
    puts "Имя поезда:  #{train.name}"
    puts "Количество вагонов:#{train.wagons.length}"
    train.each_wagon { |wagon| puts wagon }
  end

  def wagon_from_list
    train = train_from_list
    puts 'Выберите вагон из списка'
    list_wagon
    number = gets.to_i
    train.wagons.find { |wagon| wagon.number == number }
  end

  def occupy_wagon
    wagon = wagon_from_list
    if wagon.type == :cargo
      puts 'Введите занимаемый объем'
      volume = gets.to_f
      wagon.take_a_volume(volume)
    else
      puts 'Будет занято одно пассажироместо'
      wagon.take_a_places
    end
  end

  def del_wagon
    train = train_from_list
    train.deattach_wagon
    puts train.wagons.size
  end
end
