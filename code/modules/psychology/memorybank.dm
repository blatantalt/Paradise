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
	var/index = 1
	var/selected = 0

/datum/memorybank/New(list/Mems)
	mems = Mems

/datum/memorybank/proc/query(list/filters)
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
	var/selected = 0
	var/i
	for (i = 1, i<= filters.len, i++)
		currFilter = filters[i]
		if (i==1)
			results = search(mems,currFilter)
		else
			results = search(results,currFilter)


/datum/memorybank/proc/search(list/toSearch,list/currFilter)
	var/f = currFilter[1]
	var/q = currFilter[2]
	var/list/results = new()
	var/i
	switch (f)
		if (0)	//title
			for (i = 1, i <= toSearch.len, i++)
				var/datum/memory/curr = toSearch[i]
				if (findtext(toSearch[i].title, q))
					results.Add(curr)
			return results
		if (1)	//description
			for (i = 1, i <= toSearch.len, i++)
				var/datum/memory/curr = toSearch[i]
				if (findtext(toSearch[i].description, q))
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

/datum/memorybank/proc/getMemFromIndex(var/fetch)
	var/list/output = list(
		title = mems[fetch].title,
		description = mems[fetch].description,
		depth = mems[fetch].depth,
		difficulty = mems[fetch].difficulty,
		uEffect = mems[fetch].uEffect,
	)
	return output

/*
* Okay. TGUI time.
* I want the TGUI for this to be pulled up when using a particular verb. I think?
* In the meantime, I suppose that we can just... use ui_interact
* I have absolutely fuck all clue if that will work on a datum, and not a mob, though.
* I have a feeling that it won't.
*
* What if I made it a ui_interact on the brain item? Let's try that for now.
*/



/*
	BIG IMPORTANT TO DOS
	1. make the memories list query some stuff
	2. some way to get more descriptive ueffect text
	3. memory tampering notifications
*/
/obj/item/organ/internal/brain/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MemoryInterface")
		ui.open()

/obj/item/organ/internal/brain/ui_data(mob/user)
	var/list/data = list()
	data["selected"] = membank.selected
	data["memories"] = list()
	var/i
	for(i=1, 1<=membank.mems.len, i++)
		var/list/data_mem = list(
			title = membank.mems[i].title,
			description = membank.mems[i].description,
			depth = membank.mems[i].depth,
			difficulty = membank.mems[i].difficulty,
			uEffect = membank.mems[i].uEffect,
			index = i
		)
		data["memories"] += list(data_mem)
	data["thisMemory"] = membank.getMemFromIndex(membank.index)

	return data

/obj/item/organ/internal/brain/ui_act(action, params)
	. = ..()
	if(.)
		return

	if (action == "selMem")
		var/memory_index = params["index"]
		membank.index = memory_index
		if(memory_index == membank.selected)
			membank.selected = 0
			. = TRUE
		else
			membank.selected = memory_index
			. = TRUE

	update_icon()
