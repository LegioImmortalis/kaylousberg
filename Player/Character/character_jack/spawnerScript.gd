extends Button

var source = preload("./character.tscn")

func _on_pressed():
	$"../.."._add_character(source)
