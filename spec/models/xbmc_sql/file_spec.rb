require 'spec_helper'

describe XbmcSql::File do
  it { should belong_to :path }
  it { should have_one  :movie }

  describe "attributes" do
    subject { XbmcSql::File.first }

    its(:id)          { should eq 1 }
    its(:filename)    { should eq 'blow-the.grand.budapest.hotel.2014.720p.bluray.x264.mkv' }
    its(:play_count)  { should be_nil }
    its(:last_played) { should be_nil }
    its(:date_added)  { should eq '2014-06-21 21:19:07' }
  end
end
