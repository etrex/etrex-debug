class HttpRequestsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @collection = HttpRequest.order(id: :desc).first(100)
  end

  def show
    @model = HttpRequest.find(params[:id])
  end

  def create
    @model = HttpRequest.create({
      url: request.referrer || "(direct)",
      method: request.method,
      params: params,
      headers: get_headers,
      body: get_body,
      ip: request.remote_ip
    })

    if HttpRequest.count > 100
      HttpRequest.order(:id).first.destroy
    end
    render :show
  end

  def delete
    HttpRequest.destroy_all
    redirect_to root_url
  end

  private
  def get_headers
    request.headers.to_h.reject{ |key, value|
      key.include? '.'
    }
  end

  def get_body
    body = request.body.read if request.body.respond_to?(:read)
    body ||= request.body
    body.force_encoding('UTF-8')
  end
end