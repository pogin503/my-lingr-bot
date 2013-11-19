# -*- coding : utf-8 -*-
require "sinatra"
require "json"
require "open-uri"
require 'open3'

def sandbox(&code)
  proc {
    $SAFE = 2
    eval &code
  }.call

end

get '/' do
  "Here is pogin's sinatra app"
end

post '/' do
  content_type :text
  json = JSON.parse(request.body.read)
  json["events"].map do |e|
    if e["message"]
      m = e["message"]["text"]
      if /^!\s?(.*)/ =~ m
        x = Thread.start do
          $SAFE = 2
          eval "#{$1}"
        end
          "#{x.value}"
          #sandbox{$1}
      end
    end
  end
end
