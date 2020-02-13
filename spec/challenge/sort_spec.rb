require 'rspec'
require_relative '../../lib/challenge/sort.rb'

RSpec.describe Challenge::Sort do
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

  context "#by_gender_asc_then_last_name_asc" do
    describe "sort by gender asc and last name asc" do
      it "return a sorted list" do
        result = described_class.by_gender_asc_then_last_name_asc(content)
        expect(result.first[:gender]).to eq('Female')
        expect(result.first[:last_name]).to eq('Kournikova')
      end

      it "raise an exception when gender not exist" do
        content.first.delete(:gender)
        expect { described_class.by_gender_asc_then_last_name_asc(content) }.to raise_error(ArgumentError)
      end
    end
   end

   context "#by_dob_asc_then_last_name_asc" do
    describe "sort by date of birthday asc and last name asc" do
      it "return a sorted list" do
        result = described_class.by_dob_asc_then_last_name_asc(content)
        expect(result.first[:last_name]).to eq('Abercrombie')
      end

      it "raise an exception when date of birth not exist" do
        content.first.delete(:date_of_birth)
        expect { described_class.by_dob_asc_then_last_name_asc(content) }.to raise_error(ArgumentError)
      end

      it "raise an exception when date of birth isn't separated by /" do
        content.first[:date_of_birth] = '6-3-1975'
        expect { described_class.by_dob_asc_then_last_name_asc(content) }.to raise_error(ArgumentError)
      end
    end
   end

   context "#by_last_name_desc" do
    describe "sort by last name desc" do
      it "return a sorted list" do
        result = described_class.by_last_name_desc(content)
        expect(result.first[:last_name]).to eq('Kournikova')
      end

      it "raise an exception when last name not exist" do
        content.first.delete(:last_name)
        expect { described_class.by_dob_asc_then_last_name_asc(content) }.to raise_error(ArgumentError)
      end
    end
   end
end