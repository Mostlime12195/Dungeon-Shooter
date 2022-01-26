extends Button

export (PackedScene) var sendTo

func _on_Play_button_up():
	get_tree().change_scene_to(sendTo)
