class MoviesController < ApplicationController
  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      format.html { render text: "OK" }
    else
      format.html { render text: "CRAP"}
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:organization_permalink, :project_name, :folder_path, :file_name)
  end
end
