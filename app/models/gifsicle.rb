class Gifsicle
  class << self
    def available?
      `which gifsicle`
      $?.success?
    end

    def path
      `which gifsicle`.strip
    end
  end
end