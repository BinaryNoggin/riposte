require "riposte"

module Riposte
  describe Reaction do
    let(:random_method) { (?a..?z).to_a.shuffle.take(2).join }
    subject { described_class.new(:response_type) }

    it "responds to anything" do
      expect(subject).to respond_to(random_method)
    end

    it "doesn't call a block when it isn't the response type" do
      subject.public_send(random_method) do
        fail "shoud have not run the block"
      end
    end

    it "calls the block when it is the response type" do
      called = false
      subject.response_type { called = true }
      expect(called).to be_truthy
    end
  end
end
