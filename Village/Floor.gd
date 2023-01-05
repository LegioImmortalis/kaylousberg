extends Node3D
var floorSource = preload("res://Village/floor_decoration_tiles_large.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#for i in 10:
	#	for j in 10:
	#		floor.translate(Vector3(-50+i*4,0,-45+j*4))
			#floor.rotate(Vector3.UP,deg_to_rad(randi_range(0,3)*90))
	#		add_child.call_deferred(floor)
#	for i in $".".get_children():
#		i.rotate(Vector3.UP,deg_to_rad(randi_range(0,3)*90))
	for i in 20:
		for j in 20:
			var floorInstance = floorSource.instantiate()
			floorInstance.translate(Vector3(-50+i*3.5,-0.1,-50+j*4))
			add_child.call_deferred(floorInstance)
