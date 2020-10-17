extends Node

var config = null

func _ready():
	config = preload("res://addons/godot-openvr/OpenVRConfig.gdns")
	config = config.new()
	config.default_action_set = "/actions/game"
	
	var vr = ARVRServer.find_interface("OpenVR")
	if vr and vr.initialize():
		get_viewport().arvr = true
		get_viewport().keep_3d_linear = true
		OS.vsync_enabled = false
		Engine.iterations_per_second = 90
