# -*- coding : utf-8 -*-
require 'sinatra'
require 'json'
require 'open-uri'
require 'open3'

def reply(data = {})
  msg = ''
  if data['status'] == 'ok' and data['events']
    data['events'].each do |e, text = e['message']['text']|
      text.match(/(ぬるぽ|ヌルポ|null)/i) do
        msg = 'ガ'
        break
      end
    end
  end
  return msg
rescue
    ''
end

post '/' do
  # request.body.rewind  # in case someone already read it
  json = JSON.parse(request.body.string)
  # data = (JSON.parse request.body.read rescue {})
  # json.to_s
  reply(json)
end

get '/' do
  'Here is pogin\'s sinatra app'
end
