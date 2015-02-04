module CompanyCheck

  class BaseCommand
    ENDPOINTS = [:get]
    attr_accessor :format
    attr_accessor :endpoint
    attr_accessor :client

    def initialize(client)
      @client = client
      self.format = "json"
    end

    def endpoint
      @endpoint ||= lower_camel_case(self.class.name.split("::").last)
    end

    def method_missing(method, *args, &block)
      if ENDPOINTS.include?(method)
        options = args.empty? ? {} : args.first
        self.client.query_get_api("api/#{format}/#{self.endpoint}", options)
      else
        super
      end
    end

    def lower_camel_case(camel_case)
      underscore(camel_case).split('_').inject([]){ |buffer,e|
        buffer.push(buffer.empty? ? e.downcase : e.capitalize)
      }.join

    end

    def underscore(camel_cased_word)
      camel_cased_word.to_s.gsub(/::/, '/').
                            gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
                            gsub(/([a-z\d])([A-Z])/,'\1_\2').
                            tr("-", "_").
                            downcase
    end
  end

end
