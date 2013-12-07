class Preview < ActiveRecord::Base
  belongs_to :movie
  has_attached_file :preview_data
  has_attached_file :movie_data
  has_attached_file :gif_data

  after_commit :download_if_url_changed

  scope :undownloaded,  -> { where(preview_data_file_name: nil) }
  scope :downloaded,    -> { where('preview_data_file_name is not null') }
  scope :needs_movie,   -> { where(movie_data_file_name: nil) }
  scope :needs_gif,     -> { where(gif_data_file_name: nil) }

  def download!
    PreviewDownloadWorker.perform_async(id)
  end

  def convert_to_gif!
    PreviewGifService.new(self).convert!
  end

  def convert_to_movie!
    PreviewMovieService.new(self).convert!
  end

  private

  def download_if_url_changed
    download! if previous_changes['url']
  end
end
