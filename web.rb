# -*- coding : utf-8 -*-
require "sinatra"
require "json"
require "open-uri"
require 'open3'

get '/' do
  "Hello, world"
end

# def reply(data={})
#   msg = ""
#   if data["status"] == "ok" and data["events"]
#     data["events"].each do |e, text=e["message"]["text"]|
#       text.match(/(ぬるぽ|ヌルポ|null)/i) do
#         msg = "ガ"
#         break
#       end
#     end
#   end
#   msg
# rescue
#   ""
# end

def sandbox(&code)
  proc {
    $SAFE = 2
    eval &code
  }.call

end

get '/' do
  "Here is raa0121's sinatra app"
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


# post "/do" do
#     request.body.rewind  # in case someone already read it
#     data = (JSON.parse request.body.read rescue {})

#     reply(data)
# end
# def lingr_

# end
