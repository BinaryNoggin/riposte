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

    context "with no params" do
      subject { described_class.new(:response_type) }

      it "calls the block when it is the response type" do
        expect{ |b| subject.public_send(:response_type, &b) }.to yield_control
      end

      it "is equal to another reaction with the same type" do
        expect(subject).to eq(described_class.new(:response_type))
      end

      it "is not equal to another reaction with a different type" do
        expect(subject).not_to eq(described_class.new(:other_type))
      end
    end

    context "with params" do
      let(:param) { double(:param) }
      let(:param2) { double(:param2) }
      subject { described_class.new(:response_type, param, param2) }

      it "calls the block when it is the response type" do
        expect{ |b| subject.public_send(:response_type, &b) }.to yield_with_args(param, param2)
      end

      it "is equal to another reaction with the same type" do
        expect(subject).to eq(described_class.new(:response_type, param, param2))
      end

      it "is not equal if they have different params" do
        expect(subject).to_not eq(described_class.new(:response_type, param2, param))
      end
    end
  end
end
