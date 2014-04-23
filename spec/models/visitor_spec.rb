require 'spec_helper'

describe Visitor do
  let(:visitor) {Visitor.new}

  it { should_not be_valid }
  it { should validate_presence_of(:link_id) }
  it { should validate_presence_of(:ip) }
  it { should belong_to(:link)}

end
