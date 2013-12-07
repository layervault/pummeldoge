class MovieH264Worker < BaseWorker
  def perform(movie_id)
    @movie = Movie.find movie_id
    @movie.make_h264!
  end
end