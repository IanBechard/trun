var chars : array char of boolean
var window : int
var shipSpeed : int

var shipX, shipXdodge : array 1 .. 2 of int
var shipY, shipYdodge : array 1 .. 2 of int
var shipSprite : array 1 .. 2 of int
var shipDirection : array 1 .. 2 of int

var shipImage : array 1 .. 8 of int

var lost : array 1 .. 2 of string
var titleFont, subtitleFont : int
var playImage : array 1 .. 2 of int
var instbutImage : array 1 .. 2 of int
var credbutImage : array 1 .. 2 of int
var exitImage : array 1 .. 2 of int
var playSprite, instbutSprite, credbutSprite, exitSprite : int
var x, y, b : int
var p1Score, p2Score : int

%Opening the window
window := Window.Open ("title:TRUN;graphics:max;max")
colourback (black)
cls

%Fonts
titleFont := Font.New ("OCR A STD:150:bold")
subtitleFont := Font.New ("OCR A Extended:75:italic")

%Ship images
shipImage (1) := Pic.FileNew ("ship45.gif")
shipImage (2) := Pic.FileNew ("shipUp.gif")
shipImage (3) := Pic.FileNew ("ship135.gif")
shipImage (4) := Pic.FileNew ("shipRight.gif")
shipImage (5) := Pic.FileNew ("ship225.gif")
shipImage (6) := Pic.FileNew ("shipDown.gif")
shipImage (7) := Pic.FileNew ("ship315.gif")
shipImage (8) := Pic.FileNew ("shipLeft.gif")

%Ship sprites
shipSprite (1) := Sprite.New (shipImage (2))
shipSprite (2) := Sprite.New (shipImage (2))

%Button images
playImage (1) := Pic.FileNew ("Play.gif")
playImage (2) := Pic.FileNew ("playHover.gif")

instbutImage (1) := Pic.FileNew ("Controls.gif")
instbutImage (2) := Pic.FileNew ("ControlsHover.gif")

credbutImage (1) := Pic.FileNew ("Credits.gif")
credbutImage (2) := Pic.FileNew ("CreditsHover.gif")

exitImage (1) := Pic.FileNew ("Quit.gif")
exitImage (2) := Pic.FileNew ("QuitHover.gif")

%Button sprites
playSprite := Sprite.New (playImage (1))
instbutSprite := Sprite.New (playImage (1))
credbutSprite := Sprite.New (playImage (1))
exitSprite := Sprite.New (playImage (1))

%Music
Music.PlayFileLoop ("Daft Punk- Derezzed.mp3")

%Process for movement and hit detection for ship 1
process shipUpdate
    if chars (KEY_UP_ARROW) and chars (KEY_LEFT_ARROW) and shipDirection (1) not= 5 then
	Sprite.ChangePic (shipSprite (1), shipImage (1))
	shipDirection (1) := 1
    elsif chars (KEY_UP_ARROW) and chars (KEY_RIGHT_ARROW) and shipDirection (1) not= 7 then
	Sprite.ChangePic (shipSprite (1), shipImage (3))
	shipDirection (1) := 3
    elsif chars (KEY_DOWN_ARROW) and chars (KEY_RIGHT_ARROW) and shipDirection (1) not= 1 then
	Sprite.ChangePic (shipSprite (1), shipImage (5))
	shipDirection (1) := 5
    elsif chars (KEY_DOWN_ARROW) and chars (KEY_LEFT_ARROW) and shipDirection (1) not= 3 then
	Sprite.ChangePic (shipSprite (1), shipImage (7))
	shipDirection (1) := 7
    else
	if chars (KEY_UP_ARROW) and shipDirection (1) not= 6 then
	    Sprite.ChangePic (shipSprite (1), shipImage (2))
	    shipDirection (1) := 2
	elsif chars (KEY_RIGHT_ARROW) and shipDirection (1) not= 8 then
	    Sprite.ChangePic (shipSprite (1), shipImage (4))
	    shipDirection (1) := 4
	elsif chars (KEY_DOWN_ARROW) and shipDirection (1) not= 2 then
	    Sprite.ChangePic (shipSprite (1), shipImage (6))
	    shipDirection (1) := 6
	elsif chars (KEY_LEFT_ARROW) and shipDirection (1) not= 4 then
	    Sprite.ChangePic (shipSprite (1), shipImage (8))
	    shipDirection (1) := 8
	end if
    end if

    Sprite.SetPosition (shipSprite (1), shipX (1), shipY (1), true)
    Draw.Dot (shipX (1), shipY (1), red)
    delay (shipSpeed)

    if (shipDirection (1) = 1) then
	shipXdodge (1) := -1
	shipYdodge (1) := 1
	shipX (1) := shipX (1) - 1
	shipY (1) := shipY (1) + 1
    elsif (shipDirection (1) = 2) then
	shipXdodge (1) := 0
	shipYdodge (1) := 1
	shipY (1) := shipY (1) + 1
    elsif (shipDirection (1) = 3) then
	shipXdodge (1) := 1
	shipYdodge (1) := 1
	shipX (1) := shipX (1) + 1
	shipY (1) := shipY (1) + 1
    elsif (shipDirection (1) = 4) then
	shipXdodge (1) := 1
	shipYdodge (1) := 0
	shipX (1) := shipX (1) + 1
    elsif (shipDirection (1) = 5) then
	shipXdodge (1) := 1
	shipYdodge (1) := -1
	shipX (1) := shipX (1) + 1
	shipY (1) := shipY (1) - 1
    elsif (shipDirection (1) = 6) then
	shipXdodge (1) := 0
	shipYdodge (1) := -1
	shipY (1) := shipY (1) - 1
    elsif (shipDirection (1) = 7) then
	shipXdodge (1) := -1
	shipYdodge (1) := -1
	shipX (1) := shipX (1) - 1
	shipY (1) := shipY (1) - 1
    elsif (shipDirection (1) = 8) then
	shipXdodge (1) := -1
	shipYdodge (1) := 0
	shipX (1) := shipX (1) - 1
    end if

    if (whatdotcolour (shipX (1) + shipXdodge (1), shipY (1) + shipYdodge (1)) not= black) then
	lost (1) := "y"
    end if

end shipUpdate

%Process for movement and hit detection for ship 2
process shipUpdate2
    if chars (chr (119)) and chars (chr (97)) and shipDirection (2) not= 5 then
	Sprite.ChangePic (shipSprite (2), shipImage (1))
	shipDirection (2) := 1
    elsif chars (chr (119)) and chars (chr (100)) and shipDirection (2) not= 7 then
	Sprite.ChangePic (shipSprite (2), shipImage (3))
	shipDirection (2) := 3
    elsif chars (chr (115)) and chars (chr (100)) and shipDirection (2) not= 1 then
	Sprite.ChangePic (shipSprite (2), shipImage (5))
	shipDirection (2) := 5
    elsif chars (chr (115)) and chars (chr (97)) and shipDirection (2) not= 3 then
	Sprite.ChangePic (shipSprite (2), shipImage (7))
	shipDirection (2) := 7
    else
	if chars (chr (119)) and shipDirection (2) not= 6 then
	    Sprite.ChangePic (shipSprite (2), shipImage (2))
	    shipDirection (2) := 2
	elsif chars (chr (100)) and shipDirection (2) not= 8 then
	    Sprite.ChangePic (shipSprite (2), shipImage (4))
	    shipDirection (2) := 4
	elsif chars (chr (115)) and shipDirection (2) not= 2 then
	    Sprite.ChangePic (shipSprite (2), shipImage (6))
	    shipDirection (2) := 6
	elsif chars (chr (97)) and shipDirection (2) not= 4 then
	    Sprite.ChangePic (shipSprite (2), shipImage (8))
	    shipDirection (2) := 8
	end if
    end if

    Sprite.SetPosition (shipSprite (2), shipX (2), shipY (2), true)
    Draw.Dot (shipX (2), shipY (2), blue)
    delay (shipSpeed)

    if (shipDirection (2) = 1) then
	shipXdodge (2) := -1
	shipYdodge (2) := 1
	shipX (2) := shipX (2) - 1
	shipY (2) := shipY (2) + 1
    elsif (shipDirection (2) = 2) then
	shipXdodge (2) := 0
	shipYdodge (2) := 1
	shipY (2) := shipY (2) + 1
    elsif (shipDirection (2) = 3) then
	shipXdodge (2) := 1
	shipYdodge (2) := 1
	shipX (2) := shipX (2) + 1
	shipY (2) := shipY (2) + 1
    elsif (shipDirection (2) = 4) then
	shipXdodge (2) := 1
	shipYdodge (2) := 0
	shipX (2) := shipX (2) + 1
    elsif (shipDirection (2) = 5) then
	shipXdodge (2) := 1
	shipYdodge (2) := -1
	shipX (2) := shipX (2) + 1
	shipY (2) := shipY (2) - 1
    elsif (shipDirection (2) = 6) then
	shipXdodge (2) := 0
	shipYdodge (2) := -1
	shipY (2) := shipY (2) - 1
    elsif (shipDirection (2) = 7) then
	shipXdodge (2) := -1
	shipYdodge (2) := -1
	shipX (2) := shipX (2) - 1
	shipY (2) := shipY (2) - 1
    elsif (shipDirection (2) = 8) then
	shipXdodge (2) := -1
	shipYdodge (2) := 0
	shipX (2) := shipX (2) - 1
    end if

    if (whatdotcolour (shipX (2) + shipXdodge (2), shipY (2) + shipYdodge (2)) not= black) then
	lost (2) := "y"
    end if

end shipUpdate2

loop
    %Initializing the MATCH

    x := 0
    y := 0
    b := 0

    p1Score := 0
    p2Score := 0

    %Initializing the menu
    cls

    Pic.ScreenLoad ("trun.gif", 600, 850, picMerge)
    Sprite.SetPosition (playSprite, 830, 670, false)
    Sprite.Show (playSprite)

    Sprite.SetPosition (instbutSprite, 830, 570, false)
    Sprite.Show (instbutSprite)

    Sprite.SetPosition (credbutSprite, 830, 470, false)
    Sprite.Show (credbutSprite)

    Sprite.SetPosition (exitSprite, 830, 370, false)
    Sprite.Show (exitSprite)

    Font.Draw ("Game of the Future", 400, 750, subtitleFont, 27)
    Font.Draw ("Game of the Future", 403, 753, subtitleFont, cyan)

    loop


	%Mouse Check for menu buttons
	Mouse.Where (x, y, b)

	%Menu Play Button Checking
	if (x > 830) and (x < 950) and (y > 670) and (y < 720) then
	    Sprite.ChangePic (playSprite, playImage (2))
	else
	    Sprite.ChangePic (playSprite, playImage (1))
	end if

	if (x > 830) and (x < 950) and (y > 670) and (y < 720) and (b = 1) then
	    Sprite.Hide (playSprite)
	    Sprite.Hide (instbutSprite)
	    Sprite.Hide (credbutSprite)
	    Sprite.Hide (exitSprite)
	    exit
	end if

	%Menu Controls Button Checking
	if (x > 830) and (x < 950) and (y > 570) and (y < 620) then
	    Sprite.ChangePic (instbutSprite, instbutImage (2))
	else
	    Sprite.ChangePic (instbutSprite, instbutImage (1))
	end if

	if (x > 830) and (x < 950) and (y > 570) and (y < 620) and (b = 1) then
	    Sprite.Hide (playSprite)
	    Sprite.Hide (instbutSprite)
	    Sprite.Hide (credbutSprite)
	    Sprite.Hide (exitSprite)
	    cls

	    colour (white)
	    put "Player 1 (Blue)"
	    put "W = up"
	    put "A = left"
	    put "S = Down"
	    put "D = Right"
	    put ""
	    put "Player 2 (Red)"
	    put "up arrow = up"
	    put "left arrow = left"
	    put "down arrow = Down"
	    put "right arrow = Right"
	    put ""
	    put "Protip : Use a combination if keys for diagonal movement"
	    put ""
	    put "The object of the game is to not run into any of the coloured lines and surivive longer than your opponent."
	    put ""
	    put "Press any key to go back to the main menu"
	    Input.Pause
	    cls

	    Pic.ScreenLoad ("trun.gif", 600, 850, picMerge)
	    Sprite.SetPosition (playSprite, 830, 670, false)
	    Sprite.Show (playSprite)

	    Sprite.SetPosition (instbutSprite, 830, 570, false)
	    Sprite.Show (instbutSprite)

	    Sprite.SetPosition (credbutSprite, 830, 470, false)
	    Sprite.Show (credbutSprite)

	    Sprite.SetPosition (exitSprite, 830, 370, false)
	    Sprite.Show (exitSprite)

	    Font.Draw ("Game of the Future", 400, 750, subtitleFont, 27)
	    Font.Draw ("Game of the Future", 403, 753, subtitleFont, cyan)
	end if

	%Menu Credits Button Checking
	if (x > 830) and (x < 950) and (y > 470) and (y < 520) then
	    Sprite.ChangePic (credbutSprite, credbutImage (2))
	else
	    Sprite.ChangePic (credbutSprite, credbutImage (1))
	end if

	if (x > 830) and (x < 950) and (y > 470) and (y < 520) and (b = 1) then
	    Sprite.Hide (playSprite)
	    Sprite.Hide (instbutSprite)
	    Sprite.Hide (credbutSprite)
	    Sprite.Hide (exitSprite)
	    cls

	    colour (white)
	    put "Programmed by : Ian Bechard"
	    put "Images by : Ian Bechard and Sony Pictures"
	    put "Music by : Daft Punk, Sony Pictures"
	    put "Song : Daft Punk - Derezzed"
	    colour (cyan)
	    put "-----------------------------------------"
	    colour (white)
	    put "Hello, my name is Ian Bechard, thank you for enjoying my game."
	    put "I am an aspiring programmer and gamer, and this is my first go at it."
	    put ""
	    put "Press any key to go back to main menu"
	    Pic.ScreenLoad ("ianmagic.gif", 900, 100, picCopy)
	    Input.Pause
	    cls

	    Pic.ScreenLoad ("trun.gif", 600, 850, picMerge)
	    Sprite.SetPosition (playSprite, 830, 670, false)
	    Sprite.Show (playSprite)

	    Sprite.SetPosition (instbutSprite, 830, 570, false)
	    Sprite.Show (instbutSprite)

	    Sprite.SetPosition (credbutSprite, 830, 470, false)
	    Sprite.Show (credbutSprite)

	    Sprite.SetPosition (exitSprite, 830, 370, false)
	    Sprite.Show (exitSprite)

	    Font.Draw ("Game of the Future", 400, 750, subtitleFont, 27)
	    Font.Draw ("Game of the Future", 403, 753, subtitleFont, cyan)
	end if

	%Menu Exit Button Checking
	if (x > 830) and (x < 950) and (y > 370) and (y < 420) then
	    Sprite.ChangePic (exitSprite, exitImage (2))
	else
	    Sprite.ChangePic (exitSprite, exitImage (1))
	end if

	if (x > 830) and (x < 950) and (y > 370) and (y < 420) and (b = 1) then
	    quit
	end if

    end loop

    loop
	%Initializing a ROUND
	cls

	shipX (2) := 200
	shipY (1) := 300
	shipX (1) := 1700
	shipY (2) := 300

	shipSpeed := 4

	Sprite.Show (shipSprite (1))
	Sprite.Show (shipSprite (2))

	shipDirection (1) := 2
	Sprite.ChangePic (shipSprite (1), shipImage (2))
	shipDirection (2) := 2
	Sprite.ChangePic (shipSprite (2), shipImage (2))

	shipXdodge (1) := 0
	shipYdodge (1) := 0

	lost (1) := "n"
	lost (2) := "n"

	shipXdodge (2) := 0
	shipYdodge (2) := 0



	%Actual ship checking and hit detection loop
	loop
	    Input.KeyDown (chars)
	    fork shipUpdate
	    fork shipUpdate2
	    delay (shipSpeed)

	    %Checking for loss
	    if (lost (1) = "y" or lost (2) = "y") then
		exit
	    end if
	end loop

	%Updating scores
	if (lost (1) = "y") then
	    p2Score := p2Score + 1
	end if

	if (lost (2) = "y") then
	    p1Score := p1Score + 1
	end if

	Sprite.Hide (shipSprite (1))
	Sprite.Hide (shipSprite (2))

	Font.Draw ("Score", 750, 750, subtitleFont, 27)
	Font.Draw ("Score", 753, 753, subtitleFont, cyan)

	Font.Draw (intstr (p1Score), 970, 650, subtitleFont, 27)
	Font.Draw (intstr (p1Score), 973, 653, subtitleFont, red)

	Font.Draw (intstr (p2Score), 730, 650, subtitleFont, 27)
	Font.Draw (intstr (p2Score), 733, 653, subtitleFont, blue)

	delay (3000)
	cls

	%If somebody wins the match, say so
	if (p1Score = 3) or (p2Score = 3) then
	    cls
	    if (p1Score = 3) and (p2Score = 3) then
		Font.Draw ("A Rare Tie In The Match!", 250, 750, subtitleFont, 27)
		Font.Draw ("A Rare Tie In The Match!", 253, 753, subtitleFont, cyan)
	    elsif (p1Score = 3) then
		Font.Draw ("Red Bike Wins the Match!", 250, 750, subtitleFont, 27)
		Font.Draw ("Red Bike Wins the Match!", 253, 753, subtitleFont, red)
	    elsif (p2Score = 3) then
		Font.Draw ("Blue Bike Wins the Match!", 250, 750, subtitleFont, 27)
		Font.Draw ("Blue Bike Wins the Match!", 253, 753, subtitleFont, blue)
	    end if
	    delay (3000)
	    exit
	end if
    end loop
end loop



