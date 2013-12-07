class PreviewDownloadWorker < BaseWorker
  def perform(preview_id)
    @preview = Preview.find preview_id
    PreviewDownloadService.new(@preview).download!

    PreviewGifWorker.perform_async(@preview.id)
    PreviewMovieWorker.perform_async(@preview.id)

    if @preview.movie.can_build?
      MovieBuildWorker.perform_async(@preview.movie.id)
    end
  end
end