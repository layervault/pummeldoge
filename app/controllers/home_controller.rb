class HomeController < ApplicationController
  def index
    if current_user
      @movie = Movie.new
      LayerVault.client.access_token = current_user.access_token
      @organizations = JSON.parse(LayerVault.client.me)['organizations']
      @projects = @organizations.map do |org|
        LayerVault::Organization.for(org['permalink']).projects
      end.flatten
    end
  end
end
