require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the StaticHelper. For example:
#
# describe StaticHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UserHelper, :type => :helper do
  before do
    @called = false
    allow(controller).to receive(:current_user) { user }
  end

  AuthenticatedUser = Struct.new(:authenticated?)

  describe "#for_authenticated_user" do
    before do
      helper.for_authenticated_user { @called = true }
    end

    context "when user is authenticated" do
      let(:user) { AuthenticatedUser.new(true) }

      it "executes the block" do
        expect(@called).to be_truthy
      end
    end

    context "when user is not authenticated" do
      let(:user) { AuthenticatedUser.new(false) }

      it "executes the block" do
        expect(@called).to be_falsy
      end
    end
  end

  describe "#for_non_authenticated_user" do
    before do
      helper.for_non_authenticated_user { @called = true }
    end

    context "when user is authenticated" do
      let(:user) { AuthenticatedUser.new(true) }

      it "executes the block" do
        expect(@called).to be_falsy
      end
    end

    context "when user is not authenticated" do
      let(:user) { AuthenticatedUser.new(false) }

      it "executes the block" do
        expect(@called).to be_truthy
      end
    end
  end
end
