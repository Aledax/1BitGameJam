extends Control

var world

var kousa_saved : bool
var alder_saved : bool
var sorrel_saved : bool 
var wattle_saved : bool 

var text 
var done_showing = false

var saved_state 

# Called when the node enters the scene tree for the first time.
func _ready():
	saved_state = get_node("/root/SavedState")
	
	kousa_saved = saved_state.kousa_saved
	alder_saved = saved_state.alder_saved
	sorrel_saved = saved_state.sorrel_saved
	wattle_saved = saved_state.wattle_saved
	var children = get_children()
	for child in children:
		child.hide()
	$Sprite2D.show()
	show_results()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact") && done_showing:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func show_results():
	await get_tree().create_timer(0.5).timeout
	$Label.show()
	await get_tree().create_timer(1.0).timeout
	if kousa_saved:
		$Kousa.show()
	await get_tree().create_timer(0.5).timeout
	if wattle_saved:
		$Wattle.show()
	await get_tree().create_timer(0.5).timeout
	if alder_saved:
		$Alder.show()
	await get_tree().create_timer(0.5).timeout
	if sorrel_saved:
		$Sorrel.show()
	await get_tree().create_timer(0.5).timeout
	if !(kousa_saved || wattle_saved || alder_saved || sorrel_saved):
		$Nobody.show()
	await get_tree().create_timer(0.5).timeout
	$E.show()
	done_showing = true
	
