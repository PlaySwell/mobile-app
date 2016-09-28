---------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------

local Composer = require( "composer" )
local scene = Composer.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
local ShopswellData = require( 'utilities.shopswell_data' )
local Theme = require( 'ui.theme' )
local ui = {}

-- Called when the scene's view does not exist:
function scene:create( event )
	local group = self.view

	local user_data = ShopswellData:load()

	local url = homeView.base_url .. "&" .. "api_access_token=" .. user_data.token
	--native.showAlert( 'Opening URL', url, { 'Ok' } )
	homeView:request( url )

	ui.bg = display.newRect( group, centerX, centerY, screenWidth, screenHeight )
	ui.bg.fill = Theme.colors.purple

end

function scene:show( event )
	local group = self.view

	if event.phase == 'will' then 
		currentView.y = 50000
		currentView = homeView
		display.setStatusBar( display.TranslucentStatusBar )
		currentView.y = Theme.webViewY
		tab_bar:select_scene( 'scenes.home' ) 
	end

	if event.phase == "did" then
		tab_bar:show()

	end
	
end

function scene:hide( event )
	if event.phase == "will" then

	end
	
end

function scene:destroy( event )

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene