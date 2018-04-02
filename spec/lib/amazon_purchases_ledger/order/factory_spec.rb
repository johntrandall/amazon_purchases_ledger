RSpec.describe AmazonPurchasesLedger::Order::Factory do

  it 'works' do
    expect { described_class }.not_to raise_error
  end

  describe '#orders' do
    subject { described_class.new(orders_csv: orders_csv, items_csv: items_csv).orders }

    it 'works' do
      expect { subject }.not_to raise_error
    end

    it 'returns orders' do
      expect(subject.map(&:class).uniq).to eq [AmazonPurchasesLedger::Order]
    end

    it 'includes complete orders' do
      expect(subject.map(&:order_id)).to include(order_id_shipped)
    end

    it 'omits orders that are missing information, ie: total_amount (unshipped)' do
      expect(subject.map(&:order_id)).not_to include(order_id_unshipped)
    end

  end
end
