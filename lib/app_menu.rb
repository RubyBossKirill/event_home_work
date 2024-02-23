require_relative 'event_manager'

class AppMenu
    attr_reader :username
    def initialize(username)
        @appmenu = EventManager.new(username)
        @username = username
    end

    def run
        if username == "ADMIN"
            loop do 
            puts "Что вы хотите сделать"
            puts "1. Добавить мероприятие"
            puts "2. Удалить мероприятие"
            puts "3. Добавить участника"
            puts "4. Удалить участника"
            puts "5. Выход"
      
            choice = gets.chomp.to_i
            case choice
            when 1
                puts "Напишите название мероприятия"
                name_event = gets.chomp.to_s

                puts "Напишите дату провередия мероприятия"
                date_event = gets.chomp.to_s

                puts "Напишите местопроведения мероприятия"
                place_event = gets.chomp.to_s

                puts "Напишите количество доступных мест"
                seats_event = gets.chomp.to_s

                @appmenu.add_event(name_event, date_event, place_event, seats_event)
            when 2
                puts "Напишите название мероприятия которое хотите удалить"
                name_event = gets.chomp.to_s

                @appmenu.remove_event(name_event)
            when 3
                puts "Напишите ваше имя"
                name = gets.chomp.to_s

                puts "Напишите вашу фамилию"
                surname = gets.chomp.to_s

                puts "Напишите вашу почту"
                email = gets.chomp.to_s

                @appmenu.add_participant(@username, name, surname, email)
            when 4
                puts "Напиши ник участника которого удалить"
                username_del = gets.chomp.to_s

                @appmenu.remove_participant(username_del)
            when 5
                p "Хорошего дня вам:)"
                break
            end
            end
        else
            loop do 
                puts "Что вы хотите сделать"
                puts "1. Посмотреть доступные мероприятия"
                puts "2. Записаться на мероприятия"
                puts "3. Записать свои данные"
                puts "4. Удалить свои данные"
                puts "5. Выход"
          
                choice = gets.chomp.to_i
                case choice
                when 1

                when 2
                    if @appmenu.participant_exist?(username)
                        p "Выберите меропритие"
                        
                    else
                        p "Вас нету в списках, вам для начала нужно внести себя"
                    end

                when 3
                    puts "Напишите ваше имя"
                    name = gets.chomp.to_s
    
                    puts "Напишите вашу фамилию"
                    surname = gets.chomp.to_s
    
                    puts "Напишите вашу почту"
                    email = gets.chomp.to_s
    
                    @appmenu.add_participant(@username, name, surname, email)
                when 4
                    puts "Напиши ник участника которого удалить"
                    username_del = gets.chomp.to_s
    
                    @appmenu.remove_participant(username_del)
                when 5
                    p "Хорошего дня вам:)"
                    break
                end
                end
        end
    end

end