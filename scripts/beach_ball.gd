extends RigidBody3D

@export var rolling_force = 20
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var old_camera_pos = $CameraPoint.global_transform.origin
	var ball_pos = global_transform.origin
	var new_camera_pos = lerp(old_camera_pos, ball_pos, 0.1)
	$CameraPoint.global_transform.origin = new_camera_pos
	
	if GameManager.is_game_start == true:
		if Input.is_action_pressed("forward"):
			angular_velocity.x -= rolling_force * delta
		if Input.is_action_pressed("back"):
			angular_velocity.x += rolling_force * delta
		if Input.is_action_pressed("left"):
			angular_velocity.z += rolling_force * delta
		if Input.is_action_pressed("right"):
			angular_velocity.z -= rolling_force * delta
	
		raycast_check()

func raycast_check():
	$RayCast3D.global_position = global_position
	$RayCast3D.force_raycast_update()
	if $RayCast3D.is_colliding() == false and $RayCastTimer.is_stopped():
		$RayCastTimer.start()
	if $RayCast3D.is_colliding() == true:
		$RayCastTimer.stop()

func _on_ray_cast_timer_timeout() -> void:
	angular_velocity = Vector3.ZERO
	linear_velocity = Vector3.ZERO
	global_position = GameManager.player_spawnpoint
	


func _on_ui_restart_game() -> void:
	angular_velocity = Vector3.ZERO
	linear_velocity = Vector3.ZERO
	global_position = Vector3(0, 2, 0)
