extends Node2D

@export var char_name = ""
var texts = {"default":[]}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_texts(given_texts):
	$Area2D.set_texts(given_texts)
