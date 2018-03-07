require_relative 'train'
require_relative 'station'
require_relative 'route'

require_relative 'passenger_train'
require_relative 'cargo_train'

require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

require_relative 'dialog'

pb = Station.new("Питер")
mw = Station.new("Москва")
kv = Station.new("Киев")
dp = Station.new("Долгопрудный")

r1 = Route.new(pb, mw)
r1.add_station(dp)
r1.add_station(kv)

tr1 = Train.new("Первый",:cargo, "500-01")
tr1.route=(r1)
tr2 = Train.new("Второй",:passenger,"500-02")
tr2.route=(r1)
tr3 = Train.new("Третий",:cargo, "500-03")
tr3.route=(r1)

pb.train_to_block {|train| puts "#{train.name}" }

cw1 = CargoWagon.new(1000)
puts "Было в 1 вагоне #{cw1.value}"
cw2 = CargoWagon.new(1500)
puts "Было в 2 вагоне #{cw2.value}"
cw1.take_a_value(800)
puts "Стало в 1 вагоне #{cw1.value}"
puts "Занято в 1 вагоне #{cw1.occupied}"
puts "Стало в 2 вагоне #{cw2.value}"
puts "Занято в 2 вагоне #{cw2.occupied}"

puts "++++++++++++++++++++++++++++++++++++++++"
pw1 = PassengerWagon.new(100)
puts "Было в 1 вагоне #{pw1.places}"
pw2 = PassengerWagon.new(500)
puts "Было в 2 вагоне #{pw2.places}"
pw1.take_a_places
puts "Стало в 1 вагоне #{pw1.places}"
puts "Занято в 1 вагоне #{pw1.occupied}"
puts "++++++++++++++++++++++++++++++++++++++++"
pw1.take_a_places
puts "Стало в 1 вагоне #{pw1.places}"
puts "Занято в 1 вагоне #{pw1.occupied}"
puts "++++++++++++++++++++++++++++++++++++++++"
puts "Стало в 2 вагоне #{pw2.places}"
puts "Занято в 2 вагоне #{pw2.occupied}"

puts "++++++++Работа с поездами +++++++++++++"

tr1.attach_wagon(cw1)
tr1.attach_wagon(cw2)

tr2.attach_wagon(pw1)
tr2.go_forward

puts "++++++++станции+++++++++++++"
Station.all.each do  |station| 
  puts "Название станции:  #{station.name}" unless station.trains == []
  station.train_to_block do |train|
    puts "++++++++ПОЕЗДА+++++++++++++"
    puts "Имя поезда:  #{train.name}"
    puts "Тип: #{train.type}"
    puts "Номер: #{train.number}"
    puts "Количество вагонов:#{train.wagons.length}"
    train.wagons.each do |wagon|
      puts "++++++++ВАГОНЫ+++++++++++++"
      puts "Номер вагона: #{wagon.number}"
      puts "Тип вагона: #{wagon.type}"
      if wagon.type == :cargo
        puts "Свободный объем: #{wagon.value}; Занятый объем: #{wagon.occupied}"
      else
        puts "Свободные места: #{wagon.places}; Занятые места: #{wagon.occupied}"
      end
    end
  end
end



