class MovieGifService < MovieBaseService

  def can_make?
    preview_gif_paths.select(&:nil?).empty?
  end

  def make!
    gif_tempfile = Tempfile.new([SecureRandom.hex, '.gif'], encoding: 'ascii-8bit')

    command = "#{Gifsicle.path}"
    command << " --optimize=3"
    command << " --delay=13"
    command << " --loop"
    command << " #{preview_gif_paths.join(' ')}"
    command << " > #{gif_tempfile.path}"

    logger.info command
    `#{command}`
    raise "Failed to construct movie" unless $?.success?

    @movie.gif = gif_tempfile
    @movie.save!
  end
end