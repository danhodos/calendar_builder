require 'builder'

module Calendar
  module Builder
    class Day
      attr_accessor :options
      
      def initialize(options = {})
        @options = {
          :date => Date.today,
          :begin_hour => 7,
          :end_hour => 18
        }.merge(options)
        @options[:except] = [@options[:except]].compact.flatten
      end
      
      def date
        options[:date]
      end
      
      def begin_on
        date.to_time
      end
      
      def end_on
        date.to_time.end_of_day
      end
      
      def hours
        (options[:begin_hour]..options[:end_hour]).collect do |hour|
          date.to_time.change :hour => hour
        end
      end
      
      def next
        day = Day.new(options.merge(:date => date + 1))
        while options[:except].include?(DAYNAME_SYMBOLS[day.date.wday])
          day = day.next
        end
        day
      end
      
      def previous
        day = Day.new(options.merge(:date => date - 1))
        while options[:except].include?(DAYNAME_SYMBOLS[day.date.wday])
          day = day.previous
        end
        day
      end
    end
  end
end
