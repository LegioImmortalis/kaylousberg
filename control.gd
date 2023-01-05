extends Control

var child_scene

var character = Dictionary()
#character = preload("res://Player/Character/character_witch.tscn").instantiate()
#character["rogue"] = preload("res://Player/Character/character_rogue.tscn").instantiate()
#character["knight"] = preload("res://Player/Character/character_knight.tscn").instantiate()
#character["barbarian"] = preload("res://Player/Character/character_barbarian.tscn").instantiate()
#character["jack"] = preload("res://Player/Character/character_jack.tscn").instantiate()
#character["mage"] = preload("res://Player/Character/character_mage.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	print($"..".get_child_count())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if Input.is_action_pressed("ui_right"):
#		pass

#func _on_witch_pressed():
#	$"..".remove_child(child_scene)
#	$"..".add_child.call_deferred(character["witch"])



#func _on_gui_input(event):
#	Input.action_press($Mage)
#	pass # Replace with function body.
