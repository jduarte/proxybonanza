module Proxybonanza
  class Client
    require 'faraday'
    require 'json'

    BASE_URL = "https://api.proxybonanza.com/v1/".freeze

    attr_reader :api_key
    def initialize(api_key)
      @api_key = api_key
    end

    # GET https://api.proxybonanza.com/v1/userpackages.json
    # List of active proxy plans in user account.
    def get_userpackages
      Responses::GetUserPackages.new get("userpackages.json")
    end

    # GET https://api.proxybonanza.com/v1/userpackages/[userpackage ID].json
    # Details of proxy plan including list of proxy IPs.
    # Substitute [userpackage ID] with ID from https://api.proxybonanza.com/v1/userpackages.json results.
    def get_userpackage(userpackage_id)
      Responses::GetUserPackage.new get("userpackages/#{userpackage_id}.json")
    end

    # GET https://api.proxybonanza.com/v1/authips.json
    # List of all authentication IPs in user account.
    def get_authips
      Responses::GetAuthips.new get("authips.json")
    end

    # POST https://api.proxybonanza.com/v1/authips.json
    # Add new authentication IP to proxy plan. POST parameters: ip, userpackage_id. Returns ID of created authentication IP.
    def post_authips
      Responses::PostAuthips.new post("authips.json")
    end

    # DELETE https://api.proxybonanza.com/v1/authips/[auth IP ID].json
    # Remove authentication IP from proxy plan. Substitute [auth IP ID] with ID from GET https://api.proxybonanza.com/v1/authips.json results.
    def delete_authip(authip_id)
      Responses::DeleteAuthip.new delete("authips/#{authip_id}.json")
    end

    # GET https://api.proxybonanza.com/v1/userpackagedailystats/[userpackage ID].json
    # Data transfer usage stats for the last 30 days. Substitute [userpackage ID]
    # with ID from https://api.proxybonanza.com/v1/userpackages.json results.
    # bnd_http and bnd_socks show data transfer for socks5 and http proxy protocols in bytes.
    # conn_http and conn_socks show number of requests/connections.
    def get_userpackagedailystats(userpackage_id)
      Responses::GetUserPackageDailyStats.new get("userpackagedailystats/#{userpackage_id}.json")
    end

    # GET https://api.proxybonanza.com/v1/userpackagehourlystats/[userpackage ID].json
    # Data transfer for the last 24 hours. Substitute [userpackage ID] with ID
    # from https://api.proxybonanza.com/v1/userpackages.json results.
    # When used with date parameter, it’ll show hourly data transfer usage for a
    # given date. For example: https://api.proxybonanza.com/v1/userpackagehourlystats/[userpackage ID].json?date=2014-01-01.
    def get_userpackagehourlystats(userpackage_id)
      Responses::GetUserPackageHourlyStats.new get("userpackagehourlystats/#{userpackage_id}.json")
    end

    private

    def get(url)
      make_request(:get, url)
    end

    def post(url)
      make_request(:post, url)
    end

    def delete(url)
      make_request(:delete, url)
    end

    def make_request(http_method, url)
      response = conn.send(http_method) do |req|
        req.url(url)
        req.headers['Authorization'] = api_key
      end

      response.body
    end

    def conn
      Faraday.new(url: BASE_URL) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end
  end
end
