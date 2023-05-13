extends Control


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
