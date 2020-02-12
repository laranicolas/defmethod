require 'date'

module Parser
  module Format
    extend self

    def call(attributes)
      attributes.map do |attribute|
        uniform_gender!(attribute[:gender]) if attribute[:gender]
        uniform_date!(attribute[:date_of_birth]) if attribute[:date_of_birth]
        attribute
      end
    end

    private

      def uniform_gender!(gender)
        case gender.upcase
        when 'F', 'FEMALE'
          gender.replace('Female')
        when 'M', 'MALE'
          gender.replace('Male')
        else
          raise InvalidGenderValueError.new("Not listed gender: #{gender}")
        end
      end

      def uniform_date!(date)
        date_object = Date.strptime(date.gsub(/\D/, '-'), '%m-%d-%Y')
        date.replace(date_object.strftime('%m/%d/%Y'))
      rescue
        raise InvalidDateValueError.new("invalid date: #{date}")
      end

    class InvalidGenderValueError < StandardError; end
    class InvalidDateValueError < StandardError; end
  end
end