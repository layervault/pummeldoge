class Movie < ActiveRecord::Base
  belongs_to :user
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

  def gather_and_build!
    PreviewGatheringService.new(user).thumbs(organization_permalink, project_name).each do |thumb|
      self.previews.build(url: thumb)
    end

    save!
  end

  def build_movie!
    MovieBuildService.new(self).build!
    make_h264!
    make_gif!
  end

  def make_h264!
    MovieH264Service.new(self).make!
  end

  def make_gif!
    MovieGifService.new(self).make!
  end

  def can_build?
    MovieBuildService.new(self).can_build?
  end
end
