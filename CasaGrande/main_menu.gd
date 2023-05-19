extends Node3D

func _on_switch_to_level_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
