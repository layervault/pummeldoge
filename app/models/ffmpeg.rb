class FFMPEG
  class << self
    def available?
      `which ffmpeg`
      $?.success?
    end

    def path
      `which ffmpeg`.strip
    end
  end
end

