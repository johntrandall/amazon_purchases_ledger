RSpec.describe AmazonPurchasesLedger::MergeService do

  it "works" do
    expect { described_class }.not_to raise_error
  end

  describe '#perform' do
    subject { described_class.new(path1, path2).perform }

    it 'works' do
      expect { subject }.not_to raise_error
    end

    it 'generates.csv' do
      expect(CSV).to receive(:open).and_call_original #fixture1
      expect(CSV).to receive(:open).and_call_original #fixture2
      expect(CSV).to receive(:open).and_call_original #output
      subject
    end
  end

  describe '#output_header_row' do
    it 'includes the right things' do
      expect(described_class.new(path1, path2).output_header_row).to include(:order_date)
      expect(described_class.new(path1, path2).output_header_row).to include(:payment_account)
      expect(described_class.new(path1, path2).output_header_row).to include(:amount)
      expect(described_class.new(path1, path2).output_header_row).to include(:memo)
    end
  end

  describe '#orders' do
    subject { described_class.new(path1, path2).orders }

    it 'works' do
      expect { subject }.not_to raise_error
    end

    it 'returns orders' do
      expect(subject.map(&:class).uniq).to eq [AmazonPurchasesLedger::Order]
    end
  end

end
