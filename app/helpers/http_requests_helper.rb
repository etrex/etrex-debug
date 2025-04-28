module HttpRequestsHelper
  def method_color(method)
    case method.to_s.upcase
    when 'GET'
      'primary'
    when 'POST'
      'success'
    when 'PUT', 'PATCH'
      'warning'
    when 'DELETE'
      'danger'
    else
      'secondary'
    end
  end
end
