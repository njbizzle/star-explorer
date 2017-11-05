
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoGame()
    composer.removeScene( "game" )
	composer.gotoScene( "game", { time=800, effect="crossFade" }  )
end
 
local function gotoHighScores()
	composer.removeScene( "highscores" )
    composer.gotoScene( "highscores", { time=800, effect="crossFade" }  )
end

-- Forward declaration for the sounds
local musicTrack

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	-- Load the background into composer's scene display group
	local background = display.newImageRect( sceneGroup, "images/background.png", 800, 1400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	-- Load the title into composer's scene display group 
	local title = display.newImageRect( sceneGroup, "images/title.png", 500, 80 )
	title.x = display.contentCenterX
	title.y = 200

	-- Add a button that starts the game when pressed
	local playButton = display.newText( sceneGroup, "Play", display.contentCenterX, 700, native.systemFont, 44 )
	playButton:setFillColor( 0.82, 0.86, 1 )
 
	-- Add a button that displays highscores when pressed
	local highScoresButton = display.newText( sceneGroup, "High Scores", display.contentCenterX, 810, native.systemFont, 44 )
	highScoresButton:setFillColor( 0.75, 0.78, 1 )

	-- Add event listeners for play and highscore that call functions to go to the correct scene
	playButton:addEventListener( "tap", gotoGame )
	highScoresButton:addEventListener( "tap", gotoHighScores )

    -- Load the sounds
    musicTrack = audio.loadStream( "audio/Escape_Looping.wav")

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
 
        -- Start the music!
 		audio.setVolume( 0.5, { channel=1 } )
        audio.play( musicTrack, { channel=1, loops=-1 } )        

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
  
        -- Stop the music!
        audio.stop( 1 )
		
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

    -- Dispose audio!
    audio.dispose( musicTrack )
 
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
