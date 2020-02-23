#!/bin/bash
# send  http collector


php -d extension=molten.so -d molten.enable=1 -d molten.sink_type=4 -d molten.tracing_cli=1 -d molten.sink_http_uri=http://10.26.29.69:9411/api/v1/spans -d molten.service_name=php_test2 -d molten.sampling_rate=1 -r '$c=curl_init("http://www.baidu.com");curl_exec($c);'

