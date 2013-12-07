class MoviesController < ApplicationController
  before_filter :set_movie, only: [:show, :build]
  before_filter :require_user
  before_filter :require_user_owns_movie, only: [:show, :build]

  def create
    @movie = current_user.movies.build(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to movie_path(@movie) }
      else
        format.html { render text: "CRAP"}
      end
    end
  end

  def show
  end

  def build
    PreviewGatheringWorker.perform_async(@movie.id)

    flash[:notice] = "Scheduled a build for your movie"
    respond_to do |format|
      format.html { redirect_to movie_path(@movie) }
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:organization_permalink, :project_name, :folder_path, :file_name)
  end

  def set_movie
    @movie = Movie.find params[:id] if params[:id]
    @movie ||= Movie.find params[:movie_id]
  end

  def require_user_owns_movie
    unless @movie.user == current_user
      render status: :forbidden and return
    end
  end
end
