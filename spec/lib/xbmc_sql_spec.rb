require 'spec_helper'

describe XbmcSql do
  describe ".register_path_mapping" do
    it "registers the path mappping" do
      XbmcSql.register_path_mapping 'foo', 'bar'
      expect(XbmcSql.path_mappings['foo']).to eq 'bar'
      XbmcSql.path_mappings = {}
    end
  end

  describe ".use_path_mappings?" do
    context "when there's path mappings" do
      before { XbmcSql.stub(:path_mappings).and_return foo: :bar }

      it "is true" do
        expect(XbmcSql.use_path_mappings?).to be true
      end
    end

    context "when there's no path mappings" do
      before { XbmcSql.stub(:path_mappings).and_return Hash.new }

      it "is false" do
        expect(XbmcSql.use_path_mappings?).to be false
      end
    end
  end
end
