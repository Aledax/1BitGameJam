extends Node2D

signal test_signal
signal test_signal2

# Called when the node enters the scene tree for the first time.
func _ready():
	set_event_to_occur(10, test_signal)
	set_event_to_occur(5, test_signal2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_event_to_occur(secs, given_signal):
	print("signal: ", given_signal, " will be called in ", secs, " seconds")
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true 
	timer.wait_time = secs
	timer.timeout.connect(func(): # lambda functon, you can do whatever you want to occur once the timer runs out here
		given_signal.emit()
		print(given_signal, " emitted!"))
	timer.start() # emit "timeout" signal in 30 secs

