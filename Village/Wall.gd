extends Node3D
var	wall = preload("res://Village/wall_single.tscn")
var	corner = preload("res://Village/wall_corner.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var segmentPosition = Vector3(-10,0,-20)
	segmentPosition = wallSegment(5,"x",segmentPosition)
	print(segmentPosition)
	wallCorner(0,segmentPosition)
	segmentPosition = wallSegment(3,"z",segmentPosition+Vector3(-2,0,6))
	#wallCorner(0,segmentPosition)
	#wallCorner(-90,segmentPosition)
	#for i in 15:
	#	var wallInstance = wall.instantiate()
	#	wallInstance.translate(Vector3(maxi,0,-50+i))
	#	add_child.call_deferred(wallInstance)
# Called every frame. 'delta' is the elapsed time since the previous frame.
		
func wallSegment(length,rota,segmentPosition):
	var vectora=Vector3(4,0,0)
	var r=0
	if rota == "z":
		vectora=Vector3(0,0,4)
		r=-90
	for i in length:
		var wallInstance = wall.instantiate()
		wallInstance.translate(segmentPosition+i*vectora)
		wallInstance.rotate(Vector3.UP,deg_to_rad(r))
		add_child.call_deferred(wallInstance)
	return segmentPosition+(length+1)*vectora
	
func wallCorner(rota,segmentPosition):
	var cornerInstance = corner.instantiate()
	cornerInstance.translate(segmentPosition)
	cornerInstance.rotate(Vector3.UP,deg_to_rad(rota))
	add_child.call_deferred(cornerInstance)
	
#func wallCorner(rotation,segmentPosition):
#	print(segmentPosition)
#	var wallInstance = corner.instantiate()
#	wallInstance.rotate(Vector3.UP,deg_to_rad(rotation))
#	wallInstance.translate(segmentPosition)
#	add_child.call_deferred(wallInstance)
		
#func _process(delta):
#	pass
