require 'json'
require_relative 'participant'
require_relative 'event'

class EventManager
    attr_reader :username, :name, :surname, :email, :to_h
    def initialize(username)
        @events = {}
        @participants = {}
        @json_hash = {}
        @json_hash_events = {}
        load_participant
        load_events
        if participant_exist?(username)
            authentication_participant(username)
        end
    end

    def add_participant(username, name, surname, email)
        user_participant = Participant.new(username, name, surname, email)
        @participants[username] = user_participant
        save_participant(username)

        puts "Участник #{name} добавлен"
    end

    def remove_participant(username)
        @json_hash.delete(username)
        save_json_hash

        p "#{username} удален из списка"
    end

    def add_event(name_event, date_event, place_event, seats_event)
        event = Event.new(name_event, date_event, place_event, seats_event)
        @events[name_event] = event
        save_event(name_event)

        p "#{name_event} добавлен в список" 
    end

    def remove_event(event)
        @json_hash_events.delete(event)
        save_json_hash_events

        p "#{username} удален из списка"
    end

    private
    
    def participant_exist?(username)
        @json_hash.key?(username)
    end

    def authentication_participant(username)
        user_participant = Participant.new(username, @json_hash[username]['name'], @json_hash[username]['surname'], @json_hash[username]['email'])
        @participants[username] = user_participant
    end

    def load_participant 
        if File.exist?('../data/data_participant.json')
            json_data = File.read('../data/data_participant.json')
            begin
                @json_data = JSON.parse(json_data)
            rescue JSON::ParserError
                @json_data = {}
            end
        end
    end

    def load_events
        if File.exist?('../data/data_events.json')
            json_data_events = File.read('../data/data_events.json')
            begin
                @json_hash_events = JSON.parse(json_data_events)
            rescue JSON::ParserError
                @json_hash_events = {}
            end
        end
    end

    def save_participant(username)
        File.open('../data/data_participant.json', 'w') do |file|
            @json_hash[username] = @participants[username].to_h
            json_data = @json_hash.to_json
            file.write(json_data)
        end
    end

    def save_json_hash
        File.open('../data/data_participant.json', 'w') do |file|
            json_data = @json_hash.to_json
            file.write(json_data)
        end
    end

    def save_event(name_event)
        File.open('../data/data_events.json', 'w') do |file|
            @json_hash_events[name_event] = @events[name_event].to_h 
            json_data = @json_hash_events.to_json
            file.write(json_data)
        end
    end

    def save_json_hash_events
        File.open('../data/data_participant.json', 'w') do |file|
            json_data = @json_hash_events.to_json
            file.write(json_data)
        end
    end
end

user = EventManager.new("Dimitro")
user.add_participant("Dimitro", "Dima", "Tester", "test@gmail.com")

user.add_event("Сдача ДЗ", "23.02.2024", "Телеграм", "1")
