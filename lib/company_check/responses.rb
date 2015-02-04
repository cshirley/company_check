module Faraday
  class Response::CompanyCheck < Response::Middleware

    def call(env)
      @app.call(env).on_complete do
        response = JSON.parse(env[:body])
        check_status response
      end
    end

    def check_status(json_body)
      return if json_body.is_a? Array
      if json_body.has_key?("errorCode")
        error_code = json_body["errorCode"].to_i
        error_message = json_body["errorMessage"]
        raise CompanyCheck::ApiException.new(error_code, error_message) if error_code >= 500
        raise CompanyCheck::InvalidParameterError.new(error_code, error_message) if error_code == 400 || error_code == 404
        raise CompanyCheck::AuthenticationError.new(error_code, error_message) if error_code >= 401 &&  error_code <= 403
        raise CompanyCheck::QuotaExceededError.new(error_code, error_message) if error_code = 429
      end
    end
  end
end
