class MovieGifWorker < BaseWorker
  def perform(movie_id)
    @movie = Movie.find movie_id
    @movie.make_gif!
  end
end