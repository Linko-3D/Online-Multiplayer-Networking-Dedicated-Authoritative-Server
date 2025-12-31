extends CharacterBody2D


const SPEED = 500.0


func _ready() -> void:
	set_physics_process(multiplayer.is_server())

	%DisplayControllerPlayer.visible = name.to_int() == multiplayer.get_unique_id()
	$ClientInputsToServer.set_multiplayer_authority(name.to_int())

	if multiplayer.is_server():
		modulate = Color.from_hsv(randf(), 0.5, 1.0)


func _physics_process(delta: float) -> void:
	var direction = $ClientInputsToServer.input_dir
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
