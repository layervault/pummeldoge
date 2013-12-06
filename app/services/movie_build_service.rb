class MovieBuildService < MovieBaseService
  def can_build?
    preview_paths.select(&:nil?).size == 0
  end

  def build!
    check_previews!
    movie_tempfile = Tempfile.new([SecureRandom.hex, '.mov'], encoding: 'ascii-8bit')

    command = "#{FFMPEG.path} -y"
    command << " -i \"concat:#{preview_paths.join('|')}\""
    command << " -vcodec qtrle"
    command << " #{movie_tempfile.path}"

    logger.info command
    `#{command}`
    raise "Failed to construct movie" unless $?.success?

    @movie.movie_data = movie_tempfile
    @movie.save!
  end

  private

  def check_previews!
    unless can_build?
      raise "One or more previews have not been downloaded and made into a movie!"
    end
  end
end