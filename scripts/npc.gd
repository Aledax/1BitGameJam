extends Node2D

@export var npc_name = "npctest"
@export var texts = {"default":[]}

var character_body
var text_interactible

func _ready():
	character_body = $CharacterBody
	character_body.initialize_frames(npc_name)
	text_interactible = $CharacterBody/textInteractible
	text_interactible.set_texts(texts)
