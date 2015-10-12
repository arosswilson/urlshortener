require 'pry'
helpers do
  def domain
    return request.host_with_port if Sinatra::Application.development? || Sinatra::Application.test?
    request.host
  end

  def handle_post_request(url)
    if url.save && request.xhr?
      url.set_short_code
      erb :'/urls/_url', locals: {url: url}, layout: false
    elsif request.xhr?
      erb "{\"error\": \"please make sure your link starts with 'http://'\"}", layout: false
    elsif url.save
      url.set_short_code
      redirect "/urls/#{url.id}"
    else
      flash[:notice] ="there was an issue"
      redirect back
    end
  end
end


