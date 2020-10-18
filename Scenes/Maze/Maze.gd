extends Spatial

var score:int
onready var nav:= $Navigation
onready var treasure:= preload("res://Scenes/Treasure/Treasure.tscn")
var _treasure


func _ready():
	_treasure = treasure.instance()
	add_child(_treasure)
	_set_new_treasure()
	_treasure.connect("treasure_collected", self, "_treasure_collected")


func _treasure_collected():
	score += 1
	_set_new_treasure()


func _set_new_treasure():
	var new_pos = Vector3(rand_range(-20, 20), 0, rand_range(-20, 20))
	new_pos = nav.get_closest_point(new_pos)
	_treasure.transform.origin = new_pos
	VRUser.get_compass().set_target(_treasure)
