extends ARVROrigin

export(float) var move_speed = 1.0
var forward_vec:Vector3
var right_vec:Vector3
onready var player_body := $PlayerBody
onready var player_collider := $PlayerBody/CollisionShape

var last_head_pos:Vector3


func _ready():
	player_body = $PlayerBody
	


func get_head() -> ARVRCamera:
	return $Head as ARVRCamera


func _physics_process(_delta):
	"""
	player_collider.global_transform.origin = Vector3(
		$Head.global_transform.origin.x,
		player_collider.global_transform.origin.y,
		$Head.global_transform.origin.z
	)
	"""
	move_player($ActionMove.get_analog())


func move_player(axis:Vector2):
	forward_vec = (-$Head.global_transform.basis.z * Vector3(1, 0, 1)).normalized()
	right_vec = ($Head.global_transform.basis.x.normalized() * Vector3(1, 0, 1)).normalized()
	var move_vec = forward_vec * axis.y + right_vec * axis.x
	
	var last_body_pos = player_body.global_transform.origin

	player_body.move_and_slide(move_vec * move_speed, Vector3.UP)
	
	global_transform.origin += player_body.global_transform.origin - last_body_pos
	
	player_body.global_transform.origin = global_transform.origin


func get_compass():
	return $Compass
