extends Node2D

@export var npc_name = "npctest"

var character_body

var target_x

func _ready():
	character_body = $CharacterBody
	character_body.initialize_frames(npc_name)

func _physics_process(_delta):
	if (position.x < target_x and character_body.horizontal_movement == -1) or (position.x > target_x and character_body.horizontal_movement == 1):
		character_body.horizontal_movement = 0

func set_target_x(target_x):
	self.target_x = target_x
	if (position.x > target_x):
		character_body.horizontal_movement = -1
	else:
		character_body.horizontal_movement = 1
