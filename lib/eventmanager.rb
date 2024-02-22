require 'json'
require_relative 'participant'
require_relative 'event'

class EventManager
    attr_reader :username, :name, :surname, :email, :to_h
    def initialize
        @events = {}
        @participants = {}
        @json_hash = {}
        load_participant
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
    private

    def load_participant 
        if File.exist?('../data/data_participant.json')
            json_data = File.read('../data/data_participant.json')
            begin
                @json_hash = JSON.parse(json_data)
            rescue JSON::ParserError
                @json_hash = {}
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
end

user = EventManager.new

user.add_participant("DianaCher", "Diana", "Test", "test4@gmail.com")
user.add_participant("LonelyWell", "Kirilll", "Elin", "test@gmail.com")
user.add_participant("Dimitro", "Dima", "Test", "test2@gmail.com")


user.remove_participant("LonelyWell")