class Movie < ActiveRecord::Base
  validates :name, :presence => true
  validates :rating, :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 10
  }

  # Pretends to hit some API, which would presumably incur some network latency.
  def self.from_paramount()
    sleep(10)

    movies = [
      {:name => 'Star Trek', :rating => 8.0},
      {:name => 'The Wolf of Wall Street', :rating => 9.2},
      {:name => 'Paranormal Activity 4', :rating => 2.6},
      {:name => 'Titanic', :rating => 7.4}
    ]
    return movies.map { |m| Movie.new(m) }
  end

  def self.average_paramount_rating()
    ratings = self.from_paramount.map { |movie| movie.rating }
    return 1.0 * ratings.reduce(:+) / ratings.size
  end
end
