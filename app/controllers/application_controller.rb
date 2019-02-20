require "pry"
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get "/articles/new" do
    erb :new
  end

  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :show
  end

  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit
  end

  get "/articles" do
    @articles = Article.all
    erb :index
  end

  post "/articles" do
    @article = Article.create(params)
    redirect "/articles/#{@article.id}"
  end

  patch "/articles/:id" do
    article = Article.find(params[:id])
    article_params = params.reject{|k, v| k == '_method'}
    article.update(article_params)
    redirect "/articles/#{article.id}"
  end

  delete "/articles/:id" do
    article = Article.find(params[:id])
    article.delete
    redirect "/articles"
  end
end
