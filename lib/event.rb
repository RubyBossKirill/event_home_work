class Event
    def initialize(name_event, date_event, place_event, seats_event)
        @name_event = name_event
        @date_event = date_event
        @place_event = place_event
        @seats_event = seats_event
    end

    def to_h 
        {
            date_event: @date_event,
            place_event: @place_event,
            seats_event: @seats_event
        }
    end
end