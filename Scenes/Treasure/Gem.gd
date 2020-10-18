extends MeshInstance


func _process(_delta):
	transform.origin.y = sin($Timer.time_left)*0.1
	rotate_y(_delta)
