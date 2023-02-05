extends Control

##RESOLUTION 
@onready var resolution_dropdown = $Options_Panel/Panel2/Settings_TabContainer/VIDEO/HBoxContainer/Panel/ScrollContainer/MarginContainer/VBoxContainer/Resolution_Dropdown_Button
@onready var fullscreen_dropdown = $Options_Panel/Panel2/Settings_TabContainer/VIDEO/HBoxContainer/Panel/ScrollContainer/MarginContainer/VBoxContainer/Fullscreen_Dropdown_Button

var available_resolutions : Dictionary = {
	"3840 x 2160" : Vector2(3840,2160),
	"2560 x 1440" : Vector2(2560,1440),
	"1920 x 1080" : Vector2(1920,1080),
	"1355 x 768" : Vector2(1355,768),
	"1536 x 864" : Vector2(1536,864)
}

var fullscreen_settings : Dictionary = {
	"Windowed" : float(0),
	"Maximized" : float(2),
	"Fullscreen" : float(3),
	"Exclusive Fullscreen" : float(4)
}


@onready var tool_tip_label = $Options_Panel/Panel2/Settings_TabContainer/VIDEO/HBoxContainer/Panel2/Panel/MarginContainer/Tool_Tip_Label
var tool_tip_label_text : String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	add_items()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_items():
	var current_resolution : Vector2 = DisplayServer.window_get_size()
	var current_window_mode = DisplayServer.window_get_mode()
	
	print_debug(current_resolution)
	print_debug(current_window_mode)
	
	var Resolution_Index = 0
	var Fullscreen_Index = 0
	
	
	for i in available_resolutions:
		resolution_dropdown.add_item(i, Resolution_Index)
		
		if available_resolutions[i] == current_resolution:
			print_debug("resolution is the same")
			resolution_dropdown.select(Resolution_Index)
		Resolution_Index += 1
		
	for f in fullscreen_settings:
		fullscreen_dropdown.add_item(f)

#		if fullscreen_settings[f] == current_window_mode:
#			print_debug("fullscreen is the same")
#			fullscreen_dropdown.select(Fullscreen_Index)
#		Fullscreen_Index += 1
	#resolution_dropdown.add_item(DisplayServer.get_window_list())

	pass

func _on_exit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_options_button_toggled(button_pressed):
	pass # Replace with function body.


#func _on_resolution_dropdown_item_selected(index):
#	#var current_selection = index
#	pass # Replace with function body.
#
#
#func _on_vsync_button_toggled(button_pressed):
#	if button_pressed != false:
#		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
#		print_debug("VSYNC ENABLED")
#	elif button_pressed != true:
#		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
#		print_debug("VSYNC DISABLED")
#	pass # Replace with function body.
#
#
#func _on_fullscreen_button_toggled(button_pressed):
#	if button_pressed != false:
#		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
#		print_debug("FULLSCREEN ENABLED")
#	else:
#		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
#		print_debug("FULLSCREEN DISABLED")
#	pass # Replace with function body.




################RESOLUTION BUTTONS##################
func _on_resolution_dropdown_button_item_selected(index):
	var resolution_size = available_resolutions.get(resolution_dropdown.get_item_text(index))
	DisplayServer.window_set_size(resolution_size)
	print_debug("SELECTED", resolution_size)
	pass # Replace with function body.

func _on_fullscreen_dropdown_button_item_selected(index):
	var fullscreen_size = fullscreen_settings.get(fullscreen_dropdown.get_item_text(index))
	print_debug(int(fullscreen_size))
	DisplayServer.window_set_mode(fullscreen_size)
	pass # Replace with function body.

################AUDIO BUTTONS##################
func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0,linear_to_db(value))
	print_debug(linear_to_db(value))
	pass # Replace with function body.

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(1,linear_to_db(value))
	print_debug(linear_to_db(value))
	pass # Replace with function body.


################INFO HOVER##################
func _on_resolution_dropdown_button_focus_entered():
	tool_tip_label.text = resolution_dropdown.tooltip_text
	pass # Replace with function body.

func _on_resolution_dropdown_button_focus_exited():
	tool_tip_label.text = tool_tip_label_text
	pass # Replace with function body.
