require 'spec_helper'

describe XbmcSql::Top250Updater do

  before { described_class.stub :puts }
  before { described_class.any_instance.stub :puts }

  describe ".go!" do
    let(:updater) { double XbmcSql::Top250Updater, scrape!: true }

    before { expect(XbmcSql::Top250Updater).to receive(:new).and_return updater }

    context "when all is well" do
      it "updates all the ratings and returns true" do
        expect(updater).to receive :scrape
        expect(updater).to receive :update_current
        expect(updater).to receive :remove_old
        expect(updater).to receive :note_missing
        expect(XbmcSql::Top250Updater.go!).to be true
      end
    end

    context "when an error occurs" do
      it "returns false" do
        expect(updater).to receive(:scrape).and_raise StandardError
        expect(updater).not_to receive :update_current
        expect(updater).not_to receive :remove_old
        expect(updater).not_to receive :note_missing
        expect(XbmcSql::Top250Updater.go!).to be false
      end
    end
  end

  describe "#scrape" do
    pending
  end

  describe "#update_current" do
    pending
  end

  describe "#remove_old" do
    pending
  end

  describe "#note_missing" do
    pending
  end
end
