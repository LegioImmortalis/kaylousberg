extends Control

var child_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_right"):
		pass

func _on_mage_pressed():
	$"..".remove_child(child_scene)
	child_scene = load("res://Player/Character/character_mage.tscn").instantiate()
	#$Player.add_child(child_scene)
	$"..".add_child(child_scene)
	
func _on_jack_pressed():
	$"..".remove_child(child_scene)
	child_scene = load("res://Player/Character/character_jack.tscn").instantiate()
	$"..".add_child(child_scene)

func _on_barbarian_pressed():
	$"..".remove_child(child_scene)
	child_scene = load("res://Player/Character/character_barbarian.tscn").instantiate()
	$"..".add_child(child_scene)

func _on_knight_pressed():
	$"..".remove_child(child_scene)
	child_scene = load("res://Player/Character/character_knight.tscn").instantiate()
	$"..".add_child(child_scene)

func _on_rogue_pressed():
	$"..".remove_child(child_scene)
	child_scene = load("res://Player/Character/character_rogue.tscn").instantiate()
	$"..".add_child(child_scene)

func _on_witch_pressed():
	$"..".remove_child(child_scene)
	child_scene = load("res://Player/Character/character_witch.tscn").instantiate()
	$"..".add_child(child_scene)


func _on_gui_input(event):
	print(event.get_child())
	pass # Replace with function body.
