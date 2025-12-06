# TODO: Create the note creation script
on run argv
	set search_string to item 1 of argv 
	
	tell application "Notes"
		set found_notes to (every note whose body contains search_string)
		
		if (count of found_notes) is greater than 0 then
			set first_note to item 1 of found_notes
			set note_name to name of first_note
			set note_id to id of first_note
			
			return note_id
		else
			return "NOT FOUND"
		end if
	end tell
end run
