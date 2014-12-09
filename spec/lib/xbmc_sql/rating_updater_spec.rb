require 'spec_helper'

describe XbmcSql::RatingUpdater do

  before { described_class.any_instance.stub :puts }

  describe ".go!" do
    let(:scraper) { double XbmcSql::RatingUpdater, scrape!: true }

    it "runs the test" do
      expect(XbmcSql::RatingUpdater).to receive(:new).at_least(:once).and_return scraper
      XbmcSql::RatingUpdater.go!
    end
  end

  describe "#scrape" do
    let(:scraper) { described_class.new movie }

    context "with an imdb-less movie" do
      let(:movie) { create :movie, rating: 8.2 }

      it "doesn't do anything" do
        expect(HTTParty).not_to receive :get
        scraper.scrape!
        expect(movie.rating).to eq 8.2
      end
    end

    context "with an imdb movie" do
      let(:movie)        { create :movie, rating: 8.2, imdb_id: 'tt1234' }
      let(:expected_url) { "http://www.omdbapi.com/?i=tt1234" }

      before { expect(HTTParty).to receive(:get).with(expected_url).and_return response }

      context "when successfully scraped" do
        let(:body)     { {'imdbRating' => '7', 'imdbVotes' => '1,234'} }
        let(:response) { double HTTParty::Response, body: body.to_json }

        it "updates it" do
          scraper.scrape!
          movie.reload
          expect(movie.rating).to       eq '7'
          expect(movie.rating_votes).to eq '1,234'
        end
      end
    end
  end
end
