extends Node2D

const ocean_rise_event = "_ocean_rise_event"
const npc_move_event = "_npc_move_event"
const npc_jump_event = "_npc_jump_event"
const npc_switch_dialogue_event = "_npc_switch_dialogue_event"

const kousa_beach_start = 45

func _ready():
	schedule_event("Ocean", ocean_rise_event, 120, [5])
	
	schedule_event("NPCs", npc_move_event, 1, ["sorrel", -50])
	schedule_event("NPCs", npc_jump_event, 2, ["sorrel", 0.1])
	schedule_event("NPCs", npc_switch_dialogue_event, 5, ["sorrel", "test"])
	
	# Kousa
	schedule_event("NPCs", npc_move_event, kousa_beach_start + 0, ["kousa", -340])
	schedule_event("NPCs", npc_move_event, kousa_beach_start + 9, ["kousa", -290])
	schedule_event("NPCs", npc_move_event, kousa_beach_start + 10, ["kousa", -370])
	schedule_event("NPCs", npc_move_event, kousa_beach_start + 12, ["kousa", 0])
	schedule_event("NPCs", npc_move_event, kousa_beach_start + 17, ["kousa", -160])
	schedule_event("NPCs", npc_move_event, kousa_beach_start + 19, ["kousa", 400])
	schedule_event("NPCs", npc_jump_event, kousa_beach_start + 22.2, ["kousa", 0.1])

func schedule_event(event_group, event_name, time_start, event_args):
	print("Event: ", event_name, " will be called in ", time_start, " seconds")
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true 
	timer.wait_time = time_start
	timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	timer.timeout.connect(func():
		var call_group_args = [event_group, event_name] + event_args
		get_tree().callv("call_group", call_group_args)
		print(event_name, " activated!"))
	timer.start()


func _on_require_item_correct_item_brought():
	pass # Replace with function body.
