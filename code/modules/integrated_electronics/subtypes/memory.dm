/obj/item/integrated_circuit/memory
	name = "memory chip"
	desc = "This tiny chip can store one piece of data."
	icon_state = "memory1"
	complexity = 1
	inputs = list()
	outputs = list()
	activators = list("set" = IC_PINTYPE_PULSE_IN, "on set" = IC_PINTYPE_PULSE_OUT)
	category_text = "Memory"
	spawn_flags = IC_SPAWN_DEFAULT|IC_SPAWN_RESEARCH
	power_draw_per_use = 1
	var/number_of_pins = 1

/obj/item/integrated_circuit/memory/Initialize(mapload)
	for(var/i = 1 to number_of_pins)
		inputs["input [i]"] = IC_PINTYPE_ANY // This is just a string since pins don't get built until ..() is called.
		outputs["output [i]"] = IC_PINTYPE_ANY
	. = ..()
	complexity = number_of_pins

/obj/item/integrated_circuit/memory/examine(mob/user)
	. = ..()
	var/i
	for(i = 1, i <= outputs.len, i++)
		var/datum/integrated_io/O = outputs[i]
		var/data = "nothing"
		if(isweakref(O.data))
			var/datum/d = O.data_as_type(/datum)
			if(d)
				data = "[d]"
		else if(!isnull(O.data))
			data = O.data
		. += "\The [src] has [data] saved to address [i]."

/obj/item/integrated_circuit/memory/do_work()
	for(var/i = 1 to inputs.len)
		var/datum/integrated_io/I = inputs[i]
		var/datum/integrated_io/O = outputs[i]
		O.data = I.data
		O.push_data()
	activate_pin(2)

/obj/item/integrated_circuit/memory/tiny
	name = "small memory circuit"
	desc = "This circuit can store two pieces of data."
	icon_state = "memory2"
	power_draw_per_use = 2
	number_of_pins = 2

/obj/item/integrated_circuit/memory/medium
	name = "medium memory circuit"
	desc = "This circuit can store four pieces of data."
	icon_state = "memory4"
	power_draw_per_use = 2
	number_of_pins = 4

/obj/item/integrated_circuit/memory/large
	name = "large memory circuit"
	desc = "This big circuit can hold eight pieces of data."
	icon_state = "memory8"
	origin_tech = list(TECH_ENGINEERING = 3, TECH_DATA = 3)
	power_draw_per_use = 4
	number_of_pins = 8

/obj/item/integrated_circuit/memory/huge
	name = "large memory stick"
	desc = "This stick of memory can hold up up to sixteen pieces of data."
	icon_state = "memory16"
	w_class = ITEMSIZE_NORMAL
	spawn_flags = IC_SPAWN_RESEARCH
	origin_tech = list(TECH_ENGINEERING = 4, TECH_DATA = 4)
	power_draw_per_use = 8
	number_of_pins = 16

/obj/item/integrated_circuit/memory/constant
	name = "constant chip"
	desc = "This tiny chip can store one piece of data, which cannot be overwritten without disassembly."
	complexity = 1
	inputs = list()
	outputs = list("output pin" = IC_PINTYPE_ANY)
	activators = list("push data" = IC_PINTYPE_PULSE_IN)
	var/accepting_refs = 0
	spawn_flags = IC_SPAWN_DEFAULT|IC_SPAWN_RESEARCH

/obj/item/integrated_circuit/memory/constant/do_work()
	var/datum/integrated_io/O = outputs[1]
	O.push_data()

/obj/item/integrated_circuit/memory/constant/attack_self(mob/user)
	var/datum/integrated_io/O = outputs[1]
	var/type_to_use = tgui_input_list(user, "Please choose a type to use.","[src] type setting", list("string","number","ref", "null"))
	if(!CanInteract(user, GLOB.tgui_physical_state))
		return

	var/new_data = null
	switch(type_to_use)
		if("string")
			accepting_refs = 0
			new_data = tgui_input_text(user, "Now type in a string.","[src] string writing", MAX_NAME_LEN)
			new_data = sanitize(new_data,MAX_NAME_LEN)
			if(istext(new_data) && CanInteract(user, GLOB.tgui_physical_state))
				O.data = new_data
				to_chat(user, span_notice("You set \the [src]'s memory to [O.display_data(O.data)]."))
		if("number")
			accepting_refs = 0
			new_data = tgui_input_number(user, "Now type in a number.","[src] number writing", MAX_NAME_LEN)
			if(isnum(new_data) && CanInteract(user, GLOB.tgui_physical_state))
				O.data = new_data
				to_chat(user, span_notice("You set \the [src]'s memory to [O.display_data(O.data)]."))
		if("ref")
			accepting_refs = 1
			to_chat(user, span_notice("You turn \the [src]'s ref scanner on. Slide it across \
			an object for a ref of that object to save it in memory."))
		if("null")
			O.data = null
			to_chat(user, span_notice("You set \the [src]'s memory to absolutely nothing."))

/obj/item/integrated_circuit/memory/constant/afterattack(atom/target, mob/living/user, proximity)
	if(accepting_refs && proximity)
		var/datum/integrated_io/O = outputs[1]
		O.data = WEAKREF(target)
		visible_message(span_notice("[user] slides \a [src]'s over \the [target]."))
		to_chat(user, span_notice("You set \the [src]'s memory to a reference to [O.display_data(O.data)]. The ref scanner is \
		now off."))
		accepting_refs = 0
