require "spec_helper"
require "riposte/helper"

module Riposte
  describe Helper do
    let(:described_class) {
      Class.new {
        include Riposte::Helper
      }
    }

    subject { described_class.new }

    context "with no params" do
      context "#react_to with no block" do
        it do
          expect(subject.react_to(:foo)).to eq(Riposte::Reaction.new(:foo))
        end
      end

      context "#react_to with a block" do
        it do
          expect {|b| subject.react_to(:foo, &b) }.to yield_with_args(Riposte::Reaction.new(:foo))
        end
      end
    end

    context "with params" do
      context "#react_to with no block" do
        it do
          expect(subject.react_to(:foo, :param)).to eq(Riposte::Reaction.new(:foo, :param))
        end
      end

      context "#react_to with a block" do
        it do
          expect {|b| subject.react_to(:foo, :param, &b) }.to yield_with_args(Riposte::Reaction.new(:foo, :param))
        end
      end
    end
  end
end
