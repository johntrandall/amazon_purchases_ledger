RSpec.describe AmazonCsvCombiner do
  it "has a version number" do
    expect(AmazonCsvCombiner::VERSION).not_to be nil
  end

  describe AmazonCsvCombiner::CLI do
    it "works" do
      expect { AmazonCsvCombiner::CLI }.not_to raise_error
    end

    describe '#merge' do
      it 'calls MergeService' do
        path1 = 'spec/fixtures/orders.csv'
        path2 = 'spec/fixtures/items.csv'
        expect(AmazonCsvCombiner::MergeService).to receive(:new).with(path1, path2).and_call_original
        expect_any_instance_of(AmazonCsvCombiner::MergeService).to receive(:perform)
        AmazonCsvCombiner::CLI.new.merge(path1, path2)
      end
    end

  end
end
