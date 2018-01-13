require 'json'
require 'net/http'
require 'uri'
require 'byebug'


module UriRequests
  VERSION = '0.0.1'


  def get data = nil, opts = {}
    data ||= {}
    uri = clone

    unless data.is_a? Hash
      # if data is scalar, kindly repackage
      data = { data => nil }
    end

    unless data.empty?
      uri.query = URI.encode_www_form(data)
    end

    request Net::HTTP::Get.new(uri), **opts
  end


  def post data = nil, opts = {}
    data ||= {}
    opts = opts.clone

    req = Net::HTTP::Post.new itself

    if opts.delete(:json)
      req['Content-Type'] = 'application/json'
      req.body = data.to_json
    else
      req.set_form_data data
    end

    request req, **opts
  end


  private

  def request request, opts = {}
    use_ssl = scheme == 'https'
    res = Net::HTTP.start(host, port, use_ssl: use_ssl) do |http|
      # set headers
      (opts[:headers] or {}).each {|k,v| request[k] = v}

      # set other request options
      opts.each {|k,v| http.send k, v if k != :headers }

      http.request request
    end

    unless res.is_a?(Net::HTTPSuccess)
      raise Net::HTTPError.new "#{res.code}: #{res.message}\n#{res.body}", res
    end

    if 'application/json' == res['content-type']
      JSON::parse res.body
    else
      res.body
    end
  end


end


URI::HTTP.include UriRequests
