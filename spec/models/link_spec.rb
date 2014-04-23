require 'spec_helper'

describe Link do
	let(:link) {Link.new}

  it { should_not be_valid }
  it { should validate_presence_of(:long_url) }
  it { should validate_presence_of(:short_url) }
  it { should have_many(:visitors).dependent(:destroy) }

end
