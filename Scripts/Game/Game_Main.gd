extends Node3D

var debug_overlay = load("res://Scenes/Debug_Overlay/Debug_Console_Overlay.tscn")
var debug_overlay_instance = debug_overlay.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Add out Debug Overlay to the Main Scene
	add_child(debug_overlay_instance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
