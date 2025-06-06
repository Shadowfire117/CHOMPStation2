/datum/species/monkey
	name = SPECIES_MONKEY
	name_plural = "Monkeys"
	blurb = "Ook."

	icobase = 'icons/mob/human_races/monkeys/r_monkey.dmi'
	deform = 'icons/mob/human_races/monkeys/r_monkey.dmi'
	damage_overlays = 'icons/mob/human_races/masks/dam_monkey.dmi'
	damage_mask = 'icons/mob/human_races/masks/dam_mask_monkey.dmi'
	blood_mask = 'icons/mob/human_races/masks/blood_monkey.dmi'
	language = null
	default_language = LANGUAGE_ANIMAL
	greater_form = SPECIES_HUMAN
	mob_size = MOB_SMALL
	has_fine_manipulation = 0
	show_ssd = null
	health_hud_intensity = 2

	gibbed_anim = "gibbed-m"
	dusted_anim = "dust-m"
	death_message = "lets out a faint chimper as it collapses and stops moving..."
	tail = "chimptail"
	fire_icon_state = "monkey"

	// male_scream_sound = null //CHOMPedit
	// female_scream_sound = null //CHOMPedit

	unarmed_types = list(/datum/unarmed_attack/bite, /datum/unarmed_attack/claws)
	inherent_verbs = list(/mob/living/proc/ventcrawl)
	hud_type = /datum/hud_data/monkey
	meat_type = /obj/item/reagent_containers/food/snacks/meat/monkey

	rarity_value = 0.1
	total_health = 75
	brute_mod = 1.5
	burn_mod = 1.5

	spawn_flags = SPECIES_IS_RESTRICTED

	bump_flag = MONKEY
	swap_flags = MONKEY|SLIME|SIMPLE_ANIMAL
	push_flags = MONKEY|SLIME|SIMPLE_ANIMAL|ALIEN

	pass_flags = PASSTABLE

	has_limbs = list(
		BP_TORSO =  list("path" = /obj/item/organ/external/chest),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/no_eyes),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right)
		)

/datum/species/monkey/handle_npc(var/mob/living/carbon/human/H)
	if(H.stat != CONSCIOUS)
		return
	// Traitgenes Monkeys perform emotes based on their traits
	if(H.canmove && isturf(H.loc) && !H.pulledby) //won't move if being pulled
		if(prob(33))
			step(H, pick(GLOB.cardinal))
		if(prob(5))
			// Handle generic gene expression emotes
			if(!H.species || !H.species.traits || H.species.traits.len == 0)
				H.emote(pick("scratch","jump","roll","tail")) // fallbacks
			else
				var/datum/trait/T = GLOB.all_traits[pick(H.species.traits)]
				if(T)
					var/geneexpression
					if(T.primitive_expression_messages.len)
						geneexpression = pick(T.primitive_expression_messages)
					if(geneexpression)
						H.automatic_custom_emote(VISIBLE_MESSAGE, "[geneexpression]", check_stat = TRUE)
					else
						H.emote(pick("scratch","jump","roll","tail"))
		// More... intense, expressions...
		if(prob(5) && H.mutations.len)
			if((LASER in H.mutations))
				// zappy monkeys
				var/list/targs = list()
				for(var/atom/X in orange(7, H))
					targs.Add(X)
				if(targs.len)
					H.LaserEyes(pick(targs))

	..()

/datum/species/monkey/get_random_name()
	return "[lowertext(name)] ([rand(100,999)])"

/datum/species/monkey/handle_post_spawn(var/mob/living/carbon/human/H)
	if(!H.ckey)
		H.can_be_drop_prey = TRUE
		H.digest_leave_remains = 1
		H.low_priority = TRUE
	return ..()

/datum/species/monkey/tajaran
	name = SPECIES_MONKEY_TAJ
	name_plural = "Farwa"

	icobase = 'icons/mob/human_races/monkeys/r_farwa.dmi'
	deform = 'icons/mob/human_races/monkeys/r_farwa.dmi'

	greater_form = SPECIES_TAJARAN
	default_language = LANGUAGE_ANIMAL
	flesh_color = "#AFA59E"
	base_color = "#333333"
	tail = "farwatail"

/datum/species/monkey/skrell
	name = SPECIES_MONKEY_SKRELL
	name_plural = "Neaera"

	icobase = 'icons/mob/human_races/monkeys/r_neaera.dmi'
	deform = 'icons/mob/human_races/monkeys/r_neaera.dmi'

	greater_form = SPECIES_SKRELL
	default_language = LANGUAGE_ANIMAL
	flesh_color = "#8CD7A3"
	blood_color = "#1D2CBF"
	reagent_tag = IS_SKRELL
	tail = null

/datum/species/monkey/unathi
	name = SPECIES_MONKEY_UNATHI
	name_plural = "Stok"

	icobase = 'icons/mob/human_races/monkeys/r_stok.dmi'
	deform = 'icons/mob/human_races/monkeys/r_stok.dmi'

	tail = "stoktail"
	greater_form = SPECIES_UNATHI
	default_language = LANGUAGE_ANIMAL
	flesh_color = "#34AF10"
	base_color = "#066000"
	reagent_tag = IS_UNATHI

/datum/species/monkey/shark
	name = SPECIES_MONKEY_AKULA
	name_plural = "Sobaka"
	icobase = 'icons/mob/human_races/monkeys/r_sobaka_vr.dmi'
	deform = 'icons/mob/human_races/monkeys/r_sobaka_vr.dmi'
	tail = null //The tail is part of its body due to tail using the "icons/effects/species.dmi" file. It must be null, or they'll have a chimp tail.
	greater_form = SPECIES_AKULA
	default_language = "Skrellian" //Closest we have.

/datum/species/monkey/sergal
	name = SPECIES_MONKEY_SERGAL
	greater_form = "Sergal"
	icobase = 'icons/mob/human_races/monkeys/r_sergaling_vr.dmi'
	deform = 'icons/mob/human_races/monkeys/r_sergaling_vr.dmi'
	tail = null
	default_language = LANGUAGE_SAGARU

/datum/species/monkey/sparra
	name = SPECIES_MONKEY_NEVREAN
	name_plural = "Sparra"
	greater_form = SPECIES_NEVREAN
	tail = null
	icobase = 'icons/mob/human_races/monkeys/r_sparra_vr.dmi'
	deform = 'icons/mob/human_races/monkeys/r_sparra_vr.dmi'
	default_language = LANGUAGE_BIRDSONG


/* Example
/datum/species/monkey/tajaran
	name = SPECIES_MONKEY_TAJ
	name_plural = "Farwa"

	icobase = 'icons/mob/human_races/monkeys/r_farwa.dmi'
	deform = 'icons/mob/human_races/monkeys/r_farwa.dmi'

	greater_form = SPECIES_TAJARAN
	default_language = "Farwa"
	flesh_color = "#AFA59E"
	base_color = "#333333"
	tail = "farwatail"
*/

/datum/species/monkey/vulpkanin
	name = SPECIES_MONKEY_VULPKANIN
	name_plural = "Wolpin"

	icobase = 'icons/mob/human_races/monkeys/r_wolpin.dmi'
	deform = 'icons/mob/human_races/monkeys/r_wolpin.dmi'

	greater_form = SPECIES_VULPKANIN
	default_language = LANGUAGE_CANILUNZT
	flesh_color = "#966464"
	base_color = "#000000"
	tail = null

//INSERT CODE HERE SO MONKEYS CAN BE SPAWNED.
//Also, M was added to the end of the spawn names to signify that it's a monkey, since some names were conflicting.

/mob/living/carbon/human/sharkm
	low_sorting_priority = TRUE

/mob/living/carbon/human/sharkm/Initialize(mapload)
	. = ..(mapload, SPECIES_MONKEY_AKULA)
	species.produceCopy(species.traits.Copy(),src,null,FALSE)

/mob/living/carbon/human/sergallingm
	low_sorting_priority = TRUE

/mob/living/carbon/human/sergallingm/Initialize(mapload)
	. = ..(mapload, SPECIES_MONKEY_SERGAL)
	species.produceCopy(species.traits.Copy(),src,null,FALSE)

/mob/living/carbon/human/sparram
	low_sorting_priority = TRUE

/mob/living/carbon/human/sparram/Initialize(mapload)
	. = ..(mapload, SPECIES_MONKEY_NEVREAN)
	species.produceCopy(species.traits.Copy(),src,null,FALSE)

/mob/living/carbon/human/wolpin
	low_sorting_priority = TRUE

/mob/living/carbon/human/wolpin/Initialize(mapload)
	. = ..(mapload, SPECIES_MONKEY_VULPKANIN)
	species.produceCopy(species.traits.Copy(),src,null,FALSE)
