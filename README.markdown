[![Build Status](http://img.shields.io/travis/JustinAiken/xbmc_sql/master.svg)](http://travis-ci.org/JustinAiken/xbmc_sql) [![Coveralls branch](http://img.shields.io/coveralls/JustinAiken/xbmc_sql/master.svg)](https://coveralls.io/r/JustinAiken/xbmc_sql?branch=master)[![Code Climate](http://img.shields.io/codeclimate/github/JustinAiken/xbmc_sql.svg)](https://codeclimate.com/github/JustinAiken/xbmc_sql)

# xbmc-sql

xbmc-sql is a Rails engine for interacting with the XBMC/Kodi database directly.  It can also update .nfo files as it makes changes to the database.

Special thanks to [Rocketmade](http://www.rocketmade.com/) for development resources.

## Requirements/Support

- Rails
  - Supported:
    - 4.0
    - 4.1
    - 4.2
- XBMC 13 (Gotham) or Kodi 14 (Helix)
- sqlite or mysql database reachable by the Rails application

## Setup

#### Installation

`gem install xbmc-sql`

#### Database

In your database.yml, set up an `xbmc_development` (or whatever environment) seperate than the other database:

```yaml
development:
   adapter: mysql2
   database: some_other_database
   username: boring_stuff
   password: foo

xbmc_development:
  adapter: mysql2
  database: xbmc
  username: xbmc_user
  password: xbmc_pass
```

#### Configuration

```ruby
XbmcSql.setup do |x|
  # Write .nfo files when matching db record is updated
  x.write_nfo_files = true # Defaults to false

  # Setup a path mapping
  #
  # This is useful if you use have the movies mounted in share
  # By default there are no mappings mapped
  x.path_mappings = {
    'smb://my_nas/' => '/Volumes/Video'
  }
end
```

## Usage

##### Movies
```ruby
movie = XbmcSql::Movie.first
movie.title # -> "Seven Samurai"
movie.genre # -> "Action / Drama"

movie.genre = "Action / Drama / History"
movie.save!
# At this point, the movie is updated in the database.
# If write .nfo files are on, the .nfo file would also be updated
```

##### Sets

```ruby
set = XbmcSql::Set.first
set.name # -> "AK100"
set.movies.map { |movie| movie.name } # -> ["Seven Samurai", "Yojimbo",... ]
```

##### Built-in tools

There are a couple of useful rake tasks:

```bash
# Update the imdb top 250 status of all movies:
rake xbmc_sql:update:top_250

# Update the imdb rating for all movies:
rake xbmc_sql:update:ratings
```

## License

MIT
