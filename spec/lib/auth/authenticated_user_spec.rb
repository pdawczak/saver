require "spec_helper"

RSpec.describe Auth::AuthenticatedUser do
  let(:user) { Object.new.extend(Auth::AuthenticatedUser) }
  subject { user }

  it { is_expected.to be_authenticated }
end
