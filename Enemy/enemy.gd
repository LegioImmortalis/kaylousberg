extends Node
var Archer 	= preload ("res://Enemy/Characters/character_skeleton_archer.tscn")
var Mage 	= preload ("res://Enemy/Characters/character_skeleton_mage.tscn")
var Minion 	= preload ("res://Enemy/Characters/character_skeleton_minion.tscn")
var Warrior = preload ("res://Enemy/Characters/character_skeleton_warrior.tscn")
var Enemy   = [Archer,Mage,Minion,Warrior]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
func _on_EnemyTimer_timeout():
	var e = Enemy[randi_range(0,3)].instance()
	e.position = Vector2(-650.747, 373)
	add_child(e)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
