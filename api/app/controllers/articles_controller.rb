class ArticlesController < ApplicationController
  def index
    articles = Article.recent.page(params[:page]).per(params[:per])
    render json: articles
  end
  def show; end
end
