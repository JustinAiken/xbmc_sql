module XbmcSql
  class Top250Updater

    def self.go!
      self.new.tap do |updater|
        updater.scrape
        updater.update_current
        updater.remove_old
        updater.note_missing
      end
      true
    rescue => e
      puts e
      false
    end

    attr_accessor :rows, :missing

    def initialize
      @rows    = {}
      @missing = {}
    end

    ID_PARSER = /(tt\d*)\//

    def scrape
      table.each do |row|
        position = row.at_xpath('td[2]/span[1]/text()').to_s.gsub('.', '')
        title    = row.at_xpath('td[2]/a/text()').to_s
        tt       = ID_PARSER.match(row.at_xpath('td[2]/a/@href').to_s)[1]

        rows[position] = {title: title, imdb_id: tt }
      end
    end

    def update_current
      puts "----------------------- updating current... -----------------------------"

      rows.each do |position, values|
        movies = XbmcSql::Movie.with_imdb_id values[:imdb_id]

        if movies.present?
          movies.each { |movie| update_movie! movie, position }
        else
          puts "##{position}: #{values[:title]} IS MISSING"
          missing[position] = values
        end
      end
    end

    def remove_old
      puts "----------------------- Removing old. -----------------------------"
      XbmcSql::Movie.in_top_250.each do |movie|
        if movie.imdb_250 != simple_list[movie.imdb_id]
          puts "Removing #{movie.title} - previously was ##{movie.imdb_250}, now is not in the list."
          movie.update_attributes! imdb_250: nil
        end
      end
      puts "------------------------------------------------------------------"
    end

    def note_missing
      missing.each do |position, values|
        puts "YOU ARE MISSING ##{position}: #{values[:title]}"
      end
    end

  private

    def update_movie!(movie, position)
      if movie.imdb_250.blank?
        puts "##{position}: #{movie.title} entered the list"
      elsif movie.imdb_250 == position
        puts "##{position}: #{movie.title} stayed at ##{movie.imdb_250}"
      elsif movie.imdb_250.to_i < position.to_i
        puts "##{position}: #{movie.title} raised up from ##{movie.imdb_250}"
        movie.update_attributes! imdb_250: position
      else
        puts "##{position}: #{movie.title} fell from ##{movie.imdb_250}"
        movie.update_attributes! imdb_250: position
      end
    end

    def table
      @table ||= page.xpath('//table/tbody[@class="lister-list"]/tr')
    end

    def page
      @page ||= begin
        response = HTTParty.get('http://www.imdb.com/chart/top')
        Nokogiri::HTML response.body
      end
    end

    def simple_list
      rows.inject({}) do |result, (position, values)|
        result[values[:imdb_id]] = position
        result
      end
    end
  end
end
