require 'net/http'
require 'json'

HOST = 'nodes-on-nodes-challenge.herokuapp.com'
ROUTE = '/nodes/'
INITIAL_PARENT_NODE_ID = '089ef556-dfff-4ff2-9733-654645be56fe'
CHILD_NODE_KEY = "child_node_ids"

def append_network_nodes(id_list, parent_id)
  next_nodes = JSON.parse(Net::HTTP.get(HOST, ROUTE + parent_id))
  next_nodes.each do |node|
  	id_list.push node[CHILD_NODE_KEY]
  end
end

ids = []
append_network_nodes(ids, INITIAL_PARENT_NODE_ID)
puts ids
