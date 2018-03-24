RSpec.describe AmazonCsvCombiner do
  it "has a version number" do
    expect(AmazonCsvCombiner::VERSION).not_to be nil
  end

  it "does something useful" do
    # expect(false).to eq(true)
  end

  describe AmazonCsvCombiner::CLI do
    it "works" do
      expect{AmazonCsvCombiner::CLI}.not_to raise_error
    end

  end
end
