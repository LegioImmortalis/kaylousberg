extends Button

var charactersource = preload("res://Player/Character/character_witch.tscn")

func _on_pressed():
	var character = charactersource.instantiate()
	$"../..".remove_child(character)
	$"../..".add_child.call_deferred(character)
