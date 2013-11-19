# -*- coding : utf-8 -*-
require "sinatra"
require "json"
require "open-uri"
require 'open3'

get '/' do
  "Hello, world"
end

def reply(data={})
  msg = ""
  if data["status"] == "ok" and data["events"]
    data["events"].each do |e, text=e["message"]["text"]|
      text.match(/(ぬるぽ|ヌルポ|null)/i) do
        msg = "ガ"
        break
      end
    end
  end
  msg
rescue
  ""
end

post "/" do
    request.body.rewind  # in case someone already read it
    data = (JSON.parse request.body.read rescue {})

    reply(data)
end
