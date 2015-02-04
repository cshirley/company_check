module CompanyCheck
  class Client
    include ::CompanyCheck::SingleSignOn

    attr_accessor :login_uri, :secret, :key

    def base_url
      "http://companycheck.co.uk"
    end

    def initialize(options = {login_uri:nil, key:nil, secret:nil})
      @login_uri = options[:login_uri]
      @key = options[:key]
      @secret = options[:secret]
    end

    def make_request_url(url, options)
      "#{url}?#{build_params(options)}"
    end

    def query_get_api(url, options)
      JSON.parse(session.get(make_request_url(url, options)).body)
    end

private
    def build_params(options)
      options.merge!(apiKey: key)
      to_query(options)
    end

    def to_query(options)
      Faraday::Utils.build_nested_query(options)
    end

    def session
      @connection ||= ::Faraday.new base_url do |conn|
        conn.adapter Faraday.default_adapter
        conn.use Faraday::Response::CompanyCheck
      end
    end

  end
end
