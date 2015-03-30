require "spec_helper"

RSpec.describe Auth do
  describe ".maybe" do
    context "when no user provided" do
      it "returns an Auth::Visitor" do
        expect(Auth.maybe_user(nil)).to be_kind_of(Auth::Visitor)
      end
    end

    context "when user provided" do
      it "returns an Auth::AuthenticatedUser" do
        expect(Auth.maybe_user(Object.new)).to be_kind_of(Auth::AuthenticatedUser)
      end
    end
  end
end
