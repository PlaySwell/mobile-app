---------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------

local Composer = require( "composer" )
local scene = Composer.newScene()

local Btn = require( 'ui.btn' )
local TextField = require( 'ui.text_field' )
local Theme = require( 'ui.theme' )

local ShopswellHeader = require( 'ui.shopswell_header' )
local ShopswellAuth = require( 'utilities.shopswell_auth' )
local ShopswellData = require( 'utilities.shopswell_data' )


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
		title 		= 'Enter your Email to continue'
	})

	ui.keyHider = display.newRect( group, centerX, centerY, screenWidth, screenHeight )
	ui.keyHider.fill = { 1, 1, 1, 0.01 }
	ui.keyHider:addEventListener( 'touch', function(e) if e.phase == 'ended' then print( 'keyhider touched' ); native.setKeyboardFocus( nil ); end end )



	ui.submit_btn = Btn:new({
		group 		= group,
		y 			= ( screenHeight / 3 ) + 60,
		width 		= screenWidth * 0.66,
		label 		= 'Submit',	
		cornerRadius = Theme.cornerRadius,
		strokeWidth = 1,
		strokeColor = { 0.85 },
		labelColor 	= { 0.88, 0.88, 0.88 },
		labelColorPressed = { 1, 1, 1 },
		bgColor 	= Theme.colors.purple,
		bgColorPressed 	= Theme.colors.dark_purple,
		onRelease 	= function() ShopswellAuth:twitterFinalize( ui.email_field.textField.text ) end
	})


	ui.back_link = display.newText( group, 'Back', 40, screenHeight - 20, 'OpenSans', 14 )
	ui.back_link.anchorX = 0
	ui.back_link.fill = { 0.33, 0.33, 0.63 }
	function ui.back_link.tap( e )
		Composer.gotoScene( Composer.getSceneName( "previous" ), { effect = 'fromRight' } )
	end
	ui.back_link:addEventListener( 'tap', ui.back_link )


end

function scene:show( event )
	local group = self.view

	if event.phase == 'will' then

		display.setStatusBar( display.HiddenStatusBar )
		

		ui.email_field = TextField:new({
			group 		= group,
			y 			= screenHeight / 3,
			fontSize 	= 12,
			height 		= 40,
			cornerRadius = Theme.cornerRadius,
			strokeWidth = 1,
			strokeColor = { 0.85 },
			icon 		= 'assets/images/login_email_icon.png',
			iconWidth 	= 20,
			iconHeight 	= 13,
			textColor 	= { 0.33, 0.33, 0.33 },
			bgColor 	= { 1 }
		})

	
	end

	if event.phase == "did" then
	end

end

function scene:hide( event )
	if event.phase == "will" then

		native.setKeyboardFocus( nil )

		if ui.email_field ~= nil then
			ui.email_field:removeSelf()
			ui.email_field = nil
		end
	end
	
end

function scene:destroy( event )
	print( "((destroying email collect scene's view))" )
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene

