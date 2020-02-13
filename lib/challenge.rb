require_relative 'challenge/reader'
require_relative 'challenge/display'

module Challenge
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
      Challenge::Reader.call(INPUT_ATTRIBUTES)
    end

    def display(output)
      Challenge::Display.call(output)
    end
end