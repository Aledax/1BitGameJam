extends Node2D

@export var char_name = ""
var texts = {"default":[]}

var area_2d

func _ready():
	area_2d = $Area2D

func set_texts(given_texts):
	area_2d.set_texts(given_texts)

func set_dialogue(dialogue_key):
	area_2d.set_dialogue(dialogue_key)
