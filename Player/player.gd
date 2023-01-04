extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var child_scene

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if Input.is_key_pressed(KEY_TAB):
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("a", "d", "w", "s")
	var input_mouse = Input.get_last_mouse_velocity()
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#var direction = (transform.basis * Vector3(input_mouse.x, 0, input_mouse.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	rotate_y(-input_mouse.x/10000)
	
	move_and_slide()
