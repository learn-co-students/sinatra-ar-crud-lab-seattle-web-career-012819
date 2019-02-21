
require_relative '../../config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  # READ
  get '/articles' do
    @articles = Article.all
    erb :articles
  end

  # READ
  get '/articles/new' do
    erb :new
  end

  # CREATE
  post '/articles' do
    article = Article.create(params)
    redirect "/articles/#{article.id}"
  end
  
  # READ
  get '/articles/:id' do
    # binding.pry
    @article = Article.find(params[:id])
    erb :show
  end

  # UPDATE
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    article = Article.find(params[:id])
    article_params = params.reject {|k,v| k == "_method"}
    article = article.update(article_params)
    redirect "/articles/#{article.id}"
  end
  
  delete '/articles/:id' do
    article = Article.find(params[:id])
    article.destroy
    redirect '/articles'
  end


end
