extends Spatial

var mesh:MeshInstance
var mat:SpatialMaterial
var tex:Texture
var viewport:Viewport
var camParent:Spatial
var camera:Camera


func _ready():
	mesh = $MeshInstance
	mat = $MeshInstance.get_surface_material(0)
	viewport = $Viewport
	camera = $Viewport/Camera
	mat.albedo_texture = viewport.get_texture()
	mat.emission_texture = viewport.get_texture()
	viewport.size = mesh.mesh.size * 1024


func _process(_delta):
	# These parts shamelessly lifted from https://github.com/JFonS/godot-mirror-example
	var plane_origin = $MirrorPos.global_transform.origin
	var plane_normal = $MirrorPos.global_transform.basis.z.normalized()
	var reflection_plane = Plane(plane_normal, plane_origin.dot(plane_normal))
	var reflection_transform = $MirrorPos.global_transform
	
	var head_pos = VRUser.get_head().global_transform.origin
	var projected_pos = reflection_plane.project(head_pos)
	var mirrored_pos = head_pos + (projected_pos - head_pos) * 2.0
	
	var trans = Transform(Basis(), mirrored_pos)
	trans = trans.looking_at(projected_pos, reflection_transform.basis.y.normalized())
	camera.global_transform = trans
	
	var offset = reflection_transform.xform_inv(head_pos)
	offset = Vector2(offset.x, offset.y)
	
	camera.set_frustum(mesh.mesh.size.x, -offset, projected_pos.distance_to(head_pos), 100.0)
	
	#var head_vec = (global_transform.origin - VRUser.get_head().global_transform.origin).normalized()
	#var head_vec = -VRUser.get_head().global_transform.basis.z
	#var mirror_normal = transform.basis.y
	#var reflect_vec = head_vec.reflect(mirror_normal)
	#camera.look_at(camera.global_transform.origin + reflect_vec, global_transform.basis.y)
	#camera.set_frustum(mesh.size, )
