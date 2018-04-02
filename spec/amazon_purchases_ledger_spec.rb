RSpec.describe AmazonPurchasesLedger do
  it "has a version number" do
    expect(AmazonPurchasesLedger::VERSION).not_to be nil
  end

  describe AmazonPurchasesLedger::CLI do
    it "works" do
      expect { AmazonPurchasesLedger::CLI }.not_to raise_error
    end

    describe '#merge' do
      it 'calls MergeService' do
        expect(AmazonPurchasesLedger::MergeService).to receive(:new).with(path1, path2).and_call_original
        expect_any_instance_of(AmazonPurchasesLedger::MergeService).to receive(:perform)
        AmazonPurchasesLedger::CLI.new.merge(path1, path2)
      end
    end

  end
end
