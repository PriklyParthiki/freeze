extends Node

var click_sound = preload("res://click.mp3")
var audio_player: AudioStreamPlayer

func _ready() -> void:
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	
	# Connect to buttons added later during gameplay
	get_tree().node_added.connect(_on_node_added)
	
	# Connect to buttons already sitting in the scene right now
	await get_tree().process_frame
	_connect_buttons(get_tree().root)

func _connect_buttons(node: Node) -> void:
	if node is BaseButton:
		if not node.pressed.is_connected(_on_button_pressed.bind(node)):
			node.pressed.connect(_on_button_pressed.bind(node))
	for child in node.get_children():
		_connect_buttons(child)

func _on_node_added(node: Node) -> void:
	if node is BaseButton:
		node.pressed.connect(_on_button_pressed.bind(node))

func _on_button_pressed(node: BaseButton) -> void:
	# Play the click sound
	audio_player.stream = click_sound
	audio_player.play()
	
	# Visual flash effect
	var tween = node.create_tween()
	tween.tween_property(node, "modulate", Color(0.7, 0.7, 0.7), 0.05)
	tween.tween_property(node, "modulate", Color(1, 1, 1), 0.1)
