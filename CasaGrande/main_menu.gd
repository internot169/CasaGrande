extends Control

@export
var col:Color

var curr_text = "PLAYER COUNT"

func _on_play_game_pressed():
	if ($MenuButton.text == "PLAYER COUNT"):
		return
	
	get_node("/root/Globals").player_ct = get_player_count()
	
	var root = get_tree().get_root()
	var menu = self
	root.remove_child(self)
	
	root.add_child(load("res://main.tscn").instantiate())

func get_player_count():
	if ($MenuButton.text == "2 players"):
		return 2
	elif($MenuButton.text == "3 players"):
		return 3
	else:
		return 4

func _process(_delta):
	var popup_menu = $MenuButton.get_popup()
	var focused_item = popup_menu.get_focused_item()
	
	if (focused_item != -1):
		curr_text = popup_menu.get_item_text(focused_item)
		
	$MenuButton.text = curr_text


func _on_button_pressed():
	$Control.visible = false


func _on_tutorial_pressed():
	$Control.visible = true
