require "spec_helper"

RSpec.describe Auth::Visitor do
  let(:user) { Auth::Visitor.new }
  subject { user }

  it { is_expected.not_to be_authenticated }
end
