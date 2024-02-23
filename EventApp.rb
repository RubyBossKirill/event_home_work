require_relative 'lib/app_menu'

p "Введите ваш логин, для Аутентификация"
username = gets.chomp.to_s

app = AppMenu.new(username)
app.run