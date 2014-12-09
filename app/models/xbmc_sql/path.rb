module XbmcSql
  class Path < Base
    self.table_name = :path

    has_many :files,   foreign_key: :idPath

    alias_attributes(
      idPath:         :id,
      strPath:        :path,
      strContent:     :content,
      strScraper:     :scraper,
      # strHash:        :unused,
      # scanRecursive:  :unused,
      useFolderNames: :use_folder_names,
      strSettings:    :settings,
      noUpdate:       :no_update,
      # exclude:        :exclude,
      dateAdded:      :created_at
    )

    def is_samba?
      path =~ /^smb/
    end

    def mapped_path
      self.path.tap do |original_path|
        XbmcSql.path_mappings.each do |original, change|
          original_path.gsub! original, change
        end
      end
    end
  end
end
