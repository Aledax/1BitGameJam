extends Node2D

const ocean_rise_event = "_ocean_rise_event"
const npc_move_event = "_npc_move_event"
const npc_jump_event = "_npc_jump_event"
const npc_switch_dialogue_event = "_npc_switch_dialogue_event"

const kousa_beach_start = 45
const wattle_restaurant_start = 0
const sorrel_lookout_start = 0

func _ready():
	schedule_event("Ocean", ocean_rise_event, 120, [5])
	
	# Kousa
	schedule_event("NPCs", npc_move_event, kousa_beach_start + 0, ["kousa", -340])
	schedule_event("NPCs", npc_move_event, kousa_beach_start + 9, ["kousa", -290])
	schedule_event("NPCs", npc_move_event, kousa_beach_start + 10, ["kousa", -370])
	schedule_event("NPCs", npc_move_event, kousa_beach_start + 12, ["kousa", 0])
	schedule_event("NPCs", npc_move_event, kousa_beach_start + 17, ["kousa", -160])
	schedule_event("NPCs", npc_move_event, kousa_beach_start + 19, ["kousa", 400])
	schedule_event("NPCs", npc_jump_event, kousa_beach_start + 22.2, ["kousa", 0.1])

	# Wattle
	schedule_event("NPCs", npc_move_event, wattle_restaurant_start + 0, ["wattle", 10])
	schedule_sorrel_to_fountain(wattle_restaurant_start + 4, "wattle")
	schedule_event("NPCs", npc_move_event, wattle_restaurant_start + 28, ["wattle", 470])
	schedule_event("NPCs", npc_jump_event, wattle_restaurant_start + 31, ["wattle", 0.2])

	# Sorrel
	# schedule_event("NPCs", npc_move_event, sorrel_lookout_start + 0, ["sorrel", 250])
	# schedule_restaurant_to_elevator(sorrel_lookout_start + 5, "sorrel")
	schedule_elevator_to_workshop(5, "sorrel")
	schedule_workshop_to_launchpad(9, "sorrel")

func schedule_sorrel_to_fountain(time, npc_name): # Assumes x = 10, outside Sorrel's house, from the right
	schedule_event("NPCs", npc_jump_event, time + 0, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 0, [npc_name, -150])
	schedule_event("NPCs", npc_move_event, time + 4, [npc_name, -50])
	schedule_event("NPCs", npc_jump_event, time + 4, [npc_name, 0.1])
	schedule_event("NPCs", npc_move_event, time + 6, [npc_name, 25])
	schedule_event("NPCs", npc_jump_event, time + 6.1, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 7, [npc_name, -30])
	schedule_event("NPCs", npc_jump_event, time + 7.1, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 8, [npc_name, -5])
	schedule_event("NPCs", npc_jump_event, time + 8.1, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 9, [npc_name, -40])
	schedule_event("NPCs", npc_jump_event, time + 9.1, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 10, [npc_name, -370])
	schedule_event("NPCs", npc_jump_event, time + 10.1, [npc_name, 0.1])
	schedule_event("NPCs", npc_jump_event, time + 10.4, [npc_name, 0.15])
	schedule_event("NPCs", npc_jump_event, time + 12.2, [npc_name, 0.1])
	schedule_event("NPCs", npc_jump_event, time + 13.6, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 14.5, [npc_name, -270])
	schedule_event("NPCs", npc_jump_event, time + 14.5, [npc_name, 0.1])
	schedule_event("NPCs", npc_move_event, time + 17, [npc_name, -350])
	schedule_event("NPCs", npc_jump_event, time + 17.2, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 18, [npc_name, -150])
	schedule_event("NPCs", npc_jump_event, time + 18, [npc_name, 0.1])
	schedule_event("NPCs", npc_jump_event, time + 18.9, [npc_name, 0.2])

func schedule_restaurant_to_elevator(time, npc_name): # Assumes x = 250, outside restaurant, from the right
	schedule_event("NPCs", npc_move_event, time + 0, [npc_name, 120])
	schedule_event("NPCs", npc_jump_event, time + 0, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 0.5, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 1, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 2, [npc_name, 160])
	schedule_event("NPCs", npc_jump_event, time + 2.1, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 3, [npc_name, 80])
	schedule_event("NPCs", npc_jump_event, time + 3.2, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 4, [npc_name, 160])
	schedule_event("NPCs", npc_jump_event, time + 4.1, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 4.6, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 5.1, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 5.6, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 6, [npc_name, 20])
	schedule_event("NPCs", npc_jump_event, time + 8, [npc_name, 0.3])
	schedule_event("NPCs", npc_move_event, time + 8.3, [npc_name, 30])
	schedule_event("NPCs", npc_jump_event, time + 9, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 9, [npc_name, -10])
	schedule_event("NPCs", npc_move_event, time + 10, [npc_name, 30])
	schedule_event("NPCs", npc_jump_event, time + 10.1, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 11, [npc_name, -30])
	schedule_event("NPCs", npc_jump_event, time + 11.1, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 11.5, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 12.5, [npc_name, 30])
	schedule_event("NPCs", npc_jump_event, time + 12.5, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 12.9, [npc_name, 0.1])
	schedule_event("NPCs", npc_move_event, time + 14, [npc_name, -30])
	schedule_event("NPCs", npc_jump_event, time + 14.1, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 14.5, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 15.5, [npc_name, 26])
	schedule_event("NPCs", npc_jump_event, time + 15.5, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 16, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 17.5, [npc_name, -30])
	schedule_event("NPCs", npc_jump_event, time + 17.6, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 18.5, [npc_name, 48])
	schedule_event("NPCs", npc_jump_event, time + 18.3, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 18.9, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 20, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 20.5, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 22, [npc_name, -30])
	schedule_event("NPCs", npc_jump_event, time + 21.8, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 22.3, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 23, [npc_name, 30])
	schedule_event("NPCs", npc_jump_event, time + 23.2, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 23.7, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 24.5, [npc_name, 0])
	schedule_event("NPCs", npc_jump_event, time + 24.5, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 25, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 25.5, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 26, [npc_name, 0.2])

func schedule_elevator_to_lookout(time, npc_name): # Assumes x = 0, at elevator top
	schedule_event("NPCs", npc_move_event, time + 0, [npc_name, 900])
	schedule_event("NPCs", npc_jump_event, time + 0, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 4.3, [npc_name, 0.1])
	schedule_event("NPCs", npc_jump_event, time + 4.75, [npc_name, 0.1])
	schedule_event("NPCs", npc_jump_event, time + 5.2, [npc_name, 0.1])
	schedule_event("NPCs", npc_jump_event, time + 5.65, [npc_name, 0.1])
	schedule_event("NPCs", npc_jump_event, time + 7.3, [npc_name, 0.1])
	schedule_event("NPCs", npc_jump_event, time + 7.75, [npc_name, 0.1])

func schedule_elevator_to_workshop(time, npc_name): # Assumes x = 0, at elevator top
	schedule_event("NPCs", npc_move_event, time + 0, [npc_name, -270])
	schedule_event("NPCs", npc_jump_event, time + 0, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 1.5, [npc_name, 0.1])
	schedule_event("NPCs", npc_move_event, time + 3.5, [npc_name, -250])

func schedule_workshop_to_launchpad(time, npc_name): # Assumes x = -250, ouside workshop, from the right
	schedule_event("NPCs", npc_move_event, time + 0, [npc_name, 64])
	schedule_event("NPCs", npc_jump_event, time + 0, [npc_name, 0.1])
	schedule_event("NPCs", npc_jump_event, time + 2.4, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 3.2, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 4, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 4.5, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 5, [npc_name, 0])
	schedule_event("NPCs", npc_jump_event, time + 5, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 5.5, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 6, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 6.5, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 7, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 7.5, [npc_name, 0.2])
	schedule_event("NPCs", npc_jump_event, time + 8, [npc_name, 0.2])
	schedule_event("NPCs", npc_move_event, time + 8, [npc_name, 48])

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
