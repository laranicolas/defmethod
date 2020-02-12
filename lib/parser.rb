require_relative 'parser/reader'
require_relative 'parser/display'

module Parser
  extend self

  INPUT_ATTRIBUTES = [
    ['space.txt', %i(last_name first_name middle_initial gender date_of_birth favorite_color), ' '],
    ['pipe.txt', %i(last_name first_name middle_initial gender favorite_color date_of_birth), '|'],
    ['comma.txt', %i(last_name first_name gender favorite_color date_of_birth), ',']
  ]

  def call
    display(content)
  end

  private
    def content
      Parser::Reader.call(INPUT_ATTRIBUTES)
    end

    def display(output)
      Parser::Display.call(output)
    end
end