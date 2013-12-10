class HomeController < ApplicationController
  def index
    if current_user
      @movie = Movie.new
      @client = LayerVault::Client.new({ access_token: current_user.access_token })
      @organizations = JSON.parse(@client.me)['organizations']
      @projects = @organizations.map do |org|
        JSON.parse @client.organization(org['permalink'])['projects']
      end.flatten
    end
  end
end
