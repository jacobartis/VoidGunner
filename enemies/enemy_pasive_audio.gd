extends SoundAudio
class_name PasiveAudio

@export var delay: float = 0
@export var randomness: float = 0

func _ready():
	super()
	finished.connect(start_audio)
	start_audio()

func start_audio():
	await get_tree().create_timer(delay+randf_range(-randomness,randomness)).timeout
	play()
