FactoryGirl.define do
  factory :path, class: XbmcSql::Path do
    path "file://foo/bar.ext"
  end
end
