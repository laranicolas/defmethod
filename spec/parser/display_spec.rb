require 'rspec'
require_relative '../../lib/parser/Display.rb'

RSpec.describe Parser::Display do

  context "#call" do
    let(:content) {[
      {
        'last_name': 'Kournikova',
        'first_name': 'Anna',
        'middle_initial': 'F',
        'gender': 'Female',
        'date_of_birth': '6/3/1975',
        'favorite_color': 'Red'
      },
      {
        'last_name': 'Abercrombie',
        'first_name': 'Neil',
        'gender': 'Male',
        'date_of_birth': '02/13/1943',
        'favorite_color': 'Tan'
      },
      {
        'last_name': 'Bouillon',
        'first_name': 'Francis',
        'middle_initial': 'G',
        'gender': 'Male',
        'date_of_birth': '6/3/1975',
        'favorite_color': 'Blue'
      }
    ]}

    describe "display in well format" do
      it "check output is string and sorted" do
        expected =<<~EXPECTED
          Output 1:
          Kournikova Anna Female 6/3/1975 Red
          Abercrombie Neil Male 02/13/1943 Tan
          Bouillon Francis Male 6/3/1975 Blue

          Output 2:
          Abercrombie Neil Male 02/13/1943 Tan
          Bouillon Francis Male 6/3/1975 Blue
          Kournikova Anna Female 6/3/1975 Red

          Output 3:
          Kournikova Anna Female 6/3/1975 Red
          Bouillon Francis Male 6/3/1975 Blue
          Abercrombie Neil Male 02/13/1943 Tan
        EXPECTED
        expect(described_class.call(content)).to be_kind_of(String)
        expect(described_class.call(content)).to eq(expected)
      end
    end

    describe "display empty content" do
      it "check output is string and empty message" do
        expect(described_class.call(content)).to be_kind_of(String)
        expect(described_class.call([])).to eq('EMPTY CONTENT')
      end
    end

  end
end