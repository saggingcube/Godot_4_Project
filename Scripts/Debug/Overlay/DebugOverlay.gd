extends CanvasLayer

@onready var console_label = $Debug_Background/HSplitContainer/Scroll_Container/Console_Label
@onready var game_stat_label = $Debug_Background/HSplitContainer/Game_Stat_Label


var stats = []
var valid_commands = [[self, "_clear_console"], []]

# Called when the node enters the scene tree for the first time.
func _ready():
	for n in get_children():
		n.visible = not n.visible
	
	console_label.text = ""
	pass

func _input(event):
	if event.is_action_pressed("p_console"):
		for  n in get_children():
			n.visible = not n.visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var label_text : String = ""
	
	var fps = Engine.get_frames_per_second()
	label_text += str("FPS: ", fps)
	label_text += "\n"
	
	var memory_usage = OS.get_static_memory_usage()
	label_text += str("Static Memory: ", String.humanize_size(memory_usage))
	label_text += "\n"
	
	game_stat_label.text = label_text
	
	pass

func _add_stat(stat_name, stat_object, stat_ref, is_method):
	stats.append([stat_name, stat_object, stat_ref, is_method])

func _print_debug_log(debug_log):
	console_label.text += str(debug_log) + "\n"
	print(debug_log)

func _clear_console():
	console_label.text = ""

#########SIGNALS##############

func _on_console_input_text_submitted(new_text):
	#Process Commands should go here.... 
	_print_debug_log(new_text)
	pass # Replace with function body.
