//A memory bank is a collection of memories.
//things such as brains and memory backup cards contain these, and they're used to display memory UI.

/*
ok so
things that this should be able to do:

shuffle memories around
add and remove memories
pull a memory based off of its attributes
slot nicely into a brain or other item
display some UI to show all the memories it stores
*/
/datum/memorybank
	var/list/mems = new()			//List of memories stored here

/datum/memorybank/New(list/Mems)
	mems = Mems

/datum/memorybank/query(list/filters)
	//ok we want to search the memory bank by: ueffect, depth, difficulty, and text in title and description
	//consider a 2d array
	/*
		0 => 3 => 2
		5 => 3 => "security"
		^

		we iterate across the list, pulling the information from each entry.
		the first attribute will be what the filter is
		the second attribute will be what we are searching for.
	*/
	var/list/currFilter = new()
	var/list/results = new()
	for (i = 1, i<= filters.len, i++)
		currFilter = filters[i]
		if (i==1)
			results = search(mems,currFilter)
		else
			results = search(results,currFilter)


/datum/memorybank/search(list/toSearch,list/currFilter)
	var/f = currFilter[1]
	var/q = currFilter[2]
	var/list/results = new()
	switch (f)
		if (0)	//title
			for (i = 1, i <= toSearch.len, i++)
				var/datum/memory/curr = toSearch[i]
				if (findtext(toSearch[i].title),q)
					results.Add(curr)
			return results
		if (1)	//description
			for (i = 1, i <= toSearch.len, i++)
				var/datum/memory/curr = toSearch[i]
				if (findtext(toSearch[i].description),q)
					results.Add(curr)
			return results
		if (2)	//depth
			for (i = 1, i <= toSearch.len, i++)
				var/datum/memory/curr = toSearch[i]
				if (curr.depth == q)
					results.Add(curr)
			return results
		if (3)	//difficulty
			for (i = 1, i <= toSearch.len, i++)
				var/datum/memory/curr = toSearch[i]
				if (curr.difficulty == q)
					results.Add(curr)
			return results
		if (4)	//ueffect
			for (i = 1, i <= toSearch.len, i++)
				var/datum/memory/curr = toSearch[i]
				if (curr.uEffect == q)
					results.Add(curr)
			return results
		else
			return toSearch

/*
* Okay. TGUI time.
* I want the TGUI for this to be pulled up when using a particular verb. I think?
* In the meantime, I suppose that we can just... use ui_interact
* I have absolutely fuck all clue if that will work on a datum, and not a mob, though.
* I have a feeling that it won't.
*
* What if I made it a ui_interact on the brain item? Let's try that for now.
*/
/obj/item/organ/internal/brain/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Memory Bank")
		ui.open()

/obj/item/organ/internal/brain/ui_data(mob/user)
	var/list/data = list()
	data["health"] = health
	data["color"] = color

	return data

/obj/item/organ/internal/brain/ui_act(action, params)
	. = ..()
	if(.)
		return
	if (action == "change_color")
		var/new_color = params["color"]
		if(!(color in allowed_colors))
			return FALSE
		color = new_color
		. = TRUE
	update_icon()
