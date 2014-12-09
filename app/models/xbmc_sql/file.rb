module XbmcSql
  class File < Base
    self.table_name = :files

    belongs_to :path,  foreign_key: :idPath
    has_one :movie,    foreign_key: :idFile

    alias_attributes(
      idFile:      :id,
      strFilename: :filename,
      playCount:   :play_count,
      lastPlayed:  :last_played,
      dateAdded:   :date_added
    )

  end
end
