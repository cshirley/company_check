module CompanyCheck
  module SingleSignOn

    def get_sso_login_url(user_email_address)
      params = to_query({e:user_email_address,
                         d:generate_digest([key,
                                            user_email_address,
                                            Date.today.to_s]) } )

      "#{base_url}/#{login_uri}?#{params}"
    end

    def generate_digest(data_array)
      ::Digest::MD5.hexdigest(data_array.join(':'))
    end

  end
end

