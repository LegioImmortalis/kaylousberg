extends CharacterBody3D

const BASESPEED = 6.0
const JUMP_VELOCITY = 4.5
const RUN = 2.0
const WALK = 0.6
var speed = BASESPEED
var character

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var child_scene

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if character: # handle animations
		var animations = character.get_node("Animations")  
		var animation_player = animations.get_node("AnimationPlayer")  

		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			animation_player.play("KayKit Animated Character|Jump")
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			
		if Input.is_key_pressed(KEY_W):
			if Input.is_key_pressed(KEY_SHIFT):
				speed = BASESPEED*RUN
				animation_player.play("KayKit Animated Character|Run")
			else:
				animation_player.play("KayKit Animated Character|Walk")
			if Input.is_key_pressed(KEY_CTRL):
				speed = BASESPEED*WALK		
		if Input.is_key_pressed(KEY_S):
			if Input.is_key_pressed(KEY_SHIFT):
				speed = BASESPEED*RUN
				animation_player.play_backwards("KayKit Animated Character|Run")
			else:
				animation_player.play_backwards("KayKit Animated Character|Walk")
			if Input.is_key_pressed(KEY_CTRL):
				speed = BASESPEED*WALK
		if false:
			animation_player.play("KayKit Animated Character|Attack(l h)")
			animation_player.play("KayKit Animated Character|AttackCombo")
			animation_player.play("KayKit Animated Character|AttackSpinning")
			animation_player.play("KayKit Animated Character|BasePose")
			animation_player.play("KayKit Animated Character|Block")
			animation_player.play("KayKit Animated Character|Cheer")
			animation_player.play("KayKit Animated Character|Climbing")
			animation_player.play("KayKit Animated Character|Dance")
			animation_player.play("KayKit Animated Character|DashBack")
			animation_player.play("KayKit Animated Character|DashFront")
			animation_player.play("KayKit Animated Character|DashLeft")
			animation_player.play("KayKit Animated Character|DashRight")
			animation_player.play("KayKit Animated Character|Defeat")
			animation_player.play("KayKit Animated Character|HeavyAttack")
			animation_player.play("KayKit Animated Character|Hop")
			animation_player.play("KayKit Animated Character|Idle")
			animation_player.play("KayKit Animated Character|Interact")
			animation_player.play("KayKit Animated Character|Jump")
			animation_player.play("KayKit Animated Character|LayingDownIdle")
			animation_player.play("KayKit Animated Character|PickUp")
			animation_player.play("KayKit Animated Character|Roll")
			animation_player.play("KayKit Animated Character|Run")
			animation_player.play("KayKit Animated Character|Shoot(l h)")
			animation_player.play("KayKit Animated Character|Shoot(2h)")
			animation_player.play("KayKit Animated Character|Shoot(2h)Bow")
			animation_player.play("KayKit Animated Character|Shooting(l h)")
			animation_player.play("KayKit Animated Character|Shooting(2h)")
			animation_player.play("KayKit Animated Character|Throw")
			animation_player.play("KayKit Animated Character|Walk")
			animation_player.play("KayKit Animated Character|Wave")
		
		var characterDirection = Vector3()	
		if $".".rotation.y == 0:
			characterDirection = Vector3(1, 0, 0)
		elif $".".rotation.y == 90:
			characterDirection = Vector3(0, 0, 1)
		elif $".".rotation.y == 180:
			characterDirection = Vector3(-1, 0, 0)
		elif $".".rotation.y == 270:
			characterDirection = Vector3(0, 0, -1)

		# Cast a ray in the direction the character is facing and check if it hits a wall
		var world = $".".get_parent().get_node("Village")
		var hit = world.direct_space_state.intersect_ray($".".position, $".".position + characterDirection * 100)
		#if hit:
		#	print("wall")
		#else:
		#	pass
		
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("a", "d", "w", "s")
		#if input_dir.x > 0 && input_dir.y > 0 || input_dir.x < 0 && input_dir.y < 0:
			#animations.get_node("Skeleton3D/Head/Camera3D").rotation(deg_to_rad(45))
		#	print(input_dir)
		#if input_dir.x > 0 && input_dir.y < 0 || input_dir.x < 0 && input_dir.y > 0:
		#	print(input_dir)
		var input_mouse = Input.get_last_mouse_velocity()
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		#var direction = (transform.basis * Vector3(input_mouse.x, 0, input_mouse.y)).normalized()
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
		
		rotate_y(-input_mouse.x/10000)
		animations.get_node("Skeleton3D/Head/Camera3D").rotate_x(input_mouse.y/10000)
		move_and_slide()
	
func _add_character(source):
	character = source.instantiate()
	if $CharacterNode.get_child_count() > 0:
		$CharacterNode.remove_child($CharacterNode.get_child(0))
	$CharacterNode.add_child.call_deferred(character)
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#var anim_library = AnimationLibrary.new()
	#anim_library = load("res://Player/Character/animations.tscn::AnimationLibrary_klc5h")
	#var anim = AnimationPlayer.new()
	#anim.add_animation_library("CharacterAminations",anim_library)
	#print(anim.get_animation_library_list())
	#var animation_player = get_node(characterNode.get_path())
	#animation_player.play("KayKit Animated Character|Walk")
	#var animation = $source/AnimationPlayer
	#animation.play("KayKit Animated Character|Walk")
