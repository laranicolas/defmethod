require 'date'

module Challenge
  module Sort
    extend self

    def by_gender_asc_then_last_name_asc(rows)
      rows.sort_by do |row|
        [row[:gender], row[:last_name]]
      end
    rescue
      raise ArgumentError
    end

    def by_dob_asc_then_last_name_asc(rows)
      rows.sort_by do |row|
        [cast_to_date(row[:date_of_birth]), row[:last_name]]
      end
    rescue
      raise ArgumentError
    end

    def by_last_name_desc(rows)
      rows.sort_by do |row|
        row[:last_name]
      end.reverse
    rescue
      raise ArgumentError
    end

    private

      def cast_to_date(str)
        Date.strptime(str, '%m/%d/%Y')
      end

  end
end