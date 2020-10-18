extends Spatial


var _target

func set_target(t:Spatial):
	_target = t


func _process(_delta):
	if _target:
		look_at(_target.global_transform.origin, Vector3.UP)
