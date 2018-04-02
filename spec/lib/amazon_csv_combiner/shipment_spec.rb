RSpec.describe AmazonCsvCombiner::Shipment do

  let(:order_csv_row) { orders_csv.first }

  subject { described_class.new(order_csv_row: order_csv_row, items_csv: items_csv) }

  it 'works' do
    expect { described_class }.not_to raise_error
    expect { subject }.not_to raise_error
  end

  describe '#output_text' do
    it 'works' do
      expect { subject.output_text }.not_to raise_error
    end

    it 'includes the things' do
      expect(subject.output_text).to include('Shipment: AMZN_US(TB')
      expect(subject.output_text.scan(/\* \$/).count).to eq(1)
      expect(subject.output_text).to include('--------------------')
    end
  end

  describe '#items' do
    it 'works' do
      expect(subject.items.first.class).to eq(AmazonCsvCombiner::Item)
    end
    it 'returns the correct nubmer of items' do
      expect(subject.items.count).to eq(1)
    end
  end
end
