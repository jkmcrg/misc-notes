require 'net/http'
require 'json'
require 'set'

HOST = 'nodes-on-nodes-challenge.herokuapp.com'
ROUTE = '/nodes/'
INITIAL_PARENT_NODE_ID = '089ef556-dfff-4ff2-9733-654645be56fe'
CHILD_NODES_KEY = "child_node_ids"

def append_network_nodes(id_list, parent_id)
  next_nodes = JSON.parse(Net::HTTP.get(HOST, ROUTE + parent_id))
  next_nodes.each do |node|
  	id_list.push node["id"]
  	node[CHILD_NODES_KEY].each { |id| append_network_nodes(id_list, id) }
  end
end

ids = []
append_network_nodes(ids, INITIAL_PARENT_NODE_ID)

puts "unique id count:"
puts ids.to_set.length

id_counts = {}
ids.each { |id| id_counts[id] = id_counts[id] ? id_counts[id] + 1 : 1 }
puts "id with maximum occurrences:"
puts id_counts.sort_by { |id, count| count }.last[0]

# unique id count:
# 30
# id with maximum occurrences:
# a06c90bf-e635-4812-992e-f7b1e2408a3f
