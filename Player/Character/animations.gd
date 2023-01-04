extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Get the Input singleton

var input = get_node("/root/input")

# Update the character's head rotation in the _process function
func _process(delta):
	# Calculate the character's new head rotation based on the mouse movement
	var rot_x = $Skeleton3D/Head.rotation.x - input.get_mouse_speed().y
	var rot_y = $Skeleton3D/Head.rotation.y - input.get_mouse_speed().x
	$Skeleton3D/Head.rotation = Vector3(rot_x, rot_y, 0)

