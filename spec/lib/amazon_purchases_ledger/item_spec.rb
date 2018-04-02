RSpec.describe AmazonPurchasesLedger::Item do

  let(:item_csv_row) { items_csv.first }

  subject { described_class.new(items_csv_row: item_csv_row) }

  it 'works' do
    expect { described_class }.not_to raise_error
    expect { subject }.not_to raise_error
  end

  describe '#output_text' do
    it 'works' do
      expect { subject.output_text }.not_to raise_error
    end

    it 'includes the things' do
      expect(subject.output_text).to include('$9.98')
      expect(subject.output_text).to include('2x')
      expect(subject.output_text).to include('Mesh Stuff Bag')
      expect(subject.output_text).to include('Seller: Handy')
    end
  end
end
