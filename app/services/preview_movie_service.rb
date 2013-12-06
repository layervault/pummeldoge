# Builds a 1 second long movie with a freeze-frame of the preview
class PreviewMovieService < PreviewBaseService
  def initialize(preview)
    raise "Cannot convert to movie without downloaded preview!" unless preview.preview_data.exists?
    @preview = preview
  end

  def convert!
    movie_tempfile = Tempfile.new([SecureRandom.hex, '.ts'], encoding: 'ascii-8bit')

    command = "#{FFMPEG.path} -y"
    command << " -loop 1"
    command << " -i \"#{@preview.preview_data.path}\""
    command << " -f mpegts"
    command << " -t 1"
    command << " -s #{Movie::WIDTH}x#{Movie::HEIGHT}"
    command << " #{movie_tempfile.path}"

    logger.info command
    `#{command}`
    raise "Failed to construct movie" unless $?.success?

    @preview.movie_data = movie_tempfile
    @preview.save!
  end
end