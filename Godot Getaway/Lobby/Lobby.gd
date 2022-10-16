extends Control

onready var nameTextBox = $VBoxContainer/CenterContainer/GridContainer/NameTextBox
onready var port = $VBoxContainer/CenterContainer/GridContainer/PortTextBox
onready var selected_IP = $VBoxContainer/CenterContainer/GridContainer/IPTextBox

func _ready() -> void:
	nameTextBox.text = Saves.save_data["Player_name"]
	#set the selected ip and port as default from Network.gd
	selected_IP.text = Network.DEFAULT_IP
	#port has to be casted as a string
	port.text = str(Network.DEFAULT_PORT)

func _on_HostButton_pressed() -> void:
	Network.selected_port = int(port.text)
	
	Network.create_server()
	#show the waiting lobby GUI
	create_waiting_room()

func _on_JoinButton_pressed() -> void:
	Network.selected_port = int(port.text)
	Network.selected_IP = selected_IP.text
	
	Network.connect_to_server()
	#show the waiting lobby GUI
	create_waiting_room()

func _on_NameTextBox_text_changed(new_text: String) -> void:
	Saves.save_data["Player_name"] = nameTextBox.text
	Saves.save_game()
	 

#Create the waiting lobby GUI
func create_waiting_room():
	$WaitingRoom.popup_centered()
	#Refresh players on the network
	$WaitingRoom.refresh_players(Network.players)
