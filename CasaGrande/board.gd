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
	blocks[x][y][z] = load("res:block.gd")
	get_node(blocks[x][y][z]).player = get_node("../GameManager").curr_player
	
func lay_platform(x, y, z):
	get_node("../GameManager").curr_player.money += 3
	get_node("../GameManager").curr_player.tokens_left -= 1

func _ready():
	for i in width:
		blocks.append([])
		for j in length:
			blocks[i].append([])
			for k in height:
				blocks[i][j].append(null)
			
