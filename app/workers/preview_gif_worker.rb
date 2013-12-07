class PreviewGifWorker < BaseWorker
  def perform(preview_id)
    @preview = Preview.find preview_id
    @preview.convert_to_gif!

    if MovieGifService.new(@preview.movie).can_make?
      MovieGifWorker.perform_async(@preview.movie.id)
    end
  end
end