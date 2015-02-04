[![Circle CI](https://circleci.com/gh/cshirley/company_check.svg?style=svg)](https://circleci.com/gh/cshirley/company_check)
[![Coverage Status](https://coveralls.io/repos/cshirley/company_check/badge.svg)](https://coveralls.io/r/cshirley/company_check)
# CompanyCheck

API wrapper for http://www.companycheck.com leveraging Faraday.

Support has been added for SSO features.

The level of information returned from the API depends on your subscription to company check service.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'company_check', git: 'https://github.com/cshirley/company_check.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install company_check

## Usage

Get Bank Account Details:

```ruby
client =CompanyCheck::Client.new({login_uri:login_uri, key:api_key, secret:api_secret})
```
To Search for a company:

```ruby
json_response = client.company_search({ name:"foobar", postcode:"aaaaaa"})

    [{"number":"x892xxxx",
      "name":"????? CONSULTING LIMITED",
      "status":"Active",
      "sic":"N\/A",
      "address":"some address",
      "country":"GB"}]
```

Find more details about the company:
```ruby
json_response = client.company(company_number)
```

To Search for a director:
```ruby
json_response = client.director_search({ name:"Clive Shirley", postcode:"GU"})

    [{"number":"x066xxxxx",
      "name":"Mr Clive Shirley",
      "registeredPostcodes":[{"postcode0":"GU12 xxx"},
                             {"postcode0":"GU34 yyy"},
                             {"postcode0":"GU34 zzz"}]}]
```
Find more details about the director:
```ruby
json_response = client.company(director_number)
```

### Exceptions
Authentication Failure:

```ruby
CompanyCheck::AuthenticationError
```

Invalid Query:

```ruby
CompanyCheck::InvalidQueryParameter
```

Server Generated API Error:

```ruby
CompanyCheck::ApiException
```
## TODO

Currently we are lacking support for downloading company documents.  Although you can search for said documents using gem.

## Contributing

1. Fork it ( https://github.com/cshirley/company_check/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
