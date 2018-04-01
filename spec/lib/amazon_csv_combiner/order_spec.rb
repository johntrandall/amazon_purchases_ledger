RSpec.describe AmazonCsvCombiner::Order do
  let(:order_id) { orders_csv.first[:order_id] }

  subject { described_class.new(order_id: order_id,
                                orders_csv: orders_csv,
                                items_csv: items_csv) }

  describe AmazonCsvCombiner::Order::Factory do

    describe '#orders' do
      subject { described_class.new(orders_csv: orders_csv, items_csv: items_csv).orders }
      it 'works' do
        expect { described_class }.not_to raise_error
        expect { subject }.not_to raise_error
      end

      it 'returns orders' do
        expect(subject.map(&:class).uniq).to eq [AmazonCsvCombiner::Order]
      end

      it 'omits orders that are missing information, ie: total_amount (unshipped)' do
        expect(subject.map(&:order_id)).not_to include('114-9487673-0555460')
      end
    end
  end

  it 'works' do
    expect { described_class }.not_to raise_error
    expect { subject }.not_to raise_error
  end

  describe '#output_row' do
    it 'works' do
      expect { subject.output_row }.not_to raise_error
    end
    it 'includes the #date' do
      expect(subject.output_row).to include('12/31/17')
    end
    it 'includes the #payment account' do
      expect(subject.output_row).to include('Visa - 4033')
    end
    it 'includes the sum of the payment totals' do
      expect(subject.output_row).to include('$30.06')
    end
    context 'when a shipment hasn\'t shipped yet' do
      let!(:order_id) { '114-9487673-0555460' }
      it 'returns nil' do
        expect(subject.output_row).to be nil
      end
    end
  end

  describe '#memo' do
    it 'works' do
      expect { subject.memo }.not_to raise_error
    end
    it 'includes the shipment things' do
      expect(subject.memo).to include('Shipment: AMZN_US(TB')
      expect(subject.memo.scan(/\* \$/).count).to eq(4)
      expect(subject.memo).to include('--------------------')
    end
    it 'includes the item things' do
      expect(subject.memo).to include('$9.98')
      expect(subject.memo).to include('2x')
      expect(subject.memo).to include('Mesh Stuff Bag')
      expect(subject.memo).to include('Seller: Handy')
    end
  end

  describe '#shipments' do
    it 'works' do
      expect(subject.shipments.first.class).to eq(AmazonCsvCombiner::Shipment)
    end
  end

  describe '#items' do
    it 'works' do
      expect(subject.items.first.class).to eq(AmazonCsvCombiner::Item)
    end
    it 'returns the correct nubmer of items' do
      expect(subject.items.count).to eq(4)
    end
  end

  #private
  describe '#amount' do
    it 'works' do
      expect { subject.send(:amount) }.not_to raise_error
    end
    context 'when a shipment hasn\'t shipped yet' do
      let!(:order_id) { '114-9487673-0555460' }
      it 'returns nil' do
        expect(subject.send(:amount)).to be_nil
      end
    end
  end
end
