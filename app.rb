require 'net/http'

puts Net::HTTP.get('nodes-on-nodes-challenge.herokuapp.com', '/nodes/089ef556-dfff-4ff2-9733-654645be56fe')
