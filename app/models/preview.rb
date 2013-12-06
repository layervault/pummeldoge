class Preview < ActiveRecord::Base
  belongs_to :movie
  has_attached_file :preview_data
  has_attached_file :movie_data
  has_attached_file :gif_data

  after_commit :download_if_url_changed

  def download!
    PreviewDownloadService.new(self).download!
    convert_to_gif!
    convert_to_movie!
  end

  def convert_to_gif!
    PreviewGifService.new(self).convert!
    movie.build_movie! if movie.can_build?
  end

  def convert_to_movie!
    PreviewMovieService.new(self).convert!
    movie.build_movie! if movie.can_build?
  end

  private

  def download_if_url_changed
    download! if previous_changes['url']
  end
end
