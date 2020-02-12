require 'rspec'
require_relative '../../lib/parser/reader.rb'

RSpec.describe Parser::Reader do

  context "#call" do
    describe "good input attributes" do
      let(:input_attributes) {
        [['space.txt', %i(last_name first_name middle_initial gender date_of_birth favorite_color), ' ']]
      }

      it "return a list of user rows" do
        expect(described_class.call(input_attributes)).to be_a_kind_of(Array)
        expect(described_class.call(input_attributes).size).to be > 0
      end
    end

    describe "bad input attributes with less columns" do
      let(:input_attributes) {
        [['space.txt', %i(last_name first_name middle_initial gender date_of_birth favorite_color)]]
      }

      it "raise input attributes exception" do
        exception = Parser::Reader::InputAttributesError
        msg = 'Input should contain list with 3 columns (file_name, headers, delimiters)'
        expect { described_class.call(input_attributes) }.to raise_error(exception, msg)
      end
    end

    describe "bad input attributes with empty columns" do
      let(:input_attributes) { [[]] }

      it "raise input error" do
        exception = Parser::Reader::InputAttributesError
        msg = 'Input should contain list with 3 columns (file_name, headers, delimiters)'
        expect { described_class.call(input_attributes) }.to raise_error(exception, msg)
      end
    end

    describe "bad input attributes with bad file name" do
      let(:input_attributes) { [
        ['bad_file_name.txt', %i(last_name first_name middle_initial gender date_of_birth favorite_color), ' ']
      ] }

      it "raise file name exception" do
        expect { described_class.call(input_attributes) }.to raise_error(Parser::Reader::InputFileNameError)
      end
    end
  end

  context "#parse" do
    describe "well parsed elements" do
      let(:content) { 'Kournikova Anna F F 6-3-1975 Red' }
      let(:headers) { %i(last_name first_name middle_initial gender date_of_birth favorite_color) }
      let(:delimiter) { ' ' }

      it "display list of columns" do
        expect(described_class.send(:parse, content, headers, delimiter)).to be_a_kind_of(Array)
        expect(described_class.send(:parse, content, headers, delimiter).size).to be > 0
        expect(described_class.send(:parse, content, headers, delimiter).first[:last_name]).to eq('Kournikova')
      end
    end

    describe "well parsed space elements" do
      let(:content) { 'Kournikova    Anna F   F  6-3-1975  Red' }
      let(:headers) { %i(last_name first_name middle_initial gender date_of_birth favorite_color) }
      let(:delimiter) { ' ' }

      it "remove spaces element between columns" do
        expect(described_class.send(:parse, content, headers, delimiter)).to be_a_kind_of(Array)
        expect(described_class.send(:parse, content, headers, delimiter).size).to be > 0
        expect(described_class.send(:parse, content, headers, delimiter).first[:last_name]).to eq('Kournikova')
      end
    end

    describe "empty content" do
      let(:content) { '  ' }
      let(:headers) { %i(last_name first_name middle_initial gender date_of_birth favorite_color) }
      let(:delimiter) { ' ' }

      it "return empty array" do
        expect(described_class.send(:parse, content, headers, delimiter)).to be_a_kind_of(Array)
        expect(described_class.send(:parse, content, headers, delimiter).size).to eq(0)
      end
    end

    describe "missing one column (date) in content" do
      let(:content) { 'Kournikova Anna F F Red' }
      let(:headers) { %i(last_name first_name middle_initial gender date_of_birth favorite_color) }
      let(:delimiter) { ' ' }

      it "last header should be empty" do
        expect(described_class.send(:parse, content, headers, delimiter).last[:favorite_color]).to be_nil
      end
    end
  end
end