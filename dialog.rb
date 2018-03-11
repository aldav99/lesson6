require_relative 'module_dialog'

class Dialog
  include ModuleDialog

  def initialize(stations = [], trains = [], routes = {})
    @stations = stations
    @trains = trains
    @routes = routes
  end

  def select_action_1_8
    puts "-- Введите 1 'станция' для добавления станции."
    puts "-- Введите 2 'список станций' для просмотра списка станций."
    puts "-- Введите 3 'поезд' для добавления поезда."
    puts "-- Введите 4 'маршрут' для создания маршрута."
    puts "-- Введите 5 'список маршрутов' для просмотра маршрутов."
    puts "-- Введите 6 'добавить в маршрут' для добавления станции в маршрут."
    puts '-- Введите 7 для удаления станции из маршрута.'
    puts "-- Введите 8'назначить маршрут' для назначения маршрута поезду."
  end

  def select_action_9_20
    puts "-- Введите 9 'поезда на станции' для просмотра поездов на станции."
    puts '-- Введите 10 для продвижения поезда вперед на одну станцию.'
    puts '-- Введите 11 для продвижения поезда назад на одну станцию.'
    puts "-- Введите 12 'добавить вагон' для добавления вагона к поезду."
    puts "-- Введите 13 'отцепить вагон' для отцепления вагона от поезда."
    puts "-- Введите 14 'список вагонов у поезда'"
    puts "-- Введите 15 'занимать место или объем в вагоне'"
    puts "-- Введите 20 'стоп' для выхода из программы."
  end

  def select_action
    puts 'Что Вы хотите сделать?'
    select_action_1_8
    select_action_9_20
    gets.to_i
  end

  def error
    puts 'ERROR'
    output
  end

  ACTION = { 1 => 'station_input', 2 => 'station_list', 3 => 'add_train',
             4 => 'add_route', 5 => 'route_list', 6 => 'add_route_station',
             7 => 'delete_route_station', 8 => 'train_add_route',
             9 => 'trains_at_the_station', 10 => 'train_move_forward',
             11 => 'train_move_back', 12 => 'add_wagon', 13 => 'del_wagon',
             14 => 'list_wagon', 15 => 'occupy_wagon', 20 => 'stop' }.freeze

  def output
    loop do
      choice = select_action
      return if choice == 20
      instance_eval ACTION[choice] || error
    end
  end
end
