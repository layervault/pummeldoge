class Movie < ActiveRecord::Base
  has_many :previews
  has_attached_file :movie_data
  has_attached_file :h264
  has_attached_file :gif

  FRAME_RATE = 6
  WIDTH = 800
  HEIGHT = 600

  def self.create_with_service(preview_service)
    movie = self.new

    preview_service.thumbs.each do |thumb|
      movie.previews.build(url: thumb)
    end

    movie
  end

  def build_movie!
    movie_tempfile = Tempfile.new([SecureRandom.hex, '.mov'], encoding: 'ascii-8bit')

    command = "#{FFMPEG.path} -y"
    command << " -i \"concat:#{preview_paths.join('|')}\""
    command << " -vcodec qtrle"
    command << " #{movie_tempfile.path}"

    logger.info command
    `#{command}`
    raise "Failed to construct movie" unless $?.success?

    self.movie_data = movie_tempfile
    save!
  end

  def make_h264!
    raise "Must first build the movie!" unless movie_data.exists?

    h264_tempfile = Tempfile.new([SecureRandom.hex, '.mp4'], encoding: 'ascii-8bit')

    command = "#{FFMPEG.path} -y"
    command << " -i #{movie_data.path}"
    command << " -c:v libx264"
    command << " -vf \"setpts=(1/10)*PTS\""
    command << " -preset ultrafast -qp 0"
    command << " #{h264_tempfile.path}"

    logger.info command
    `#{command}`
    raise "Failed to construct movie" unless $?.success?

    self.h264 = h264_tempfile
    save!
  end

  def make_gif!
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

    self.gif = gif_tempfile
    save!
  end

  private

  def preview_paths
    previews.map(&:movie_data).map(&:path)
  end

  def preview_gif_paths
    previews.map(&:gif_data).map(&:path)
  end
end
