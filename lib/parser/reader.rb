require_relative 'format'

module Parser
  module Reader
    extend self

    PROJECT_DIRECTORY = Dir.getwd
    INPUT_FILES_DIRECTORY = 'input_files'

    def call(attributes)
      rows = attributes.flat_map do |input_attribute|
        if input_attribute.size != 3
          error_msg = 'Input should contain list with 3 columns (file_name, headers, delimiters)'
          raise InputAttributesError.new(error_msg)
        end

        file_name, headers, delimiter = input_attribute
        read(file_name, headers, delimiter)
      end

      format(rows)
    end

    private

      def read(file_name, headers, delimiter)
        full_path = build_path(file_name)
        content_file = File.read(full_path)
        parse(content_file, headers, delimiter)
      rescue Errno::ENOENT
        raise InputFileNameError.new("File #{file_name} does not exist in #{full_path}")
      end

      def build_path(file_name)
        File.join(PROJECT_DIRECTORY, INPUT_FILES_DIRECTORY, file_name)
      end

      def parse(content, headers, delimiter)
        return [] if content.strip! && content.empty?

        response = content.lines(chomp:true).map do |line|
          line.split(delimiter).map(&:strip)
        end

        response.map do |line|
          Hash[headers.zip line]
        end
      end

      def format(rows)
        Parser::Format::call(rows)
      end

    class InputAttributesError < StandardError; end
    class InputFileNameError < StandardError; end
  end
end