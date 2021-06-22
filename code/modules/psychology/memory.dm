//memories!
//Memories are, for the most part, RP mechanics.
//Though, some provide benefits to the player.
//Memories are stored in various places!
//Memories are for the most part, interacted with by the psychologist/therapist.
/datum/memory
	var/title = "New Memory"	//A "title" for the memory
	var/description = "N/A"		//Descriptive text of the memory.
	var/depth = 1				//int value one to five describing how difficult it is to read
	var/difficulty = 1			//int value one to five describing how difficult it is to modify (basically, puzzle difficulty)
	var/uEffect = 0				//what unique effect this memory will have on a person who has it. 0 is none. (more details later.)

/datum/memory/New(var/Title,var/Desc,var/Dep,var/Diff,var/Eff)
	title = Title
	description = desc
	depth = Dep
	difficulty = Diff
	uEffect = Eff
