class MovieH264Service < MovieBaseService
  SPEED_MULTIPLIER = 10

  def make!
    raise "Must first build the movie!" unless movie_data.exists?

    h264_tempfile = Tempfile.new([SecureRandom.hex, '.mp4'], encoding: 'ascii-8bit')

    command = "#{FFMPEG.path} -y"
    command << " -i #{movie_data.path}"
    command << " -c:v libx264"
    command << " -vf \"setpts=(1/#{SPEED_MULTIPLIER})*PTS\""
    command << " -preset ultrafast -qp 0"
    command << " #{h264_tempfile.path}"

    logger.info command
    `#{command}`
    raise "Failed to construct movie" unless $?.success?

    @movie.h264 = h264_tempfile
    @movie.save!
  end
end