extends Control

var textbox_open = false
var slider_value = 0

func display_dice(num):
	var dice = $Dice
	
	var img = Image.new()
	img.load("res://dice" + str(num) + ".jpg")
	
	var tex = ImageTexture.create_from_image(img)
	dice.texture = tex

func display_player(p: Player, text):
	var label = $RichTextLabel
	
	label.text = text
	label.text += "\nCoins: " + str(p.money)
	label.text += "\nTokens: " + str(p.tokens_left)
	label.text += "\nBoard Position: " + str(p.board_position)


func _on_button_pressed():
	get_node("..").switch_turn()

func _ready():
	$Movemore/TextEdit.visible = false

func _on_movemore_pressed():
	if(textbox_open):
		var amount = int($Movemore/TextEdit.text)
		get_node("..").move_token(amount)
		$Movemore/TextEdit.visible = false
	else:
		$Movemore/TextEdit.visible = true
		$Movemore/TextEdit.text = ""
	textbox_open = !textbox_open


func _on_h_slider_value_changed(value):
	get_node("/root/Main/CameraHolder").input = value
