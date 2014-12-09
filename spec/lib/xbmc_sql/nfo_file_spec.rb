require 'spec_helper'

describe XbmcSql::NfoFile do
  let(:nfo_file) { 'spec/fixtures/movie.nfo' }
  let(:tmp_file) { 'spec/fixtures/movie.tmp.nfo' }

  before do
    FileUtils.rm tmp_file if File.exist? tmp_file
    FileUtils.copy nfo_file, tmp_file
  end

  subject { XbmcSql::NfoFile.new tmp_file }

  it "has attribute readers for singular attributes" do
    expect(subject.title).to         eq 'The Grand Budapest Hotel'
    expect(subject.id).to            eq 'tt2278388'
    expect(subject.originaltitle).to eq 'The Grand Budapest Hotel'
    expect(subject.sorttitle).to     eq 'Grand Budapest Hotel'
    expect(subject.year).to          eq '2014'
    expect(subject.releasedate).to   eq '6/27/2014'
    expect(subject.top250).to        eq '138'
    expect(subject.rating).to        eq '8.3'
    expect(subject.votes).to         eq '103,763'
    expect(subject.mpaa).to          eq 'Rated R for language, some sexual content and violence'
    expect(subject.studio).to        eq 'Fox Searchlight Pictures'
    expect(subject.runtime).to       eq '99'
    expect(subject.playcount).to     eq '1'
    expect(subject.certification).to match /USA:R/
    expect(subject.outline).to       match /The adventures of Gustave/
    expect(subject.plot).to          match /GRAND BUDAPEST HOTEL recounts/
  end

  it "can write attributes for singular attributes" do
    subject.title = "Foo Movie"
    expect(subject.title).to eq 'Foo Movie'
  end

  it "has attribute readers for plural attributes" do
    expect(subject.countries).to eq  ['USA',    'Germany']
    expect(subject.genres).to eq     ['Comedy', 'Drama']
    expect(subject.directors).to eq  ['Wes Anderson']
  end

  it "can write attributes for plural attributes" do
    subject.genres = ["Foo", "Bar"]
    expect(subject.genres).to eq ["Foo", "Bar"]
  end

  describe "#actors" do
    it "has actors" do
      expect(subject.actors).to be_a Array
      expect(subject.actors.first['name'][0]).to eq 'Ralph Fiennes'
    end
  end

  describe "save!" do
    it "saves the file" do
      subject.title = 'Foo and a half'
      subject.save!
    end
  end
end
