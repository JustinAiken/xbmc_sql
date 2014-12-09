require "xbmc_sql/engine"
require "xbmc_sql/rating_updater"
require "xbmc_sql/top_250_updater"
require "xbmc_sql/nfo_file"

module XbmcSql

  def self.setup
    yield self
  end

  ##
  # Write .nfo files?

  mattr_writer :write_nfo_files
  @@write_nfo_files = false
  def self.write_nfo_files?
    @@write_nfo_files
  end

  ##
  # Path mappings

  mattr_accessor :path_mappings

  @@path_mappings = Hash.new
  def self.register_path_mapping(original, change)
    @@path_mappings[original] = change
  end

  def self.use_path_mappings?
    path_mappings.keys.count > 0
  end
end
