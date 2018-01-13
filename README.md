UriRequests
======

URI::HTTP requests made easier


#### Install
```gem install uri-requests```


#### Usage
```
require 'uri-requests'

URI('http://httpbin.org/get').get foo: 'bar'

# automatically package as json and set headers
URI('http://httpbin.org/post').post(
  { foo: 'bar' },
  json: true
)

# set custom headers
URI('http://httpbin.org/post').post(
  { foo: 'bar' },
  headers: { more_headers: 'hi' },
)
```
