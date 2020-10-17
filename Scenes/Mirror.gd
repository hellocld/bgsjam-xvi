extends Spatial


var mat:SpatialMaterial
var tex:Texture
var viewport:Viewport
var camParent:Spatial
var camera:Camera


func _ready():
	mat = $MeshInstance.get_surface_material(0)
	viewport = $Viewport
	camParent = $Viewport/CamParent
	camera = $Viewport/CamParent/Camera


func _process(_delta):
	camParent.global_transform = global_transform
	tex = viewport.get_texture()
	mat.albedo_texture = tex
