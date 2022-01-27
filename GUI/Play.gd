extends Button


export (PackedScene) var sendTo #Creates a "sendTo" variable that stores a scene

#Once the button is released, it will send the player to the scene inside the "sendTo" variable
func _on_Play_button_up():
	get_tree().change_scene_to(sendTo)
