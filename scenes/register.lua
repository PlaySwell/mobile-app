---------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------

local Composer = require( "composer" )
local scene = Composer.newScene()

local Btn = require( 'ui.btn' )
local Theme = require( 'ui.theme' )
local TextField = require( 'ui.text_field' )

local ShopswellHeader = require( 'ui.shopswell_header' )
local ShopswellAuth = require( 'utilities.shopswell_auth' )
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local ui = {}

-- Called when the scene's view does not exist:
function scene:create( event )
	local group = self.view

	ui.bg = display.newRect( group, 0, 0, screenWidth, screenHeight )
	ui.bg:setFillColor( 1 )
	ui.bg.x = centerX
	ui.bg.y = centerY

	ui.header = ShopswellHeader:new({
		group 		= group,
		tagline 	= false,
		title 		= 'Email Sign Up'
	})
	function ui.header.tap( e )
		Composer.gotoScene( 'scenes.login', { effect = 'fromLeft' } )
	end
	ui.header:addEventListener( 'tap', ui.header )


	ui.keyHider = display.newRect( group, centerX, centerY, screenWidth, screenHeight )
	ui.keyHider.fill = { 1, 1, 1, 0.01 }
	ui.keyHider:addEventListener( 'touch', function(e) if e.phase == 'ended' then print( 'keyhider touched' ); native.setKeyboardFocus( nil ); end end )




	ui.submit_btn = Btn:new({
		group 		= group,
		y 			= Theme.register.regBtnY,
		width 		= screenWidth * 0.66,
		label 		= 'Register',	
		fontSize 	= 20,
		cornerRadius = Theme.cornerRadius,
		labelColor 	= { 0.88, 0.88, 0.88 },
		labelColorPressed = { 1, 1, 1 },
		bgColor 	= Theme.colors.purple,
		bgColorPressed 	= Theme.colors.dark_purple,
		onRelease 	= function() ShopswellAuth:signup( ui.name_field.textField.text, ui.email_field.textField.text, ui.pw_field.textField.text ) end
	})


	ui.header.title.anchorX = 0
	print( "the x is: " .. ui.submit_btn.bg.x - ( ui.submit_btn.bg.contentWidth / 2 ) )
	ui.header.title.x = ui.submit_btn.bg.x - ( ui.submit_btn.bg.contentWidth / 2 )




	ui.cancel_link = display.newText( group, 'Back', 10, 15, 'OpenSans', 14 )
	ui.cancel_link.anchorX = 0
	ui.cancel_link.x = 16
	ui.cancel_link.fill = { 0.33, 0.33, 0.63 }
	function ui.cancel_link.tap( e )
		Composer.gotoScene( 'scenes.login', { effect = 'fromLeft' } )
	end
	ui.cancel_link:addEventListener( 'tap', ui.cancel_link )

end

function scene:show( event )
	local group = self.view

	if event.phase == 'will' then

		display.setStatusBar( display.HiddenStatusBar )

		
		ui.name_field = TextField:new({
			group 		= group,
			y 			= Theme.register.userNameY,
			font 		= 'OpenSans-Light',
			fontSize 	= 14,
			height 		= 40,
			cornerRadius = Theme.cornerRadius,
			strokeWidth = 1,
			strokeColor = { 0.85 },
			icon 		= 'assets/images/icons/icon_profile1.png',
			iconSourceWidth = 75,
			iconSourceHeight = 75,
			iconWidth 	= 25,
			iconHeight 	= 25,
			textColor 	= { 0.33, 0.33, 0.33 },
			bgColor 	= { 1, 1, 1 }
		})


		ui.email_field = TextField:new({
			group 		= group,
			y 			= Theme.register.emailY,
			font 		= 'OpenSans-Light',
			fontSize 	= 14,
			height 		= 40,
			cornerRadius = Theme.cornerRadius,
			strokeWidth = 1,
			strokeColor = { 0.85 },
			icon 		= 'assets/images/icons/icon_email_login.png',
			iconSourceWidth = 75,
			iconSourceHeight = 75,
			iconWidth 	= 25,
			iconHeight 	= 25,
			textColor 	= { 0.33, 0.33, 0.33 },
			bgColor 	= { 1, 1, 1 }
		})

		ui.pw_field = TextField:new({
			group 		= group,
			y 			= Theme.register.pwY,
			font 		= 'OpenSans-Light',
			fontSize 	= 14,
			height 		= 40,
			cornerRadius = Theme.cornerRadius,
			strokeWidth = 1,
			strokeColor = { 0.85 },
			isSecure 	= true,
			--label 		= 'Username or Email',
			icon 		= 'assets/images/icons/icon_passwordKey.png',
			iconSourceWidth = 75,
			iconSourceHeight = 75,
			iconWidth 	= 25,
			iconHeight 	= 25,
			textColor 	= { 0.33, 0.33, 0.33 },
			bgColor 	= { 1, 1, 1 }
		})

	end

	if event.phase == "did" then
	
	end

end

function scene:hide( event )
	if event.phase == "will" then
		
		native.setKeyboardFocus( nil )

		ui.name_field:removeSelf()
		ui.email_field:removeSelf()
		ui.pw_field:removeSelf()

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

