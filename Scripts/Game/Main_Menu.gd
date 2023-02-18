extends Control

##RESOLUTION 
@onready var resolution_dropdown = $Option_MarginContainer/Options_Panel/Panel2/Settings_TabContainer/VIDEO/HBoxContainer/Panel/ScrollContainer/MarginContainer/VBoxContainer/Resolution_Dropdown_Button
@onready var fullscreen_dropdown = $Option_MarginContainer/Options_Panel/Panel2/Settings_TabContainer/VIDEO/HBoxContainer/Panel/ScrollContainer/MarginContainer/VBoxContainer/Fullscreen_Dropdown_Button
@onready var anti_aliasing_dropdown = $"Option_MarginContainer/Options_Panel/Panel2/Settings_TabContainer/VIDEO/HBoxContainer/Panel/ScrollContainer/MarginContainer/VBoxContainer/Anti Aliasing_Dropdown_Button"
@onready var TAA_button = $Option_MarginContainer/Options_Panel/Panel2/Settings_TabContainer/VIDEO/HBoxContainer/Panel/ScrollContainer/MarginContainer/VBoxContainer/TAA_CheckButton

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

@onready var tool_tip_label = $Option_MarginContainer/Options_Panel/Panel2/Settings_TabContainer/VIDEO/HBoxContainer/Panel2/Panel/MarginContainer/Tool_Tip_Label
var tool_tip_label_text : String = ""


#############MENU OPTIONS##############

# Starting importing a state machine to keep "tabs" on which menu is open. Should be a much cleaner way
# to switch between menu's. Should allow for transition effects between states as well? Either way a
# fade screen effect is needed. 

enum MenuStates {
	main_menu_active,
	character_menu_active,
	credits_menu_active,
	options_menu_active,	
}

@export var back_button_group : ButtonGroup

@onready var start_menu_container = $Start_Menu_MarginContainer
@onready var options_menu_container = $Option_MarginContainer

@onready var main_menu_state = MenuStates.main_menu_active

# Called when the node enters the scene tree for the first time.
func _ready():	
	
	add_resolution_items()
	
	#Locate the back button group
	for b in back_button_group.get_buttons():
		b.pressed.connect(_on_back_button_pressed)
		
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Add resolutions to dropdown items. Yanked. 
func add_resolution_items():
	var current_resolution : Vector2 = DisplayServer.window_get_size()
	var current_window_mode = DisplayServer.window_get_mode()


	print_debug(current_resolution)
	print_debug(current_window_mode)
	print_debug("START TAA: ", get_viewport().use_taa)
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

		if fullscreen_settings[f] == current_window_mode:
			print_debug("fullscreen is the same")
			fullscreen_dropdown.select(Fullscreen_Index)
		Fullscreen_Index += 1
	#resolution_dropdown.add_item(DisplayServer.get_window_list())
	
	TAA_button.button_pressed = get_viewport().use_taa
	pass

##################MAIN MENU#########################

# Main Menu Exit button
func _on_exit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.

# Main Menu Option button
func _on_options_button_pressed():
	print_debug("OPTIONS MENU TOGGLED")
	start_menu_container.visible = not start_menu_container.visible
	options_menu_container.visible = true
	pass # Replace with function body.

#Main Menu Play button
func _on_play_button_pressed():
	print_debug("On Play Pressed")
	pass # Replace with function body.


################OPTION MENU#########################

###VIDEO TAB###

#Option Menu Back Button
func _on_back_button_pressed():
	print_debug("BACK BUTTONS PRESSED")
	options_menu_container.visible = not options_menu_container.visible
	start_menu_container.visible = true
	pass

# Options Menu show and set available resolutions to drop down
func _on_resolution_dropdown_button_item_selected(index):
	var resolution_size = available_resolutions.get(resolution_dropdown.get_item_text(index))
	DisplayServer.window_set_size(resolution_size)
	print_debug("SELECTED", resolution_size)
	pass # Replace with function body.

# Options Menu show and set fullscreen options
func _on_fullscreen_dropdown_button_item_selected(index):
	var fullscreen_size = fullscreen_settings.get(fullscreen_dropdown.get_item_text(index))
	print_debug(int(fullscreen_size))
	DisplayServer.window_set_mode(fullscreen_size)
	pass # Replace with function body.

# Options Menu Enable TAA
func _on_taa_check_button_toggled(button_pressed):
	get_viewport().use_taa = button_pressed
	print_debug("PRESSED TAA: ", get_viewport().use_taa)
	pass # Replace with function body.

###AUDIO TAB###

# Adjust master volume in the main mixer
func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0,linear_to_db(value))
	print_debug(linear_to_db(value))
	pass # Replace with function body.

# Adjust the music volume in the main mixer
func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(1,linear_to_db(value))
	print_debug(linear_to_db(value))
	pass # Replace with function body.

# Adjust the SFX volume in the main mixer.
func _on_vfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(2,linear_to_db(value))
	pass # Replace with function body.


#HACKY WORKAROUND FOR INFO HOVER
################INFO HOVER##################
func _on_resolution_dropdown_button_focus_entered():
	tool_tip_label.text = resolution_dropdown.tooltip_text
	pass # Replace with function body.

func _on_resolution_dropdown_button_focus_exited():
	tool_tip_label.text = tool_tip_label_text
	pass # Replace with function body.









