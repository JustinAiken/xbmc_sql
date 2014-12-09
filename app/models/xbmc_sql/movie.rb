module XbmcSql
  class Movie < Base
    self.table_name = :movie

    belongs_to :set,  foreign_key: :idSet
    belongs_to :file, foreign_key: :idFile
    has_one :path, through: :file

    after_update :update_nfo_file, if: ->(movie) { XbmcSql.write_nfo_files? && movie.has_nfo_file? }

    alias_attributes(
      idMovie: :id,
      c00: :title,
      c01: :plot,
      c02: :plot_outline,
      c03: :tagline,
      c04: :rating_votes,
      c05: :rating,
      c06: :writers,
      c07: :year,
      c08: :thumbnails,
      c09: :imdb_id,
      c10: :sort_title,
      c11: :runtime,
      c12: :mpaa_rating,
      c13: :imdb_250,
      c14: :genre,
      c15: :director,
      c16: :original_title,
      # c17: :unknown,
      c18: :studio,
      c19: :trailer_url,
      c20: :fanart_urls,
      c21: :country
      # c23: :path_id
    )

    scope :in_top_250,   ->        { where 'c13 IS NOT NULL AND c13 != ?', '0' }
    scope :with_imdb_id, ->imdb_id { where imdb_id: imdb_id }

    def full_path
      if XbmcSql.use_path_mappings?
        "#{path.mapped_path}#{file.filename}"
      else
        "#{path.path}#{file.filename}"
      end
    end

    def nfo_file
      if XbmcSql.use_path_mappings?
        likely_path = "#{path.mapped_path}movie.nfo"
      else
        likely_path = "#{path.path}movie.nfo"
      end

      if ::File.exists? likely_path
        return likely_path
      else
        likely_path.gsub! /movie.nfo$/, 'BDMV/STREAM/movie.nfo'
        return likely_path if ::File.exists? likely_path
        nil
      end
    end

    def has_nfo_file?
      nfo_file.present?
    end

    def update_nfo_file
      NfoFile.new(::File.open nfo_file).tap do |nfo|
        aliased_changes.each do |change, values|
          nfo.send "#{change}=", values[1]
        end
        nfo.save!
      end
    end
  end
end
