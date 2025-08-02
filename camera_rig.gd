extends Node3D

@export var target_path: NodePath
@export var follow_speed := 5.0

var target: Node3D

func _ready():
	target = get_node(target_path)

func _process(delta):
	if target:
		# Seguí al target en X y Z, pero mantené la altura Y actual
		var target_pos = target.global_transform.origin
		var desired_pos = Vector3(target_pos.x+5, global_position.y, target_pos.z+5)
		global_position = global_position.lerp(desired_pos, follow_speed * delta)
