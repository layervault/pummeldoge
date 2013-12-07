class PreviewGifService < PreviewBaseService
  def initialize(preview)
    raise "Cannot convert to movie without downloaded preview!" unless preview.preview_data.exists?
    @preview = preview
  end

  def convert!
    gif_tempfile = Tempfile.new([SecureRandom.hex, '.gif'], encoding: 'ascii-8bit')

    command = "convert #{@preview.preview_data.path} -resize 800x600^ -gravity north -extent 800x600 #{gif_tempfile.path}"

    logger.info command
    `#{command}`
    raise "Failed to construct movie" unless $?.success?

    @preview.gif_data = gif_tempfile
    @preview.save!
  end
end