extends AudioStreamPlayer
class_name MusicAudio

var normal_vol: float = 0

func _ready():
	normal_vol = volume_db
	update_volume(GameManager.music_volume)
	GameManager.music_update.connect(update_volume)

func update_volume(val):
	volume_db = normal_vol-80*(1-val)
