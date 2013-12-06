class PreviewDownloadService
  def initialize(preview)
    raise "Preview does not have url" if preview.url.blank?
    @preview = preview
  end

  def download!
    tempfile = Tempfile.new([SecureRandom.hex, '.png'], encoding: 'ascii-8bit')

    open(@preview.url) do |f|
      tempfile.write f.read
      @preview.preview_data = tempfile
    end

    @preview.save!
    tempfile.close
  end
end