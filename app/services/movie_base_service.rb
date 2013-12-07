class MovieBaseService
  def initialize(movie)
    @movie = movie
  end

  protected

  def preview_paths
    @movie.previews.order(:id).map(&:movie_data).map(&:path)
  end

  def preview_gif_paths
    @movie.previews.order(:id).map(&:gif_data).map(&:path)
  end

  def movie_data
    @movie.movie_data
  end

  def logger
    Rails.logger
  end
end