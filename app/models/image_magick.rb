class ImageMagick
  class << self
    def available?
      `which convert`
      $?.success?
    end

    def path
      `which convert`.strip
    end
  end
end