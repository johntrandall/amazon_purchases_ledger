RSpec.describe AmazonCsvCombiner::MergeService do

  it "works" do
    expect { described_class }.not_to raise_error
  end

  describe '#perform' do
    it 'works' do
      expect { described_class.new(path1, path2).perform }.not_to raise_error
    end
    it 'generates.csv' do
      expect(CSV).to receive(:open).and_call_original #fixture1
      expect(CSV).to receive(:open).and_call_original #fixture2
      expect(CSV).to receive(:open).and_call_original #output
      described_class.new(path1, path2).perform
    end
  end

  describe '#output_header_row' do
    it 'includes the right things' do
      expect(described_class.new(path1, path2).output_header_row).to include(:order_date)
      expect(described_class.new(path1, path2).output_header_row).to include(:item_details)
    end
  end

  describe '#output_order_rows' do
    it 'works' do
      expect { described_class.new(path1, path2).output_order_rows }.not_to raise_error
    end
  end

end


RSpec.describe AmazonCsvCombiner::MergeService::OrderRowGenerator do

  it "works" do
    expect { described_class }.not_to raise_error
  end

  let(:merge_service) { AmazonCsvCombiner::MergeService.new(path1, path2) }
  let(:order_row) { merge_service.orders_csv.first }
  let(:items_csv) { merge_service.items_csv }

  subject { described_class.new(order_row, items_csv) }

  it 'does' do
    expect { subject }.not_to raise_error
  end

  describe '#filtered_order_row' do
    it 'provides a filtered order row' do
      expect(subject.filtered_order_row.first).to eq '12/31/17'
      expect(subject.filtered_order_row.last).to include '$9.98'
      expect(subject.filtered_order_row.last).to include '2x Mesh Stuff Bag'
    end
  end

end
