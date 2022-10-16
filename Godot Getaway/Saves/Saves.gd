extends Node

var save_data = {}
const SAVEGAME = "res://Saves/SavedGame.json"

func _ready() -> void:
	#get the save data on startup
	save_data = get_data()

#Method to open save data
func get_data():
	var file = File.new()
	
	#Check if there is no file with this name
	if not file.file_exists(SAVEGAME):
		#Make a dictionary: {key:value}
		save_data = {"Player_name": "Unnamed"}
		save_game()
	
	#read the saved json file (Path, Read the json file)
	file.open(SAVEGAME, File.READ)
	#convert file as a txt
	var content = file.get_as_text()
	#pass the content to a var
	var data = parse_json(content)
	save_data = data
	file.close()
	return(data)
	

func save_game():
#Create a new file to save the game 
	var save_game = File.new()
	#write the saved json file 
	save_game.open(SAVEGAME, File.WRITE)
	save_game.store_line(to_json(save_data))










