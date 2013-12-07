class MovieBuildWorker < BaseWorker
  def perform(movie_id)
    @movie = Movie.find movie_id
    MovieBuildService.new(@movie).build!
    MovieH264Worker.perform_async(@movie.id)
  end
end