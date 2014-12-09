require 'xmlsimple'

class XbmcSql::NfoFile

  attr_accessor :raw_file

  def initialize(raw_file)
    @raw_file = raw_file
  end

  def save!
    File.open(raw_file, 'w+') { |f| f.write new_doc }
  end

  def doc
    @doc ||= XmlSimple.xml_in(File.read(@raw_file))
  end

  def new_doc
    out = XmlSimple.xml_out doc,
      xmldeclaration: '<?xml version="1.0" encoding="utf-8"?>',
      rootname:       'movie',
      noescape:       true
    out.gsub /<([^>]+)>\s*<\/\1>/, '<\1 />'
  end

  SIMPLE_ATTRIBUTES = %w{
    id title originaltitle sorttitle year releasedate top250 rating
    votes mpaa certification studio outline plot runtime playcount
  }

  PLURAL_ATTRIBUTES = {
    countries: 'country',
    genres:    'genre',
    directors: 'director',
    credits:   'credits',
    actors:    'actor',
    thumbs:    'thumb',
    fanart:    'fanart'
  }

  SIMPLE_ATTRIBUTES.each do |attr|
    define_method(attr)       {           doc[attr][0] }
    define_method("#{attr}=") { |new_val| doc[attr][0] = new_val }
  end

  PLURAL_ATTRIBUTES.each do |k, v|
    define_method(k)       {           doc[v] }
    define_method("#{k}=") { |new_val| doc[v] = new_val }
  end

  ##
  # File info

  def video_streams
    streams['video']
  end

  def audio_streams
    streams['audio']
  end

  def sub_streams
    streams['sub']
  end

  def video_stream
    video_streams[0]
  end

private

  def streams
    doc['fileinfo'][0]['streamdetails'][0]
  end
end
