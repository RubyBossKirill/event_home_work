require 'json'
require_relative 'participant'
require_relative 'event'

class EventManager

    DATA_JSON_PARTICIPANTS = 'data/data_participant.json'
    DATA_JSON_EVENTS = 'data/data_events.json'

    attr_reader :username, :name, :surname, :email, :to_h
    def initialize(username)
        @events = {}
        @participants = {}
        @json_hash = {}
        @json_hash_events = {}
        json_from_load
        if participant_exist?(username)
            authentication_participant(username)
        end
    end

    # Добавление участника. Создается новый обьект
    def add_participant(username, name, surname, email)
        user_participant = Participant.new(username, name, surname, email)
        @participants[username] = user_participant
        save_participant(username)

        puts "Участник #{name} добавлен"
    end

    # Удаление участника. Удаление + сохранение файла
    def remove_participant(username)
        @json_hash.delete(username)
        save_json_hash

        p "#{username} удален из списка"
    end

    # Добавление нового мероприятия
    def add_event(name_event, date_event, place_event, seats_event)
        event = Event.new(name_event, date_event, place_event, seats_event)
        @events[name_event] = event
        save_event(name_event)

        p "#{name_event} добавлен в список" 
    end

    # Удаление мероприятия и сохранение базы
    def remove_event(name_event)
        @json_hash_events.delete(name_event)
        save_json_hash_events

        p "#{name_event} удален из списка"
    end

    # Просмотр доступных мероприятий
    def view_events
        data = @json_hash_events.keys
        data.each_with_index{ |event, index| p "#{index + 1}. #{event}" }
    end

    # Регистрация юзера на мероприятие
    def registration_event(username, event)
        @participants[username].add_event_user(event)
        save_participant(username)
        p "#{username} записался на #{event}"
    end

    # Аутентификация участника. Проверка есть ли данный участник
    def participant_exist?(username)
        @json_hash.key?(username)
    end

    private

    # Аутентификация участника. Если существует, выгружаем его из базы
    def authentication_participant(username)
        user_participant = Participant.new(username, @json_hash[username]['name'], @json_hash[username]['surname'], @json_hash[username]['email'])
        @participants[username] = user_participant
    end

    # Загружаем базу участников, загружаем базу мероприятий
    def json_from_load
        if File.exist?(DATA_JSON_PARTICIPANTS)
            json_data = File.read(DATA_JSON_PARTICIPANTS)
            begin
                @json_hash = JSON.parse(json_data)
            rescue JSON::ParserError
                @json_hash = {}
            end
        end
        if File.exist?(DATA_JSON_EVENTS)
            json_data_events = File.read(DATA_JSON_EVENTS)
            begin
                @json_hash_events = JSON.parse(json_data_events)
            rescue JSON::ParserError
                @json_hash_events = {}
            end
        end
    end

    # Сохраняем участника в базе
    def save_participant(username)
        File.open(DATA_JSON_PARTICIPANTS, 'w') do |file|
            @json_hash[username] = @participants[username].to_h
            json_data = @json_hash.to_json
            file.write(json_data)
        end
    end

    # Сохраняем базу в файле
    def save_json_hash
        File.open(DATA_JSON_PARTICIPANTS, 'w') do |file|
            json_data = @json_hash.to_json
            file.write(json_data)
        end
    end

    # Сохраняем мероприятие в базу
    def save_event(name_event)
        File.open(DATA_JSON_EVENTS, 'w') do |file|
            @json_hash_events[name_event] = @events[name_event].to_h 
            json_data = @json_hash_events.to_json
            file.write(json_data)
        end
    end

    # Сохраняем базу в файле
    def save_json_hash_events
        File.open(DATA_JSON_EVENTS, 'w') do |file|
            json_data = @json_hash_events.to_json
            file.write(json_data)
        end
    end
end