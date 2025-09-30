extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Map.rotation = Vector3(0, deg_to_rad(-45), 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
