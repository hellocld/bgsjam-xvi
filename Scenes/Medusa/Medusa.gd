extends KinematicBody

export(NodePath) var navmesh
export(float) var move_speed:float

var path:PoolVector3Array
var target_index:int
var target_pos:Vector3
onready var debug_target:= $DebugTarget

func _ready():
	navmesh = get_node(navmesh) as Navigation


func _physics_process(delta):
	if !navmesh || !$WaitTimer.is_stopped() || path.size() == 0:
		return
	debug_target.global_transform.origin = path[target_index]
	if global_transform.origin.distance_to(path[target_index]) <= 0.1:
		print("Target reached")
		target_index += 1
		if target_index == path.size():
			$WaitTimer.start()
			return
	var move_dir = (path[target_index] - global_transform.origin).normalized()
	move_and_slide(move_dir * move_speed)


func _get_new_path():
	target_pos = navmesh.get_closest_point(Vector3(rand_range(-30, 30), 0, rand_range(-30, 30)))
	path = navmesh.get_simple_path(global_transform.origin, target_pos)
	target_index = 0


func _on_WaitTimer_timeout():
	_get_new_path()
