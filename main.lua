-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- TODO
-- http://stackoverflow.com/questions/16415422/how-to-diable-webview-zoom-property-in-corona

_v = '0.8'


centerX = display.contentCenterX
centerY = display.contentCenterY
screenWidth = display.contentWidth
screenHeight = display.contentHeight

-- THIS IS TO FIND OUT IF THE APP RUNS ON A TABLET OR A SMALL DISPLAY
-- IF WE HAVE A TABLET, SCALE DOWN THE GUI TO THE HALF, OTHERWISE THE
-- WIDGETS APPEAR TOO BIG. YOU CAN USE ANY SCALE, BUT .5 IS FINE HERE.
-- CHANGING THE SCALE OF A WIDGET DOES NOT CHANGE ITS WIDTH OR HEIGHT,
-- IT JUST SCALES THE WIDGET GRAPHICS USED (BORDERS, ICONS, TEXT ETC.)
local physicalW = math.round( (display.contentWidth  - display.screenOriginX*2) / display.contentScaleX)
local physicalH = math.round( (display.contentHeight - display.screenOriginY*2) / display.contentScaleY)

_G.isTablet     = false; if physicalW >= 1024 or physicalH >= 1024 then isTablet = true end
_G.GUIScale     = _G.isTablet == true and .5 or 1.0


local Composer = require "composer"
local TabBar = require 'ui.tab_bar'
local Theme = require 'ui.theme'

local ShopswellData = require( "utilities.shopswell_data" )
user_data = ShopswellData:load()

local Debug = require "utilities.debug"


print ( "Physical Device Width: " .. physicalW )
print ( "Physical Device Height: " .. physicalH ) 

print( "Screen Height: " .. screenHeight )
print( "Screen Width: " .. screenWidth )

print( "Scale Factor: " .. display.pixelWidth / display.actualContentWidth )
print( "Status Bar Height: " .. display.topStatusBarContentHeight )



externalURL = false

function webViewListener( e )

	if string.match( e.url, "_shopswell_external_link=1" ) and not( externalURL ) then
		print( "Opening external url..." )
		currentView:stop()
		externalURL = true
		system.openURL( e.url )
		return true
	elseif e.type == 'loaded' then
		externalURL = false 
		--tab_bar.debug.text = "Current WebView is: " .. currentView.name .. " Requesting: " .. e.url
	end
end

homeView = native.newWebView( centerX, centerY, screenWidth, Theme.webViewHeight )
homeView.anchorY = 0
homeView.y = 50000
homeView.base_url = "https://www.shopswell.com/feed?dvar=mobile_app"
homeView.name = 'homeView'

browseView = native.newWebView( centerX, centerY, screenWidth, Theme.webViewHeight )
browseView.anchorY = 0
browseView.y = 50000
browseView.base_url = "https://www.shopswell.com/browse?dvar=mobile_app"
browseView:addEventListener( 'urlRequest', webViewListener )
browseView.name = 'browseView'

questionsView = native.newWebView( centerX, centerY, screenWidth, Theme.webViewHeight )
questionsView.anchorY = 0
questionsView.y = 50000
questionsView.base_url = "https://www.shopswell.com/questions?dvar=mobile_app"
questionsView:addEventListener( 'urlRequest', webViewListener )
questionsView.name = 'questionsView'

profileView = native.newWebView( centerX, centerY, screenWidth, Theme.webViewHeight )
profileView.anchorY = 0
profileView.y = 50000
profileView.base_url = "https://www.shopswell.com/people/"
profileView:addEventListener( 'urlRequest', webViewListener )
profileView.name = 'profileView'

currentView = homeView


tab_bar = TabBar:new({})

tab_bar:hide()


local printMemUsage = function()  
    local memUsed = (collectgarbage("count"))
    local texUsed = system.getInfo( "textureMemoryUsed" ) / 1048576 -- Reported in Bytes
   
    print("\n---------MEMORY USAGE INFORMATION---------")
    print("System Memory: ", string.format("%.00f", memUsed), "KB")
    print("Texture Memory:", string.format("%.03f", texUsed), "MB")
    print("------------------------------------------\n")
end

-- Only load memory monitor if running in simulator
-- if (system.getInfo("environment") == "simulator") then
-- 	timer.performWithDelay( 2000, printMemUsage, -1 )
-- end

-- handle android key events
local function onKeyPress( event )

	local phase = event.phase
	local key_name = event.keyName

	-- nest these crazy ifs so we always return true s oAndroid doesn't grab the 'down' phase
	if key_name == "back" then
		if phase == 'up' then
			if Composer.getVariable( 'overlay' ) then
					Composer.hideOverlay( 'slideRight' )
			else
				if Composer.getSceneName( 'current' ) == 'scenes.login' or Composer.getSceneName( 'current' ) == 'scenes.home' then
					native.requestExit()
				elseif Composer.getSceneName( 'current' ) == 'scenes.browse' or Composer.getSceneName( 'current' ) == 'scenes.questions' or Composer.getSceneName( 'current' ) == 'scenes.menu' then
					Composer.gotoScene( 'scenes.home' )
				else
					Composer.gotoScene( 'scenes.login' )
				end
			end
		end
		return true
	else
		return false
	end
end
--add the key callback
Runtime:addEventListener( "key", onKeyPress )


Composer.gotoScene( 'scenes.login' )


