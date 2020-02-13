require_relative 'sort'

module Challenge
  module Display
    extend self

    def call(content)
      output(content)
    end

    private

      def output(content)
        return 'EMPTY CONTENT' if content.empty?

        one_sorted = Challenge::Sort.by_gender_asc_then_last_name_asc(content)
        two_sorted = Challenge::Sort.by_dob_asc_then_last_name_asc(content)
        third_sorted = Challenge::Sort.by_last_name_desc(content)
        <<~OUTPUT
          Output 1:
          #{output_line(one_sorted).join("\n")}

          Output 2:
          #{output_line(two_sorted).join("\n")}

          Output 3:
          #{output_line(third_sorted).join("\n")}
        OUTPUT
      end

      def output_line(columns)
        columns.map do |col|
          "#{col[:last_name]} #{col[:first_name]} #{col[:gender]} #{col[:date_of_birth]} #{col[:favorite_color]}"
        end
      end
  end
end