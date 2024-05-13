extends Control


func update_stats(stats:PlayerStats):
	%MaxHealth.set_text(str("Max Health: ",stats.max_health))
	%Speed.set_text(str("Speed: ",stats.speed))
	%SpellSlots.set_text(str("Spell Slots: ",stats.spell_slots))
	
	%VoidGap.set_text(str("Void Spawn Gap: ",stats.node_gap))
	%ActivationDelay.set_text(str("Void Activation Delay: ",stats.activation_delay))
	%VoidQuantity.set_text(str("Total Void Portals: ",stats.trail_length))
	
	%knowledgeMult.set_text(str("Max knowledge Mult: ",stats.knowledge_mult))
	%GainSpeed.set_text(str("Madness Gain Speed: ",stats.gain_speed))
	
	%DashCooldown.set_text(str("Dash Cooldown: ",stats.dash_cooldown))
	%DashSpeed.set_text(str("Dash Speed: ",stats.dash_speed))
	%DashDistance.set_text(str("Dash Distance: ",stats.dash_distance))
