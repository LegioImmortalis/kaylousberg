extends SubViewport

# Get the Viewport node
var viewport = get_node("Viewport")

# Connect to the input_event signal
$".".connect("input_event", self, "_on_input_event")

# Handle mouse movement in the input_event handler
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion:
		# Calculate the camera's new rotation based on the mouse movement
		var rot_x = camera.rotation.x - event.relative.y
		var rot_y = camera.rotation.y - event.relative.x
		camera.rotation = Vector3(rot_x, rot_y, 0)
