extends Spatial


func _ready() -> void:
	#Spawn host player at startup
	spawn_local_player()
	#Spawn other players at startup, Pass in their id for name
	rpc("spawn_remote_player", Network.local_player_id)
	


func spawn_local_player():
	var new_player = preload("res://Player/Player.tscn").instance()
	#Set a player name to the network name
	new_player.name = str(Network.local_player_id)
	$Players.add_child(new_player)

#Similar function to local player spawn func
remote func spawn_remote_player(id):
	var new_player = preload("res://Player/Player.tscn").instance()
	#Set a player name to the network name
	new_player.name = str(id)
	$Players.add_child(new_player)
	
