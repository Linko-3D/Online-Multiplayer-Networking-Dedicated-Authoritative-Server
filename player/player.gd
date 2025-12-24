extends CharacterBody2D


const SPEED = 500.0
var color

@export var bullet : PackedScene


func _ready():
	%DisplayControllerPlayer.visible = name.to_int() == multiplayer.get_unique_id()
	$InputsToServer.set_multiplayer_authority(name.to_int())
	set_physics_process(multiplayer.is_server())

	if multiplayer.is_server():
		color = Color.from_hsv(randf(), 0.5, 1.0)
		modulate = color


func _physics_process(delta: float):
	if $InputsToServer.shoot:
		print("shooting")
		var bullet_instance = bullet.instantiate()
		bullet_instance.global_position = %Muzzle.global_position
		bullet_instance.global_rotation = %Muzzle.global_rotation
		bullet_instance.modulate = color
		#bullet_instance.global_rotation = $Sprite2D.angle()
		get_tree().get_first_node_in_group("projectiles").add_child(bullet_instance, true)
	
	
	var direction = $InputsToServer.input_dir
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

	$Top.look_at($Top.global_position + $InputsToServer.aim_vector)
	$Sprite2D.global_rotation = direction.angle()
