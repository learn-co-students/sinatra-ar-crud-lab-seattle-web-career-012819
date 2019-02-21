
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/' do
    erb :index
  end

  get '/articles' do
    @arcticles = Article.all
    erb :articles
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    Article.create(params)
    article_id = Article.last.id
    redirect "/articles/#{article_id}"
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    article  = Article.find(params[:id])
    article_params = params.reject{|k,v| k == '_method'}
    article.update(article_params)
    redirect "/articles/#{article.id}"
  end

  delete '/articles/:id' do
    @article = Article.find(params[:id])
    @article.delete
    redirect '/articles'
  end

end
