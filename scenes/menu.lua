---------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------

local Composer = require( "composer" )
local scene = Composer.newScene()

local fa = require 'ui.font_awesome'

local Btn = require( 'ui.btn' )
local Theme = require( 'ui.theme' )
local FileUtils = require( "utilities.file" )
local ShopswellData = require( 'utilities.shopswell_data' )

local device = require ( 'utilities.device' )


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local ui = {}
local user_data 

local function logout()
	ShopswellData:save( nil )

	tab_bar:select_button( tab_bar.buttons[1] )

	if not( device.isSimulator ) then
		local Facebook = require( 'plugin.facebook.v4' )
		local Twitter = require( 'plugin.twitter' )
		Facebook.logout()
		Twitter.logout()
	end

	local logout_url = "https://www.shopswell.com/logout"
	homeView:request( logout_url )
	homeView:deleteCookies()
	browseView:request( logout_url )
	browseView:deleteCookies()
	questionsView:request( logout_url )
	questionsView:deleteCookies()
	profileView:request( logout_url )
	profileView:deleteCookies()

	Composer.removeScene( 'scenes.home' )
	Composer.removeScene( 'scenes.browse' )
	Composer.removeScene( 'scenes.questions' )
	Composer.removeScene( 'scenes.search' )

	Composer.gotoScene( 'scenes.login', { effect='fromTop'} )
end

-- Called when the scene's view does not exist:
function scene:create( event )
	local group = self.view

	local user_data = ShopswellData:load()

	ui.bg = display.newRect( group, centerX, centerY, screenWidth, screenHeight )
	ui.bg.fill = Theme.colors.purple

	ui.bg2 = display.newRect( group, centerX, display.topStatusBarContentHeight, screenWidth, screenHeight )
	ui.bg2.anchorY = 0
	ui.bg2.fill = Theme.colors.darkest_blue

	local y = Theme.menuStartY

	ui.profile_btn = Btn:new({
		group 		= group,
		y 			= y,
		width 		= screenWidth - 20,
		imageIcon 	= 'assets/images/icons/icon_profile1_white.png',
		iconX 		= 30,
		labelX 		= 90,
		labelAnchorX = 0,
		label 		= 'Profile',
		fontSize 	= 24, 
		cornerRadius = 0,
		bgColor 	= Theme.colors.darkest_blue,
		bgColorPressed 	= Theme.colors.dark_blue,
		labelColor 	= { 0.8 },
		labelColorPressed 	= { 1},
		onRelease 	= function() system.openURL( 'https://www.shopswell.com/people/' .. user_data.name .. "/content?dvar=mobile_web&" .. "api_access_token=" .. user_data.token ) end
		})

	y = y + 30

	ui.separator = display.newLine( group, 10, y, screenWidth-10, y )
	ui.separator.strokeWidth = 1
	ui.separator:setStrokeColor( 0.5 )

	y = y + 30

	ui.publish_btn = Btn:new({
		group 		= group,
		y 			= y,
		width 		= screenWidth - 20,
		imageIcon 	= 'assets/images/icons/icon_content.png',
		iconX 		= 30,
		labelX 		= 90,
		labelAnchorX = 0,
		label 		= 'Publish',
		fontSize 	= 24, 
		cornerRadius = 0,
		bgColor 	= Theme.colors.darkest_blue,
		bgColorPressed 	= Theme.colors.dark_blue,
		labelColor 	= { 0.8 },
		labelColorPressed 	= { 1},
		onRelease 	= function() system.openURL( "https://www.shopswell.com/home/content?dvar=mobile_web&api_access_token=" .. user_data.token ) end
		})





	y = y + 30

	ui.separator = display.newLine( group, 10, y, screenWidth-10, y )
	ui.separator.strokeWidth = 1
	ui.separator:setStrokeColor( 0.5 )

	y = y + 30

	ui.rewards_btn = Btn:new({
		group 		= group,
		y 			= y,
		width 		= screenWidth - 20,
		imageIcon 	= 'assets/images/icons/icon_reward.png',
		iconX 		= 30,
		labelX 		= 90,
		labelAnchorX = 0,
		label 		= 'Rewards Program',
		fontSize 	= 24, 
		cornerRadius = 0,
		bgColor 	= Theme.colors.darkest_blue,
		bgColorPressed 	= Theme.colors.dark_blue,
		labelColor 	= { 0.8 },
		labelColorPressed 	= { 1},
		onRelease 	= function() system.openURL( "https://www.shopswell.com/rewards_program?dvar=mobile_web&api_access_token=" .. user_data.token ) end
		})

	y = y + 30

	ui.separator = display.newLine( group, 10, y, screenWidth-10, y )
	ui.separator.strokeWidth = 1
	ui.separator:setStrokeColor( 0.5 )

	y = y + 30

	ui.settings_btn = Btn:new({
		group 		= group,
		y 			= y,
		width 		= screenWidth - 20,
		imageIcon 	= 'assets/images/icons/icon_settings_white.png',
		iconX 		= 30,
		labelX 		= 90,
		labelAnchorX = 0,
		label 		= 'Settings',
		fontSize 	= 24, 
		cornerRadius = 0,
		bgColor 	= Theme.colors.darkest_blue,
		bgColorPressed 	= Theme.colors.dark_blue,
		labelColor 	= { 0.8 },
		labelColorPressed 	= { 1 },
		onRelease 	= function() system.openURL( "https://www.shopswell.com/home/settings?dvar=mobile_web&api_access_token=" .. user_data.token ) end
		})

	y = y + 30

	ui.separator = display.newLine( group, 10, y, screenWidth-10, y )
	ui.separator.strokeWidth = 1
	ui.separator:setStrokeColor( 0.5 )

	y = y + 30

	ui.about_btn = Btn:new({
		group 		= group,
		y 			= y,
		width 		= screenWidth - 20,
		imageIcon 	= 'assets/images/icons/icon_aboutUs_white.png',
		iconWidth 	= 75,
		iconHeight 	= 75,
		iconScale 	= 0.333,
		iconX 		= 30,
		labelX 		= 90,
		labelAnchorX = 0,
		label 		= 'About Shopswell',
		fontSize 	= 24, 
		cornerRadius = 0,
		bgColor 	= Theme.colors.darkest_blue,
		bgColorPressed 	= Theme.colors.dark_blue,
		labelColor 	= { 0.8 },
		labelColorPressed 	= { 1 },
		onRelease = function() Composer.gotoScene( 'scenes.about' ) end
		})



	ui.separator = display.newLine( group, 10, Theme.menuLogoutY-30, screenWidth-10, Theme.menuLogoutY-30 )
	ui.separator.strokeWidth = 1
	ui.separator:setStrokeColor( 0.5 )

	ui.logout_btn = Btn:new({
		group 		= group,
		y 			= Theme.menuLogoutY,
		width 		= screenWidth - 20,
		imageIcon 	= 'assets/images/icons/icon_logout.png',
		iconX 		= 30,
		labelX 		= 90,
		labelAnchorX = 0,
		label 		= 'Logout',
		fontSize 	= 24, 
		cornerRadius = 0,
		bgColor 	= Theme.colors.darkest_blue,
		bgColorPressed 	= Theme.colors.dark_blue,
		labelColor 	= { 0.8 },
		labelColorPressed 	= { 1 },
		onRelease 	= logout
		})

	ui.separator = display.newLine( group, 10, Theme.menuLogoutY+30, screenWidth-10, Theme.menuLogoutY+30 )
	ui.separator.strokeWidth = 1
	ui.separator:setStrokeColor( 0.5 )


end

function scene:show( event )
	local group = self.view

	if event.phase == "will" then

		print( "showing menu...." )
		print( "current view is: " .. currentView.name )

		display.setStatusBar( display.TranslucentStatusBar )


		currentView.y = 50000
		tab_bar:select_scene( 'scenes.menu' )
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