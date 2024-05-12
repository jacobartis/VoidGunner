extends Label
class_name ScoreTracker

var score: float = 0 :set=set_score

func set_score(val):
	score = val
	set_text(str("Score: ",val))

func add_score(val):
	score += val
