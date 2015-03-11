require "riposte/helper"

module Riposte
  describe Helper do
    let(:described_class) {
      Class.new {
        include Riposte::Helper
      }
    }

    subject { described_class.new }

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
end
