require 'spec_helper'

describe Ticket do

  it { should validate_presence_of(:title).with_message(/is required/) }
  it { should validate_presence_of(:group).with_message(/is required/) }
  it { should validate_presence_of(:status).with_message(/is required/) }
  it { should validate_presence_of(:priority).with_message(/is required/) }
  it { should validate_presence_of(:creator).with_message(/is required/) }
  it { should belong_to :group }
  it { should belong_to :status }
  it { should belong_to :priority }
  it { should belong_to :contact }
  it { should belong_to :creator }
  it { should belong_to :owner }

end
