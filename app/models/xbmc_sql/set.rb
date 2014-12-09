module XbmcSql
  class Set < Base
    self.table_name = :sets

    has_many :movies, foreign_key: :idSet

    alias_attributes idSet: :id, strSet: :name
  end
end
