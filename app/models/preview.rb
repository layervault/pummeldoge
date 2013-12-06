class Preview < ActiveRecord::Base
  belongs_to :movie
  has_attached_file :preview_data
  has_attached_file :movie_data
  has_attached_file :gif_data

  def download!
    raise "Preview does not have url" if url.blank?
    tempfile = Tempfile.new([SecureRandom.hex, '.png'], encoding: 'ascii-8bit')

    open(url) do |f|
      tempfile.write f.read
      self.preview_data = tempfile
    end

    save!
    tempfile.close
  end

  def convert_to_gif!
    raise "Cannot convert to movie without downloaded preview!" unless preview_data.exists?

    gif_tempfile = Tempfile.new([SecureRandom.hex, '.gif'], encoding: 'ascii-8bit')

    command = "convert #{preview_data.path} -resize 800x600^ -gravity center -extent 800x600 #{gif_tempfile.path}"

    logger.info command
    `#{command}`
    raise "Failed to construct movie" unless $?.success?

    self.gif_data = gif_tempfile
    save!
  end

  # Builds a 1 second long movie with a freeze-frame of the preview
  def convert_to_movie!
    raise "Cannot convert to movie without downloaded preview!" unless preview_data.exists?

    movie_tempfile = Tempfile.new([SecureRandom.hex, '.ts'], encoding: 'ascii-8bit')

    command = "#{FFMPEG.path} -y"
    command << " -loop 1"
    command << " -i \"#{preview_data.path}\""
    command << " -f mpegts"
    command << " -t 1"
    command << " -s #{Movie::WIDTH}x#{Movie::HEIGHT}"

    command << " #{movie_tempfile.path}"

    logger.info command
    `#{command}`
    raise "Failed to construct movie" unless $?.success?

    self.movie_data = movie_tempfile
    save!
  end
end
