require 'spec_helper'

module XbmcSql
  describe Movie do
    it { should belong_to :set }
    it { should belong_to :file }
    it { should have_one  :path }

    let(:first_movie) { XbmcSql::Movie.first }

    describe "attributes" do
      subject { first_movie }

      its(:id)             { should eql 1 }
      its(:title)          { should eql "The Grand Budapest Hotel" }
      its(:plot)           { should match /GRAND BUDAPEST HOTEL recounts the adventures of Gustave/ }
      its(:tagline)        { should be_a String }
      its(:rating_votes)   { should eq "103,763" }
      its(:writers)        { should eq "Stefan Zweig / Wes Anderson" }
      its(:year)           { should eq '2014' }
      its(:thumbnails)     { should match /<thumb>/ }
      its(:imdb_id)        { should eq 'tt2278388' }
      its(:sort_title)     { should eq 'Grand Budapest Hotel' }
      its(:runtime)        { should eq '5940' }
      its(:mpaa_rating)    { should match /^Rated R/ }
      its(:imdb_250)       { should eq '138' }
      its(:genre)          { should match /Comedy/ }
      its(:director)       { should eq 'Wes Anderson' }
      its(:original_title) { should eq 'The Grand Budapest Hotel' }
      its(:studio)         { should eq 'Fox Searchlight Pictures' }
      its(:trailer_url)    { should be_a String }
      its(:fanart_urls)    { should match /<fanart url/ }
      its(:country)        { should match /USA/ }
    end

    describe "#full_path" do
      it "should join the full path + filename" do
        expect(first_movie.full_path).to eq '/Users/jaiken/Movies/Movies/Grand Budapest Hotel, The (2014)/blow-the.grand.budapest.hotel.2014.720p.bluray.x264.mkv'
      end
    end

    describe "#nfo_file" do
      let(:likely) { '/Users/jaiken/Movies/Movies/Grand Budapest Hotel, The (2014)/movie.nfo' }
      let(:bluray) { '/Users/jaiken/Movies/Movies/Grand Budapest Hotel, The (2014)/BDMV/STREAM/movie.nfo' }

      context "when the nfo file is present" do
        before { expect(::File).to receive(:exists?).with(likely).and_return true }

        it "returns it" do
          expect(first_movie.nfo_file).to eq likely
        end
      end

      context "when it's a convulted bluray folder structure" do
        before { expect(::File).to receive(:exists?).with(likely).and_return false }
        before { expect(::File).to receive(:exists?).with(bluray).and_return true }

        it "finds it" do
          expect(first_movie.nfo_file).to eq bluray
        end
      end

      context "when it's just not there" do
        before { expect(::File).to receive(:exists?).with(likely).and_return false }
        before { expect(::File).to receive(:exists?).with(bluray).and_return false }

        it "returns nil" do
          expect(first_movie.nfo_file).to be_nil
        end
      end
    end

    describe "#update_nfo_file" do
      context "when write_nfo_files is enabled" do
        before { XbmcSql.stub(:write_nfo_files?).and_return true }

        context "but no nfo file is found" do
          before { ::File.stub(:exists?).and_return false }

          it "doesn't try to write the nfo file" do
            expect(NfoFile).not_to receive :new
            first_movie.update_attributes! title: "New Title"
          end
        end

        context "and the nfo file is found" do
          before { ::File.stub(:exists?).and_return true }

          let(:mock_file) { double(::File).as_null_object }
          let(:mock_nfo)  { double(NfoFile).as_null_object }

          it "writes updated attributes to the nfo file" do
            expect(::File).to receive(:open).and_return mock_file
            expect(NfoFile).to receive(:new).with(mock_file).and_return mock_nfo

            expect(mock_nfo).to receive(:title=).with 'New Title'
            expect(mock_nfo).to receive :save!

            first_movie.update_attributes! title: 'New Title'
          end
        end
      end
    end

    context "when write_nfo_files? is disabled" do
      before { XbmcSql.stub(:write_nfo_files?).and_return false }

      it "doesn't even check for an nfo file" do
        expect(::File).not_to receive :exists?
        expect(NfoFile).not_to receive :new
        first_movie.update_attributes! title: "New Title"
      end
    end
  end
end
