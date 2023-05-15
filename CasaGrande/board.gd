extends Node3D

@export
var positions = []

var blocks = [[[]]]
var width = 8
var height = 10
var length = 8

func get_pos(id):
	return get_node(positions[id]).position

func lay_block(x, y, z):
	if(blocks[x][y][z] == null):
		return
	var block = load("res://block.tscn").instantiate()
	get_tree().get_root().add_child(block)
	blocks[x][y][z] = block
	block.new_color = get_node("../GameManager").curr_player.new_color
	
	block.position = Vector3((x + 4) * -1, y, (z + 4))
	
	get_node("../GameManager").curr_player.tokens_left -= 1
	
	if(lay_platform(x,y,z)):
		get_node("../GameManager").curr_player.money += 3
	
func lay_platform(x, y, z):
	if(x >= 3):
		if((blocks[x][y][z] != null) && (blocks[x-3][y][z] != null) && !blocks[x-3][y][z].platform && !blocks[x][y][z].platform):
			blocks[x][y][z].platform = true
			blocks[x-3][y][z].platform = true
			return true
	elif(x <= width - 3):
		if((blocks[x][y][z] != null) && (blocks[x+3][y][z] != null) && !blocks[x+3][y][z].platform && !blocks[x][y][z].platform):
			blocks[x][y][z].platform = true
			blocks[x+3][y][z].platform = true
			return true
	elif(y >= 3):
		if((blocks[x][y][z] != null) && (blocks[x][y-3][z] != null) && !blocks[x][y][z].platform && !blocks[x][y-3][z].platform):
			blocks[x][y][z].platform = true
			blocks[x+3][y][z].platform = true
			return true
	elif(y <= width - 3):
		if((blocks[x][y][z] != null) && (blocks[x][y+3][z] != null) && !blocks[x][y][z].platform && !blocks[x][y+3][z].platform):
			blocks[x][y][z].platform = true
			blocks[x+3][y][z].platform = true
			return true
	return false

func _ready():
	for i in width:
		blocks.append([])
		for j in length:
			blocks[i].append([])
			for k in height:
				blocks[i][j].append(null)
			
