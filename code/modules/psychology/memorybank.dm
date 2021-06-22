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

/datum/memorybank/New(var/list/Mems)
	mems = Mems

/datum/memorybank/query(var/list/filters)
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


/datum/memorybank/search(var/list/toSearch,var/list/currFilter)
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



