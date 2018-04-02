RSpec.describe AmazonCsvCombiner::Shipment::Factory do

  it 'works' do
    expect { described_class }.not_to raise_error
  end

  describe '#shipments' do
    subject { described_class.new(orders_csv: orders_csv, items_csv: items_csv, order_id: order_id_shipped).shipments }

    it 'works' do
      expect { subject }.not_to raise_error
    end

    it 'returns shipements' do
      expect(subject.map(&:class).uniq).to eq [AmazonCsvCombiner::Shipment]
    end
  end

end
