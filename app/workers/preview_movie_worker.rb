class PreviewMovieWorker < BaseWorker
  def perform(preview_id)
    @preview = Preview.find preview_id
    @preview.convert_to_movie!
  end
end