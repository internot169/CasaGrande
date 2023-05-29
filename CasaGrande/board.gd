extends Node3D

@export
var positions = []
@export
var bonus_positions = []

var blocks = [[[]]]
var width = 8
var height = 10
var length = 8

func get_pos(id):
	return get_node(positions[id]).position

func get_bonus_pos(id):
	return get_node(bonus_positions[id]).position

func lay_block(x, y, z):
	if(blocks[x][y][z] != null):
		return false
	
	var block = load("res://block.tscn").instantiate()
	
	get_tree().get_root().add_child(block)
	blocks[x][y][z] = block
	
	block.new_color = get_node("../GameManager").curr_player.new_color
	block.player = get_node("../GameManager").curr_player
	block.x = x
	block.y = y
	block.z = z
	
	var z_amt = -88.5
	var pos:Vector3 = Vector3((5 * x), z + 0.61, -88.5 + (6 * y))
	block.position = pos
	
	get_node("../GameManager").curr_player.tokens_left -= 1
	
	if(lay_platform(x,y,z)):
		get_node("../GameManager").curr_player.money += 3
	
	return true

func lay_platform(x, y, z):
	var will_lay = false
	var rot
	
	if(x >= 3):
		if(compare(blocks[x][y][z], blocks[x-3][y][z])):
			will_lay = true
			rot = -(PI / 2)
	elif(x <= width - 3):
		if(compare(blocks[x][y][z], blocks[x+3][y][z])):
			will_lay = true
			rot = (PI / 2)
	elif(y >= 3):
		if(compare(blocks[x][y][z], blocks[x][y-3][z])):
			will_lay = true
			rot = (PI)
	elif(y <= width - 3):
		if(compare(blocks[x][y][z], blocks[x][y+3][z])):
			will_lay = true
			rot = (0)
	
	if (will_lay):
		print("laying")
		var platform = load("res://platform.tscn").instantiate()
		get_tree().get_root().add_child(platform)
	
		platform.position = Vector3(blocks[x][y][z].position.x + 2, 4.5, blocks[x][y][z].position.z + 3)
		platform.transform.basis = platform.transform.basis.rotated(Vector3(0, 1, 0), rot)
	
	return will_lay

func platform(x_1, y_1, z_1, x_2, y_2, z_2):
	print("got it!")

func compare(x, y):
	if(x == null || y == null):
		return false
	elif (!x.platform && !y.platform && (x.player == y.player)):
		x.platform = true
		y.platform = true
		return true
	return false

func _ready():
	for i in width:
		blocks.append([])
		for j in length:
			blocks[i].append([])
			for k in height:
				blocks[i][j].append(null)
