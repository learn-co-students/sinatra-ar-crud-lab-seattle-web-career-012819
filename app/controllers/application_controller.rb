
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to "/articles"
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    @articles = Article.new
    erb :new
  end

  post '/articles' do
    @article = Article.create(params)
    redirect to "/articles/#{Article.last.id}"
  end



  get '/articles/:id' do
    @id = params[:id]
    @article = Article.all.find(@id)
    erb :show
  end



  get '/articles/:id/edit' do
    @id = params[:id]
    @article = Article.all.find(@id)

    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.all.find(params[:id])
    new_params = params.reject{|k, v| k == "_method"}
    @article.update(new_params)
    redirect to "/articles/#{article.id}"
  end

  delete '/articles/:id' do
    @article = Article.all.find(params[:id])
    @article.delete
    @articles = Article.all
    erb :index
  end
end
