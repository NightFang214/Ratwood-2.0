// Sandstorm particles - fast, horizontal, abrasive
/particles/weather/sand
	icon_state = "dot"
	color      = "#c2b280" // sandy tan
	position   = generator("box", list(-600,-256,5), list(600,500,0))
	spin       = null

	// Mostly horizontal movement
	gravity = list(0.3, 0, 0)
	drift = list( generator("num", 2, 4), generator("num", -0.5, 0.5), 0)
	fade = 0.5
	fadein = 1
	friction   = 0.05 //
	transform = null
	// Weather tuning
	maxSpawning = 80
	minSpawning = 20
	wind        = 20

/particles/weather/sand/gentle
	wind        = 5
/datum/particle_weather/sand_gentle
	name = "Sandstorm"
	desc = "A dry wind kicks sand through the air."
	particleEffectType = /particles/weather/sand/gentle

	scale_vol_with_severity = TRUE
	weather_sounds = list(/datum/looping_sound/sandstorm)
	indoor_weather_sounds = list(/datum/looping_sound/wind)
	minSeverity = 5
	maxSeverity = 25
	maxSeverityChange = 10
	severitySteps = 5

	immunity_type = TRAIT_SANDSTORM_IMMUNE
	probability = 1
	target_trait = PARTICLEWEATHER_SAND

/datum/particle_weather/sand_gentle/weather_act(mob/living/L)
	if(HAS_TRAIT(L, TRAIT_SANDSTORM_IMMUNE))
		return
	var/obj/item/I = L.get_item_by_slot(ITEM_SLOT_MASK)

	if(I && istype(I, /obj/item/clothing/mask/rogue/spectacles/goggles))

	if(!HAS_TRAIT(L, TRAIT_SANDSTORMED))
		ADD_TRAIT(L, TRAIT_SANDSTORMED, TRAIT_GENERIC)

	if(prob(5))
		L.adjust_blurriness(1)


/datum/particle_weather/sand_gentle/try_weather_act(mob/living/L)
	if(!L.mind)
		return

	if(can_weather(L))
		weather_sound_effect(L)
		if(can_weather_effect(L))
			weather_act(L)
			if(!messagedMobs[L] || world.time > messagedMobs[L])
				weather_message(L)
	else
		stop_weather_sound_effect(L)
		messagedMobs[L] = 0
		if(HAS_TRAIT(L, TRAIT_SANDSTORMED))
			REMOVE_TRAIT(L, TRAIT_SANDSTORMED, TRAIT_GENERIC)

/datum/particle_weather/sand_gentle/end()
	running = FALSE
	for(var/mob/living/M in currentSounds)
		if(M.client)
			stop_weather_sound_effect(M)
		if(HAS_TRAIT(M, TRAIT_SANDSTORMED))
			REMOVE_TRAIT(M, TRAIT_SANDSTORMED, TRAIT_GENERIC)
	SSParticleWeather.stopWeather()

/datum/particle_weather/sand_storm
	name = "Sandstorm"
	desc = "A howling wall of sand scours the land."
	particleEffectType = /particles/weather/sand

	scale_vol_with_severity = TRUE
	weather_sounds = list(/datum/looping_sound/sandstorm)
	indoor_weather_sounds = list(/datum/looping_sound/wind)
	minSeverity = 40
	maxSeverity = 100
	maxSeverityChange = 50
	severitySteps = 50

	immunity_type = TRAIT_SANDSTORM_IMMUNE
	probability = 1
	target_trait = PARTICLEWEATHER_SAND

/datum/particle_weather/sand_storm/weather_act(mob/living/L)
	if(HAS_TRAIT(L, TRAIT_SANDSTORM_IMMUNE))
		return
	if(!HAS_TRAIT(L, TRAIT_SANDSTORMED))
		ADD_TRAIT(L, TRAIT_SANDSTORMED, TRAIT_GENERIC)
	// Heat + abrasion

//	L.adjust_blurriness(rand(1,3))

	if(prob(10))
		L.adjustStaminaLoss(2)


/datum/particle_weather/sand_storm/try_weather_act(mob/living/L)
	if(!L.mind)
		return

	if(can_weather(L))
		weather_sound_effect(L)
		if(can_weather_effect(L))
			weather_act(L)
			if(!messagedMobs[L] || world.time > messagedMobs[L])
				weather_message(L)
	else
		stop_weather_sound_effect(L)
		messagedMobs[L] = 0
		if(HAS_TRAIT(L, TRAIT_SANDSTORMED))
			REMOVE_TRAIT(L, TRAIT_SANDSTORMED, TRAIT_GENERIC)

/datum/particle_weather/sand_storm/end()
	running = FALSE
	for(var/mob/living/M in currentSounds)
		if(M.client)
			stop_weather_sound_effect(M)
		if(HAS_TRAIT(M, TRAIT_SANDSTORMED))
			REMOVE_TRAIT(M, TRAIT_SANDSTORMED, TRAIT_GENERIC)
	SSParticleWeather.stopWeather()