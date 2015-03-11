require "spec_helper"
require "riposte/reaction"

module Riposte
  describe Reaction do
    let(:random_method) { (?a..?z).to_a.shuffle.take(2).join }
    subject { described_class.new(:response_type) }

    it "responds to anything" do
      expect(subject).to respond_to(random_method)
    end

    it "doesn't call a block when it isn't the response type" do
      expect{ |b| subject.public_send(random_method, &b) }.not_to yield_control
    end

    it "calls the block when it is the response type" do
      called = false
      subject.response_type { called = true }
      expect(called).to be_truthy
    end

    it "is equal to another reaction with the same type" do
      expect(subject).to eq(described_class.new(:response_type))
    end
  end
end
