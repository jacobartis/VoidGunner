extends AudioStreamPlayer2D
class_name SoundAudio

var normal_vol: float = 0

func _ready():
	normal_vol = volume_db
	update_volume(GameManager.sound_volume)
	GameManager.sound_update.connect(update_volume)

func update_volume(val):
	print(normal_vol-30*(1-val))
	volume_db = normal_vol-30*(1-val)
