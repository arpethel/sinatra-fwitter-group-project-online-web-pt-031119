class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/new"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] !=""
        @tweet = Tweet.new(content: params[:content])
        @tweet.user = current_user
        @tweet.save

        redirect "/tweets/#{@tweet.id}"
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :"/tweets/edit_tweet"
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if params[:content] != ""
        @tweet.update(content: params[:content])
        erb :"tweets/show_tweet"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user == current_user
        @tweet.destroy
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

end
