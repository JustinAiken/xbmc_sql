namespace :xbmc_sql do
  namespace :update do
    desc "Update the top 250 movies"
    task top_250: :environment do
      Top250Updater.go!
    end

    desc "Update all imdb ratings/votes"
    task ratings: :environment do
      RatingUpdater.go!
    end
  end
end
