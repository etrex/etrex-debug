class HttpRequestsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :record_request, except: [:index, :show, :delete]

  def index
    @collection = HttpRequest.order(id: :desc).first(100)
  end

  def show
    @model = HttpRequest.find(params[:id])
  end

  def create
    # 當 params['hub.challenge'] 有值時，表示 Facebook 驗證 webhook，直接回傳 challenge
    return render plain: params['hub.challenge'] if params['hub.challenge'].present?

    respond_to do |format|
      format.html { redirect_to http_request_path(@model) }
      format.json { render :show }
    end
  end

  def delete
    HttpRequest.destroy_all
    redirect_to root_url
  end

  private

  def record_request
    @model = HttpRequest.create({
      url: request.original_url,
      method: request.method,
      params: request.query_parameters.merge(request.request_parameters),
      headers: get_headers,
      body: get_body,
      ip: request.remote_ip
    })

    HttpRequest.order(id: :desc).offset(100).delete_all
  end

  def get_headers
    headers = {}
    request.headers.each do |key, value|
      next if key.include?('.')
      
      # 轉換 Rails 特殊的 header 名稱
      normalized_key = case key
        when 'CONTENT_TYPE' then 'Content-Type'
        when 'HTTP_X_TEST'  then 'X-Test'
        when /^HTTP_/       then key.sub('HTTP_', '').split('_').map(&:capitalize).join('-')
        else key
      end
      
      # 確保值是字串
      headers[normalized_key] = value.is_a?(Array) ? value.first : value
    end
    headers
  end

  def get_body
    return "" unless request.body.respond_to?(:read)
    
    body = request.body.read
    request.body.rewind

    if request.content_type == 'application/json'
      begin
        parsed = JSON.parse(body)
        return parsed.to_json
      rescue JSON::ParserError
        return body
      end
    end

    body.to_s.force_encoding('UTF-8')
  end
end