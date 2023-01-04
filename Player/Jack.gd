extends Button

var source = preload("res://Player/Character/character_jack.tscn")

func _on_pressed():
	var character = source.instantiate()
	$"../..".remove_child(character)
	$"../..".add_child.call_deferred(character)
