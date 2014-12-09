# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "actorlinkepisode", id: false, force: true do |t|
    t.integer "idActor"
    t.integer "idEpisode"
    t.text    "strRole"
    t.integer "iOrder"
  end

  add_index "actorlinkepisode", ["idActor", "idEpisode"], name: "ix_actorlinkepisode_1", unique: true
  add_index "actorlinkepisode", ["idEpisode", "idActor"], name: "ix_actorlinkepisode_2", unique: true

  create_table "actorlinkmovie", id: false, force: true do |t|
    t.integer "idActor"
    t.integer "idMovie"
    t.text    "strRole"
    t.integer "iOrder"
  end

  add_index "actorlinkmovie", ["idActor", "idMovie"], name: "ix_actorlinkmovie_1", unique: true
  add_index "actorlinkmovie", ["idMovie", "idActor"], name: "ix_actorlinkmovie_2", unique: true

  create_table "actorlinktvshow", id: false, force: true do |t|
    t.integer "idActor"
    t.integer "idShow"
    t.text    "strRole"
    t.integer "iOrder"
  end

  add_index "actorlinktvshow", ["idActor", "idShow"], name: "ix_actorlinktvshow_1", unique: true
  add_index "actorlinktvshow", ["idShow", "idActor"], name: "ix_actorlinktvshow_2", unique: true

  create_table "actors", primary_key: "idActor", force: true do |t|
    t.text "strActor"
    t.text "strThumb"
  end

  create_table "art", primary_key: "art_id", force: true do |t|
    t.integer "media_id"
    t.text    "media_type"
    t.text    "type"
    t.text    "url"
  end

  add_index "art", ["media_id", "media_type", "type"], name: "ix_art"

  create_table "artistlinkmusicvideo", id: false, force: true do |t|
    t.integer "idArtist"
    t.integer "idMVideo"
  end

  add_index "artistlinkmusicvideo", ["idArtist", "idMVideo"], name: "ix_artistlinkmusicvideo_1", unique: true
  add_index "artistlinkmusicvideo", ["idMVideo", "idArtist"], name: "ix_artistlinkmusicvideo_2", unique: true

  create_table "bookmark", primary_key: "idBookmark", force: true do |t|
    t.integer "idFile"
    t.float   "timeInSeconds"
    t.float   "totalTimeInSeconds"
    t.text    "thumbNailImage"
    t.text    "player"
    t.text    "playerState"
    t.integer "type"
  end

  add_index "bookmark", ["idFile", "type"], name: "ix_bookmark"

  create_table "country", primary_key: "idCountry", force: true do |t|
    t.text "strCountry"
  end

  create_table "countrylinkmovie", id: false, force: true do |t|
    t.integer "idCountry"
    t.integer "idMovie"
  end

  add_index "countrylinkmovie", ["idCountry", "idMovie"], name: "ix_countrylinkmovie_1", unique: true
  add_index "countrylinkmovie", ["idMovie", "idCountry"], name: "ix_countrylinkmovie_2", unique: true

  create_table "directorlinkepisode", id: false, force: true do |t|
    t.integer "idDirector"
    t.integer "idEpisode"
  end

  add_index "directorlinkepisode", ["idDirector", "idEpisode"], name: "ix_directorlinkepisode_1", unique: true
  add_index "directorlinkepisode", ["idEpisode", "idDirector"], name: "ix_directorlinkepisode_2", unique: true

  create_table "directorlinkmovie", id: false, force: true do |t|
    t.integer "idDirector"
    t.integer "idMovie"
  end

  add_index "directorlinkmovie", ["idDirector", "idMovie"], name: "ix_directorlinkmovie_1", unique: true
  add_index "directorlinkmovie", ["idMovie", "idDirector"], name: "ix_directorlinkmovie_2", unique: true

  create_table "directorlinkmusicvideo", id: false, force: true do |t|
    t.integer "idDirector"
    t.integer "idMVideo"
  end

  add_index "directorlinkmusicvideo", ["idDirector", "idMVideo"], name: "ix_directorlinkmusicvideo_1", unique: true
  add_index "directorlinkmusicvideo", ["idMVideo", "idDirector"], name: "ix_directorlinkmusicvideo_2", unique: true

  create_table "directorlinktvshow", id: false, force: true do |t|
    t.integer "idDirector"
    t.integer "idShow"
  end

  add_index "directorlinktvshow", ["idDirector", "idShow"], name: "ix_directorlinktvshow_1", unique: true
  add_index "directorlinktvshow", ["idShow", "idDirector"], name: "ix_directorlinktvshow_2", unique: true

  create_table "episode", primary_key: "idEpisode", force: true do |t|
    t.integer "idFile"
    t.text    "c00"
    t.text    "c01"
    t.text    "c02"
    t.text    "c03"
    t.text    "c04"
    t.text    "c05"
    t.text    "c06"
    t.text    "c07"
    t.text    "c08"
    t.text    "c09"
    t.text    "c10"
    t.text    "c11"
    t.string  "c12",    limit: 24
    t.string  "c13",    limit: 24
    t.text    "c14"
    t.text    "c15"
    t.text    "c16"
    t.string  "c17",    limit: 24
    t.text    "c18"
    t.text    "c19"
    t.text    "c20"
    t.text    "c21"
    t.text    "c22"
    t.text    "c23"
    t.integer "idShow"
  end

  add_index "episode", ["c12", "c13"], name: "ix_episode_season_episode"
  add_index "episode", ["c17"], name: "ix_episode_bookmark"
  add_index "episode", ["c19"], name: "ixEpisodeBasePath"
  add_index "episode", ["idEpisode", "idFile"], name: "ix_episode_file_1", unique: true
  add_index "episode", ["idEpisode", "idShow"], name: "ix_episode_show1"
  add_index "episode", ["idFile", "idEpisode"], name: "id_episode_file_2", unique: true
  add_index "episode", ["idShow", "idEpisode"], name: "ix_episode_show2"

  create_table "files", primary_key: "idFile", force: true do |t|
    t.integer "idPath"
    t.text    "strFilename"
    t.integer "playCount"
    t.text    "lastPlayed"
    t.text    "dateAdded"
  end

  add_index "files", ["idPath", "strFilename"], name: "ix_files"

  create_table "genre", primary_key: "idGenre", force: true do |t|
    t.text "strGenre"
  end

  create_table "genrelinkmovie", id: false, force: true do |t|
    t.integer "idGenre"
    t.integer "idMovie"
  end

  add_index "genrelinkmovie", ["idGenre", "idMovie"], name: "ix_genrelinkmovie_1", unique: true
  add_index "genrelinkmovie", ["idMovie", "idGenre"], name: "ix_genrelinkmovie_2", unique: true

  create_table "genrelinkmusicvideo", id: false, force: true do |t|
    t.integer "idGenre"
    t.integer "idMVideo"
  end

  add_index "genrelinkmusicvideo", ["idGenre", "idMVideo"], name: "ix_genrelinkmusicvideo_1", unique: true
  add_index "genrelinkmusicvideo", ["idMVideo", "idGenre"], name: "ix_genrelinkmusicvideo_2", unique: true

  create_table "genrelinktvshow", id: false, force: true do |t|
    t.integer "idGenre"
    t.integer "idShow"
  end

  add_index "genrelinktvshow", ["idGenre", "idShow"], name: "ix_genrelinktvshow_1", unique: true
  add_index "genrelinktvshow", ["idShow", "idGenre"], name: "ix_genrelinktvshow_2", unique: true

  create_table "movie", primary_key: "idMovie", force: true do |t|
    t.integer "idFile"
    t.text    "c00"
    t.text    "c01"
    t.text    "c02"
    t.text    "c03"
    t.text    "c04"
    t.text    "c05"
    t.text    "c06"
    t.text    "c07"
    t.text    "c08"
    t.text    "c09"
    t.text    "c10"
    t.text    "c11"
    t.text    "c12"
    t.text    "c13"
    t.text    "c14"
    t.text    "c15"
    t.text    "c16"
    t.text    "c17"
    t.text    "c18"
    t.text    "c19"
    t.text    "c20"
    t.text    "c21"
    t.text    "c22"
    t.text    "c23"
    t.integer "idSet"
  end

  add_index "movie", ["c23"], name: "ixMovieBasePath"
  add_index "movie", ["idFile", "idMovie"], name: "ix_movie_file_1", unique: true
  add_index "movie", ["idMovie", "idFile"], name: "ix_movie_file_2", unique: true

  create_table "movielinktvshow", id: false, force: true do |t|
    t.integer "idMovie"
    t.integer "IdShow"
  end

  add_index "movielinktvshow", ["IdShow", "idMovie"], name: "ix_movielinktvshow_1", unique: true
  add_index "movielinktvshow", ["idMovie", "IdShow"], name: "ix_movielinktvshow_2", unique: true

  create_table "musicvideo", primary_key: "idMVideo", force: true do |t|
    t.integer "idFile"
    t.text    "c00"
    t.text    "c01"
    t.text    "c02"
    t.text    "c03"
    t.text    "c04"
    t.text    "c05"
    t.text    "c06"
    t.text    "c07"
    t.text    "c08"
    t.text    "c09"
    t.text    "c10"
    t.text    "c11"
    t.text    "c12"
    t.text    "c13"
    t.text    "c14"
    t.text    "c15"
    t.text    "c16"
    t.text    "c17"
    t.text    "c18"
    t.text    "c19"
    t.text    "c20"
    t.text    "c21"
    t.text    "c22"
    t.text    "c23"
  end

  add_index "musicvideo", ["c14"], name: "ixMusicVideoBasePath"
  add_index "musicvideo", ["idFile", "idMVideo"], name: "ix_musicvideo_file_2", unique: true
  add_index "musicvideo", ["idMVideo", "idFile"], name: "ix_musicvideo_file_1", unique: true

# Could not dump table "path" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "seasons", primary_key: "idSeason", force: true do |t|
    t.integer "idShow"
    t.integer "season"
  end

  add_index "seasons", ["idShow", "season"], name: "ix_seasons"

  create_table "sets", primary_key: "idSet", force: true do |t|
    t.text "strSet"
  end

# Could not dump table "settings" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "stacktimes", id: false, force: true do |t|
    t.integer "idFile"
    t.text    "times"
  end

  add_index "stacktimes", ["idFile"], name: "ix_stacktimes", unique: true

  create_table "streamdetails", id: false, force: true do |t|
    t.integer "idFile"
    t.integer "iStreamType"
    t.text    "strVideoCodec"
    t.float   "fVideoAspect"
    t.integer "iVideoWidth"
    t.integer "iVideoHeight"
    t.text    "strAudioCodec"
    t.integer "iAudioChannels"
    t.text    "strAudioLanguage"
    t.text    "strSubtitleLanguage"
    t.integer "iVideoDuration"
    t.text    "strStereoMode"
  end

  add_index "streamdetails", ["idFile"], name: "ix_streamdetails"

  create_table "studio", primary_key: "idStudio", force: true do |t|
    t.text "strStudio"
  end

  create_table "studiolinkmovie", id: false, force: true do |t|
    t.integer "idStudio"
    t.integer "idMovie"
  end

  add_index "studiolinkmovie", ["idMovie", "idStudio"], name: "ix_studiolinkmovie_2", unique: true
  add_index "studiolinkmovie", ["idStudio", "idMovie"], name: "ix_studiolinkmovie_1", unique: true

  create_table "studiolinkmusicvideo", id: false, force: true do |t|
    t.integer "idStudio"
    t.integer "idMVideo"
  end

  add_index "studiolinkmusicvideo", ["idMVideo", "idStudio"], name: "ix_studiolinkmusicvideo_2", unique: true
  add_index "studiolinkmusicvideo", ["idStudio", "idMVideo"], name: "ix_studiolinkmusicvideo_1", unique: true

  create_table "studiolinktvshow", id: false, force: true do |t|
    t.integer "idStudio"
    t.integer "idShow"
  end

  add_index "studiolinktvshow", ["idShow", "idStudio"], name: "ix_studiolinktvshow_2", unique: true
  add_index "studiolinktvshow", ["idStudio", "idShow"], name: "ix_studiolinktvshow_1", unique: true

  create_table "tag", primary_key: "idTag", force: true do |t|
    t.text "strTag"
  end

  add_index "tag", ["strTag"], name: "ix_tag_1", unique: true

  create_table "taglinks", id: false, force: true do |t|
    t.integer "idTag"
    t.integer "idMedia"
    t.text    "media_type"
  end

  add_index "taglinks", ["idMedia", "media_type", "idTag"], name: "ix_taglinks_2", unique: true
  add_index "taglinks", ["idTag", "media_type", "idMedia"], name: "ix_taglinks_1", unique: true
  add_index "taglinks", ["media_type"], name: "ix_taglinks_3"

  create_table "tvshow", primary_key: "idShow", force: true do |t|
    t.text "c00"
    t.text "c01"
    t.text "c02"
    t.text "c03"
    t.text "c04"
    t.text "c05"
    t.text "c06"
    t.text "c07"
    t.text "c08"
    t.text "c09"
    t.text "c10"
    t.text "c11"
    t.text "c12"
    t.text "c13"
    t.text "c14"
    t.text "c15"
    t.text "c16"
    t.text "c17"
    t.text "c18"
    t.text "c19"
    t.text "c20"
    t.text "c21"
    t.text "c22"
    t.text "c23"
  end

  add_index "tvshow", ["c17"], name: "ixTVShowBasePath"

  create_table "tvshowlinkpath", id: false, force: true do |t|
    t.integer "idShow"
    t.integer "idPath"
  end

  add_index "tvshowlinkpath", ["idPath", "idShow"], name: "ix_tvshowlinkpath_2", unique: true
  add_index "tvshowlinkpath", ["idShow", "idPath"], name: "ix_tvshowlinkpath_1", unique: true

  create_table "version", id: false, force: true do |t|
    t.integer "idVersion"
    t.integer "iCompressCount"
  end

  create_table "writerlinkepisode", id: false, force: true do |t|
    t.integer "idWriter"
    t.integer "idEpisode"
  end

  add_index "writerlinkepisode", ["idEpisode", "idWriter"], name: "ix_writerlinkepisode_2", unique: true
  add_index "writerlinkepisode", ["idWriter", "idEpisode"], name: "ix_writerlinkepisode_1", unique: true

  create_table "writerlinkmovie", id: false, force: true do |t|
    t.integer "idWriter"
    t.integer "idMovie"
  end

  add_index "writerlinkmovie", ["idMovie", "idWriter"], name: "ix_writerlinkmovie_2", unique: true
  add_index "writerlinkmovie", ["idWriter", "idMovie"], name: "ix_writerlinkmovie_1", unique: true

end
