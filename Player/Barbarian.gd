extends Button

var character = preload("res://Player/Character/character_barbarian.tscn").instantiate()

func _on_pressed():
	$"../..".remove_child(character)
	$"../..".add_child.call_deferred(character)
