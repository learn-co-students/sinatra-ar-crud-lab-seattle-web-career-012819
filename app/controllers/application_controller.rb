
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  post '/articles' do
    # binding.pry
    @article = Article.create(content: params[:content], title: params[:title])
    redirect to "/articles/#{@article.id}"
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    # binding.pry
    @article = Article.find(params[:id])
    @article.update(title: params[:title], content: params[:content])
    redirect to "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    Article.delete(params[:id])
    redirect to '/articles'
  end

end
