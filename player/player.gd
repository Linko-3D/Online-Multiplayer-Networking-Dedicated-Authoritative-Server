extends CharacterBody2D


const SPEED = 500.0


func _ready():
	$DisplayControllerPlayer.visible = name.to_int() == multiplayer.get_unique_id()
	$InputsToServer.set_multiplayer_authority(name.to_int())
	set_physics_process(multiplayer.is_server())


func _physics_process(delta):
	var direction = $InputsToServer.input_dir
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
