class PreviewGatheringWorker < BaseWorker
  def perform(movie_id)
    @movie = Movie.find movie_id
    PreviewGatheringService.new(@movie.user).thumbs(@movie.organization_permalink, @movie.project_name).each do |thumb|
      @movie.previews.build(url: thumb)
    end

    @movie.save!
  end
end