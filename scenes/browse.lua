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

	local url = browseView.base_url .. "&" .. "api_access_token=" .. user_data.token
	--native.showAlert( 'Opening URL', url, { 'Ok' } )
	browseView:request( url )

	ui.bg = display.newRect( group, centerX, centerY, screenWidth, screenHeight )
	ui.bg.fill = Theme.colors.purple
	
end

function scene:show( event )
	local group = self.view

	if event.phase == "will" then 
		currentView.y = 50000
		currentView = browseView
		display.setStatusBar( display.TranslucentStatusBar )
		currentView.y = Theme.webViewY
		tab_bar:select_scene( 'scenes.browse' ) 
	end

	if event.phase == "did" then
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