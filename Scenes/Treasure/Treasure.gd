extends Spatial
signal treasure_collected



func _on_Area_area_entered(area):
	print("Treasure collected!")
	# Spawn the treasure particle effect/sfx
	emit_signal("treasure_collected")

