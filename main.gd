extends Node3D

@onready var camera = $CameraRig/Camera
@onready var raycast = $CameraRig/Camera/RayCast3D
@onready var player = $Player

var target_position = Vector3.ZERO
var moving = false
var speed = 5.0

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		var viewport = get_viewport()
		var mouse_pos = event.position
		var from = camera.project_ray_origin(mouse_pos)
		var to = from + camera.project_ray_normal(mouse_pos) * 1000
		
		var space_state = get_world_3d().direct_space_state
		var params = PhysicsRayQueryParameters3D.create(from, to);
		var result = space_state.intersect_ray(params)
		
		if result and result.has("position"):
			var height = player.get_aabb().size.y
			target_position = result.position + Vector3.UP * (height / 2)
			moving = true
			#print("Click en:", target_position)
		#else:
			#print("No se detectó colisión")

func _process(delta):
	if moving:
		var direction = (target_position - player.global_transform.origin)
		if direction.length() > 0.1:
			direction = direction.normalized()
			player.global_translate(direction * speed * delta)
			#print("Moviendo a:", target_position)
		else:
			moving = false
			#print("Llegó al destino")
