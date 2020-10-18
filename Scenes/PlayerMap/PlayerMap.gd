extends Spatial


func _ready():
	$MapMesh.get_surface_material(0).albedo_texture = $Viewport.get_texture()


func _process(_delta):
	$Viewport/Camera.global_transform.origin = VRUser.global_transform.origin + Vector3(0, 5, 0)
