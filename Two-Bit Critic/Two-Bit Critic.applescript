(*
Two-Bit Critic - Version 1.1
By Dogheadbone LLC
http://www.dogheadbone.com/ - support@dogheadbone.com

Two-Bit Critic is an AppleScript for iTunes that allows you to rate songs in your iTunes libaray based off a series of questions.

October 4, 2003
*)

global theCurrentScore
global theTotalScore
global userChoiceList

set theCurrentScore to 0 as integer
set theTotalScore to 0 as integer
-- if you want to change these, make sure you change them in the askQuestion function too
set userChoiceList to {"Great!", "Pretty Good", "Just OK", "Not Very Good", "Awful"}

tell application "iTunes"
	try
		set theTrack to the current track
		set trackName to the name of theTrack
		set trackArtist to the artist of theTrack
		set userInput to display dialog "Would you like to rate '" & trackName & "' by " & trackArtist & "?"
		if button returned of userInput is "OK" then
			-- feel free to change these 
			set theQuestion to "What would you rate the musicianship?"
			my askQuestion(theQuestion)
			set theQuestion to "What would you rate the lyrics?"
			my askQuestion(theQuestion)
			set theQuestion to "What would you rate the originality?"
			my askQuestion(theQuestion)
			set theQuestion to "How does this compare to other songs by " & trackArtist & "?"
			my askQuestion(theQuestion)
			set trackGenre to the genre of theTrack
			set theQuestion to "How does this compare to other songs in this genre (" & trackGenre & ")?"
			my askQuestion(theQuestion)
			if theCurrentScore is greater than 0 then
				set dividedTotal to (100 / theTotalScore)
				set trackRating to (dividedTotal * theCurrentScore)
				set rating of theTrack to trackRating
			else
				display dialog "All questions were skipped!" buttons {"Exit"} default button 1
			end if
		end if
	on error errText number errNum
		if errNum is equal to -1731 then
			display dialog "You need to have a track playing." buttons {"Exit"} default button 1
		else
			display dialog errText & return & errNum buttons {"Exit"} default button 1
		end if
	end try
end tell

on askQuestion(questionString)
	tell application "iTunes"
		set theChoice to choose from list userChoiceList with prompt questionString OK button name "Choose" cancel button name "Skip" without multiple selections allowed and empty selection allowed
	end tell
	if theChoice is {"Great!"} then
		set theCurrentScore to (theCurrentScore + 5)
		set theTotalScore to (theTotalScore + 5)
	else if theChoice is {"Pretty Good"} then
		set theCurrentScore to (theCurrentScore + 4)
		set theTotalScore to (theTotalScore + 5)
	else if theChoice is {"Just OK"} then
		set theCurrentScore to (theCurrentScore + 3)
		set theTotalScore to (theTotalScore + 5)
	else if theChoice is {"Not Very Good"} then
		set theCurrentScore to (theCurrentScore + 2)
		set theTotalScore to (theTotalScore + 5)
	else if theChoice is {"Awful"} then
		set theCurrentScore to (theCurrentScore + 1)
		set theTotalScore to (theTotalScore + 5)
	end if
	return theCurrentScore
end askQuestion
