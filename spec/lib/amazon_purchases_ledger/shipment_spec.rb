RSpec.describe AmazonPurchasesLedger::Shipment do

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
    end

    describe 'promotions info' do

      context 'shipment without promotions credit' do
        it 'does not contain promotions info' do
          expect(subject.output_text).not_to include('Promotions')
        end
      end

      context 'shipment with promotions credit' do
        let(:order_csv_row) { orders_csv.select { |row| row[:carrier_name__tracking_number] == 'AMZN_US(TBA736774275000)' }.first }
        it 'does contain promotions info' do
          expect(subject.output_text).to include('Promotions')
        end
      end

    end
  end


  describe '#items' do
    it 'works' do
      expect(subject.items.first.class).to eq(AmazonPurchasesLedger::Item)
    end
    it 'returns the correct nubmer of items' do
      expect(subject.items.count).to eq(1)
    end
  end
end
