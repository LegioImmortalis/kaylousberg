extends CharacterBody3D

const BASESPEED = 5.0
const JUMP_VELOCITY = 7
const RUN = 2.0
const WALK = 0.6
const DASH = 10
var speed = BASESPEED
var character
var input_dir = Vector3.ZERO
var animationLength = 0
var dashTimer = Timer.new()# $Timer

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
		characterDirection = Vector3(0,0,0)
		if rotation.y == 0:
			characterDirection = Vector3(1, 0, 0)
		if rotation.y == 90:
			characterDirection = Vector3(0, 0, 1)
		if rotation.y == 180:
			characterDirection = Vector3(-1, 0, 0)
		if rotation.y == 270:
			characterDirection = Vector3(0, 0, -1)

		if is_on_floor() or is_on_wall():
			input_dir = Input.get_vector("d", "a", "s", "w")
		var input_mouse = Input.get_last_mouse_velocity()
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

		var animation
		#dashTimer.autostart=true
		
		animation = _handle_movement(animation,input_dir,direction)
		if animation:
			animation_player.play(animation)
			#animationLength = animation_player.get_current_animation_length()

		
		velocity *= Vector3(0,1,0)
		
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
				
		#print(velocity)
		if Input.is_key_pressed(KEY_ESCAPE):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			rotate_y(-input_mouse.x/10000)
			animations.get_node("Skeleton3D/Camera3D").rotate_x(input_mouse.y/10000)
			#print(animations.get_node("Skeleton3D/Camera3D").project_ray_origin(self))
			#print(direction)	
			move_and_slide()
	
func _add_character(source):
	character = source.instantiate()
	if $CharacterNode.get_child_count() > 0:
		$CharacterNode.remove_child($CharacterNode.get_child(0))
	$CharacterNode.add_child.call_deferred(character)
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

const RAY_LENGTH = 1000.0

#func _input(event):
#	if character: # handle animations
#		var animations = character.get_node("Animations")  
#		var animation_player = animations.get_node("AnimationPlayer")  
#		if event is InputEventMouseButton and event.pressed and event.button_index == 1:
#			var camera3d = animations.get_node("Skeleton3D/Head/Camera3D")
#			var from = camera3d.project_ray_origin(event.position)
#			var to = from + camera3d.project_ray_normal(event.position) * RAY_LENGTH
#			print(to)

#func dash(animation_player):
#	speed = BASESPEED*DASH
#	animation_player.play("KayKit Animated Character|DashFront")
#	await(get_tree().create_timer(0.1))
	#animation_player.play("KayKit Animated Character|DashBack")
	#animation_player.play("KayKit Animated Character|DashLeft")
	#animation_player.play("KayKit Animated Character|DashRight")
	
func _handle_movement(animation,input_dir,direction):
	if is_on_floor() and not $Timer.time_left:
		if input_dir == Vector2.ZERO:
			return "KayKit Animated Character|Idle"
			if Input.is_key_pressed(KEY_SPACE):
				self.translate(direction*BASESPEED*WALK)
				velocity.y = JUMP_VELOCITY
				return "KayKit Animated Character|Jump"
		if not input_dir == Vector2.ZERO:
			if Input.is_action_just_pressed("dash"):
				speed = BASESPEED*DASH
				#$Timer.wait_time(animationLength)
				$Timer.start(0.7)
				return "KayKit Animated Character|DashFront"
			if Input.is_key_pressed(KEY_SHIFT):
				speed = BASESPEED*RUN
				return "KayKit Animated Character|Run"
			if Input.is_key_pressed(KEY_CTRL):
				speed = BASESPEED*WALK
			if Input.is_key_pressed(KEY_SPACE):
				velocity.y = JUMP_VELOCITY
				return "KayKit Animated Character|Run"
			speed = BASESPEED
			return "KayKit Animated Character|Walk"
	if not is_on_floor() and not $Timer.time_left:	
		if Input.is_action_just_pressed("dash"):
			return "KayKit Animated Character|Roll"
		if is_on_wall():
			if Input.is_action_just_pressed("dash"):
				self.translate(position+velocity*Vector3(0.001,0,0.001))
				velocity.y = JUMP_VELOCITY
				speed = -BASESPEED*RUN
				return "KayKit Animated Character|Roll"
			if  Input.is_action_just_pressed("ui_accept"):
				velocity.y = JUMP_VELOCITY
				return "KayKit Animated Character|Hop"
			if Input.is_key_pressed(KEY_SPACE):
				if velocity.y <= 0:
					velocity.y = 0
					return "KayKit Animated Character|Climbing"
