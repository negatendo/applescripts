(*
Random Subject - Version 1.1
By Dogheadbone LLC
http://www.dogheadbone.com/ - support@dogheadbone.com

Random Subject is a script for Mail.app that creates a new message with a random subject.  It's for people who either can't figure out what to title their message, or just need something to write about.

October 4, 2003
*)

tell application "Mail"
	-- of course, feel free to modify these
	set wordListOne to {"The Only", "Orphan", "The Ogre-like", "In Regards to", "The River Called", "Astral", "On", "Concerning", "Please Send", "Ancient", Â
		"The Politics of", "The Queen of the", "Clan of the", "Kinky"} as list
	set wordListTwo to {"Flower Petals", "Cities", "Sewage", "Orange Juice", "Parachute Pants", "Rockstars", "Sweaters", "Beer", "Zombie Brains", "DJs", Â
		"Candles", "Ninjas"} as list
	set wordListThree to {"of Doom", "Made by Llamas", "from Canada", "From the Year 2000", "from Space", "from the Stone Age", "from Mars", "by the Seaside", Â
		"Rigerous Training", "Came via Airmail", "- THE MOVIE!"} as list
	set wordOne to some item of wordListOne as string
	set wordTwo to some item of wordListTwo as string
	set wordThree to some item of wordListThree as string
	set theSubject to wordOne & " " & wordTwo & " " & wordThree
	set newMessage to make new outgoing message with properties {subject:theSubject}
	tell newMessage
		set visible to true
	end tell
	activate
end tell
