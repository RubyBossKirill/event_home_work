class Participant

    def initialize(username, name, surname, email)
        @username = username
        @name = name
        @surname = surname
        @email = email
        @event = nil
    end

    def to_h 
        {
            name: @name, 
            surname: @surname,
            email: @email,
            event: @event
        }
    end
end
