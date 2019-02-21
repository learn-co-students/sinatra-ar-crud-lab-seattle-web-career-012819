
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  post '/articles' do
    a = Article.create(params)
    redirect "/articles/#{a.id}"
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
    @editArticle = Article.find(params[:id])
    my_params = params.reject {|k,v| k == "_method"}
    @editArticle.update(my_params)
    redirect "/articles/#{@editArticle.id}"
  end

  delete '/articles/:id' do
    @article = Article.find(params[:id])
    @article.destroy
    redirect '/articles'
  end

end
