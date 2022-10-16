extends Popup

onready var PlayerList = $VBoxContainer/CenterContainer/ItemList

func _ready() -> void:
	PlayerList.clear()

#Refresh the list of players in the lobby
func refresh_players(players):
	PlayerList.clear()

	for player_id in players:
		#JSON requires keys to be a string
		var player = players[player_id]["Player_name"]
		#Item(var, does it have a texture, is it selectable)
		PlayerList.add_item(player, null, false)
		
		
