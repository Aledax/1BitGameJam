extends Node2D

@export var npc_name = "npctest"

var character_body

func _ready():
	character_body = $CharacterBody
	character_body.initialize_frames(npc_name)
