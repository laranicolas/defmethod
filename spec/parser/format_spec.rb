require 'rspec'
require_relative '../../lib/parser/format.rb'

RSpec.describe Parser::Format do

  context "#call" do
    
    describe "well format lines" do
      let(:lines) {[
        {
          'last_name': "Kournikova",
          'first_name': "Anna",
          'middle_initial': "F",
          'gender': "F",
          'date_of_birth': "6-3-1975",
          'favorite_color': "Red"
        }
      ]}
      it "gender and date should be formatted" do
        result = described_class.call(lines)
        expect(result).to be_a_kind_of(Array)
        expect(result.size).to be > 0
        expect(result.first[:gender]).to eq('Female')
        expect(result.first[:date_of_birth]).to eq('6/3/1975')
      end
    end

    describe "not listed gender" do
      let(:lines) {[
        {
          'last_name': "Kournikova",
          'first_name': "Anna",
          'middle_initial': "F",
          'gender': "R",
          'date_of_birth': "6-3-1975",
          'favorite_color': "Red"
        }
      ]}
      it "raise an expection" do
        expect { described_class.call(lines) }.to raise_error(Parser::Format::InvalidGenderValueError)
      end
    end

    describe "invalid month in date" do
      let(:lines) {[
        {
          'last_name': "Kournikova",
          'first_name': "Anna",
          'middle_initial': "F",
          'gender': "F",
          'date_of_birth': "26-3-1975",
          'favorite_color': "Red"
        }
      ]}
      it "raise an expection" do
        expect { described_class.call(lines) }.to raise_error(Parser::Format::InvalidDateValueError)
      end
    end

    describe "gender empty" do
      let(:lines) {[
        {
          'last_name': "Kournikova",
          'first_name': "Anna",
          'middle_initial': "F",
          'date_of_birth': "5-3-1975",
          'favorite_color': "Red"
        }
      ]}
      it "gender not exist in list" do
        expect(described_class.call(lines).first[:gender]).to be_nil
      end
    end

    describe "date empty" do
      let(:lines) {[
        {
          'last_name': "Kournikova",
          'first_name': "Anna",
          'middle_initial': "F",
          'favorite_color': "Red"
        }
      ]}
      it "date not exist in list" do
        expect(described_class.call(lines).first[:date_of_birth]).to be_nil
      end
    end
   end
end