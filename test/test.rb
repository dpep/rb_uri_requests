require 'minitest/autorun'
load 'lib/uri_requests.rb'


# test via http://httpbin.org - THANKS!
class UriRequestsTest < Minitest::Test
  HTTPBIN = 'http://httpbin.org'


  def test_get
    res = URI("#{HTTPBIN}/get").get
    assert res['args'].empty?

    res = URI("#{HTTPBIN}/get?foo&bar=baz").get
    assert_equal(
      {
        'foo' => '',
        'bar' => 'baz',
      },
      res['args'],
    )
  end


  def test_post
    url = URI(HTTPBIN + '/post')

    res = url.post
    assert res['args'].empty?
    assert res['data'].empty?
    assert res['form'].empty?

    res = url.post foo: true, bar: 'baz'
    assert res['json'].nil?
    assert res['data'].empty?
    assert_equal(
      {
        'foo' => 'true',
        'bar' => 'baz'
      },
      res['form']
    )

    res = url.post(
      { foo: true, bar: 'baz' },
      json: true,
    )
    expected = {
      'foo' => true,
      'bar' => 'baz'
    }
    assert_equal expected, res['json']
    assert_equal expected.to_json, res['data']
    assert res['form'].empty?
  end


  def test_headers
    headers = {
      'foo' => 'bar',
      'baz' => 'yay',
    }
    res = URI("#{HTTPBIN}/get").get nil, headers: headers

    headers.each do |header, val|
      assert_equal(
        val,
        res['headers'][header.capitalize]
      )
    end

    res = URI("#{HTTPBIN}/post").post nil, headers: headers
    headers.each do |header, val|
      assert_equal(
        val,
        res['headers'][header.capitalize]
      )
    end
  end


end
