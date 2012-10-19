(*
Find Album Artwork With Google - Version 2.5
By Brett O'Connor
http://www.negatendo.net/~brett/ - bretto@blimpsgo90.com

Released under the MIT License:

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 

August 12, 2006
*)
-- you may want to experiment with these properties to refine your searches!
property limit_to_size : false --if set to true, will only serch for images described in image_size
property image_size : "" --can be 'xxlarge' 'medium' 'icon' or leave empty for all sizes
property limit_to_domain : false --if set to true, will have Google search only in the domain described in search_domain
property search_domain : "amazon.com" --search for images only in a certian domain/website, such as 'amazon.com' or 'artistdirect.com'

-- you probably don't want to change anything below here
property required_version : "4.0"
property search_URL : "http://images.google.com/images?ie=ISO-8859-1&hl=en&btnG=Google+Search&q="

tell application "iTunes"
	try
		set this_version to the version as string
		if this_version is not greater than or equal to the required_version then
			beep
			display dialog "This script requires iTunes version: " & required_version & Â
				return & return & Â
				"Current version of iTunes: " & this_version buttons {"Update", "Cancel"} default button 2 with icon 2
			if the button returned of the result is "Update" then
				my access_website("http://www.apple.com/itunes/download/")
				return "incorrect version"
			end if
		end if
		if visuals enabled then
			if player state is playing then
				set this_track to the current track
			else
				error "There is no song playing."
			end if
		else
			set these_tracks to the selection of browser window 1
			if these_tracks is {} then error "No tracks are selected in the front window."
			-- they can select multiple tracks, but only the first will be looked up
			set this_track to item 1 of these_tracks
		end if
		set the_album to (the album of this_track) as string
		set the_artist to (the artist of this_track) as string
		-- search for artist if no album name
		if the_album is "" then
			set this_searchstring to the_artist as string
		else if the_artist is "" then
			set this_searchstring to the_album as string
		else
			set this_searchstring to (the_artist & " " & the_album)
		end if
	on error error_message number error_number
		if the error_number is not -128 then
			beep
			display dialog error_message buttons {"Cancel"} default button 1
		else
			error number -128
		end if
	end try
end tell
set the encoded_string to my encode_text(this_searchstring, false, false)
if limit_to_size is true and limit_to_domain is true then
	set the final_url to (search_URL & encoded_string & "&as_sitesearch=" & search_domain & "&imgsz=" & image_size)
else if limit_to_size is true and limit_to_domain is false then
	set the final_url to (search_URL & encoded_string & "&imgsz=" & image_size)
else if limit_to_size is false and limit_to_domain is true then
	set the final_url to (search_URL & encoded_string & "&as_sitesearch=" & search_domain)
else
	set the final_url to (search_URL & encoded_string)
end if
tell me to access_website(final_url)

property isomac : {"A5", "AA", "AD", "B0", "B3", "B7", "BA", "BD", "C3", "C5", "C9", "D1", "D4", "D9", "DA", "B6", "C6", "CE", "E2", "E3", "E4", "F0", "F6", "F7", "F9", "FA", "FB", "FD", "FE", "FF", "F5", "C4", "CA", "C1", "A2", "A3", "DB", "B4", "CF", "A4", "AC", "A9", "BB", "C7", "C2", "D0", "A8", "F8", "A1", "B1", "D3", "D2", "AB", "B5", "A6", "E1", "FC", "D5", "BC", "C8", "B9", "B8", "B2", "C0", "CB", "E7", "E5", "CC", "80", "81", "AE", "82", "E9", "83", "E6", "E8", "ED", "EA", "EB", "EC", "DC", "84", "F1", "EE", "EF", "CD", "85", "D7", "AF", "F4", "F2", "F3", "86", "A0", "DE", "A7", "88", "87", "89", "8B", "8A", "8C", "BE", "8D", "8F", "8E", "90", "91", "93", "92", "94", "95", "DD", "96", "98", "97", "99", "9B", "9A", "D6", "BF", "9D", "9C", "9E", "9F", "E0", "DF", "D8"}
property maciso : {"C4", "C5", "C7", "C9", "D1", "D6", "DC", "E1", "E0", "E2", "E4", "E3", "E5", "E7", "E9", "E8", "EA", "EB", "ED", "EC", "EE", "EF", "F1", "F3", "F2", "F4", "F6", "F5", "FA", "F9", "FB", "FC", "DD", "20", "A2", "A3", "A7", "80", "B6", "DF", "AE", "A9", "81", "B4", "A8", "82", "C6", "D8", "83", "B1", "BE", "84", "A5", "B5", "8F", "85", "BD", "BC", "86", "AA", "BA", "87", "E6", "F8", "BF", "A1", "AC", "88", "9F", "89", "90", "AB", "BB", "8A", "A0", "C0", "C3", "D5", "91", "A6", "AD", "8B", "B3", "B2", "8C", "B9", "F7", "D7", "FF", "8D", "8E", "A4", "D0", "F0", "DE", "FE", "FD", "B7", "92", "93", "94", "C2", "CA", "C1", "CB", "C8", "CD", "CE", "CF", "CC", "D3", "D4", "95", "D2", "DA", "DB", "D9", "9E", "96", "97", "AF", "98", "99", "9A", "B8", "9B", "9C", "9D"}
property hex_list : {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"}

on encode_char(this_char)
	set the ASCII_num to (the ASCII number this_char)
	set z to item (ASCII_num - 127) of maciso
	return ("%" & z) as string
end encode_char

on encode_text(this_text, encode_URL_A, encode_URL_B)
	set the standard_characters to Â
		"abcdefghijklmnopqrstuvwxyz0123456789"
	set the URL_A_chars to "$+!'/?;&@=#%><{}[]\"~`^\\|*"
	set the URL_B_chars to ".-_:"
	set the acceptable_characters to the standard_characters
	if encode_URL_A is false then Â
		set the acceptable_characters to Â
			the acceptable_characters & the URL_A_chars
	if encode_URL_B is false then Â
		set the acceptable_characters to Â
			the acceptable_characters & the URL_B_chars
	set the encoded_text to ""
	repeat with this_char in this_text
		if this_char is in the acceptable_characters then
			set the encoded_text to Â
				(the encoded_text & this_char)
		else
			set the encoded_text to Â
				(the encoded_text & encode_char(this_char)) as string
		end if
	end repeat
	return the encoded_text
end encode_text

on access_website(theURL)
	try -- Jaguar default browser
		tell application "Finder"
			open location theURL
		end tell
	on error -- Panther and up default browser
		tell application "System Events"
			open location theURL
		end tell
	end try
end access_website