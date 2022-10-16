extends Control


func _ready() -> void:
	pass


func _on_HostButton_pressed() -> void:
	Network.create_server()

func _on_JoinButton_pressed() -> void:
	Network.connect_to_server()
