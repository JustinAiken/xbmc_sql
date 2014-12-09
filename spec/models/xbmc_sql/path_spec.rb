require 'spec_helper'

describe XbmcSql::Path do
  it { should have_many :files }

  describe "attributes" do
    subject { XbmcSql::Path.first }

    its(:id)               { should eq 1 }
    its(:path)             { should eq '/Users/jaiken/Movies/Movies/' }
    its(:content)          { should eq 'movies' }
    its(:scraper)          { should be_a String }
    its(:settings)         { should match /^<settings>/ }
    its(:use_folder_names) { should be_true }
    its(:no_update)        { should be_zero }
  end

  describe "#is_samba?" do
    let(:not_samba) { create :path, path: 'file://some_path/file.mkv' }
    let(:yes_samba) { create :path, path: 'smb://some_server' }

    it "is true if it is" do
      expect(not_samba).not_to be_is_samba
    end

    it "is true if it is" do
      expect(yes_samba).to be_is_samba
    end
  end

  describe "#mapped_path" do
    let(:original_path) { 'smb://192.168.1.8/Video/Movies/Some Movie (2014)/some_movie.mp4' }
    let(:network_path)  { create :path, path: original_path }

    context "when there's no path substitions" do
      it "returns the path as-is" do
        expect(network_path.mapped_path).to eq original_path
      end
    end

    context "when there are path substitions" do
      before { XbmcSql.stub(:path_mappings).and_return "smb://192.168.1.8/Video" => "/Volumes/Video"}

      it "returns the path modified to reflect this" do
        expect(network_path.mapped_path).to eq '/Volumes/Video/Movies/Some Movie (2014)/some_movie.mp4'
      end
    end
  end
end
