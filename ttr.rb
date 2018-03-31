require_relative 'train'
require_relative 'station'
require_relative 'route'

require_relative 'passenger_train'
require_relative 'cargo_train'

require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

require_relative 'dialog'

#pb = Station.new('Питер')
#mw = Station.new('Москва')
#kv = Station.new('Киев')
#dp = Station.new('Долгопрудный')

#r1 = Route.new(pb, mw)
#r1.add_station(dp)
#r1.add_station(kv)

tr1 = Train.new('ервый', :cargo, '500-01')
#tr1.route = r1
tr2 = Train.new('Второй', :passenger, '500-02')
#tr2.route = r1
tr3 = Train.new('Третий', :cargo, '500-03')
#tr3.route = r1

puts tr1.valid?
puts '__________________________________'
p Train.prove