extends Node

const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT =  32501
const MAX_PLAYERS = 4 

var local_player_id = 0 

signal player_disconnected 
signal server_disconnected 


func _ready() -> void:
#	Retrieve the node [network_disconnect], send to self, connect to a method
	#Check on starup if the player is connected or not
	get_tree().connect("network_peer_disconnected", self, "_on_player_disconnected")
	get_tree().connect("network_peer_connected", self, "_on_player_connected")

#Operate when Host button is pressed
func create_server():
	#Create a network multiplayer instance
	var peer = NetworkedMultiplayerENet.new()
	#Create a server [port, # of users]
	peer.create_server(DEFAULT_PORT,MAX_PLAYERS)
	
#	This will assign a rng # to a player (Server default 1)
	get_tree().set_network_peer(peer)
	set_local_player_id()
	print("Server has been created")
	print("I am " + str(local_player_id))
	

#Operates when joining a server
func connect_to_server():
	#Create a network multiplayer instance
	var peer = NetworkedMultiplayerENet.new()
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	
	peer.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().set_network_peer(peer)
	set_local_player_id()

func set_local_player_id():
	local_player_id = get_tree().get_network_unique_id()

func _connected_to_server():
#Use RPC to send info ["method name", variable]
	rpc("_send_player_info", local_player_id)
	


#create a remote method to send player info for every OTHER player
remote func _send_player_info(id):
	if local_player_id ==1:
		print(str(id) + " has connected." )


func _on_player_connected(id):
	if not get_tree().is_network_server():
		print(str(id) + " has connected." )
















