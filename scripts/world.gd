extends Node2D

const ocean_rise_event = "_ocean_rise_event"
const npc_move_event = "_npc_move_event"
const npc_jump_event = "_npc_jump_event"
const npc_switch_dialogue_event = "_npc_switch_dialogue_event"

func _ready():
	schedule_event("Ocean", ocean_rise_event, 1, [8])
	
	schedule_event("NPCs", npc_move_event, 1, ["Npctest", -50])
	schedule_event("NPCs", npc_jump_event, 2, ["Npctest", 0.1])
	schedule_event("NPCs", npc_switch_dialogue_event, 5, ["Npctest", "newdialoguetest"])

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
