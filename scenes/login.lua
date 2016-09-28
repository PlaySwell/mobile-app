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
local user_data

-- Called when the scene's view does not exist:
function scene:create( event )
	local group = self.view

	ui.bg = display.newRect( group, 0, 0, screenWidth, screenHeight )
	ui.bg:setFillColor( 1 )
	ui.bg.x = centerX
	ui.bg.y = centerY

	

	ui.header = ShopswellHeader:new({
		group 		= group,
		animate		= true,
		tagline 	= false,
		title 		= 'Register or Sign In'
	})

	ui.keyHider = display.newRect( group, centerX, centerY, screenWidth, screenHeight )
	ui.keyHider.fill = { 1, 1, 1, 0.01 }
	ui.keyHider:addEventListener( 'touch', function(e) if e.phase == 'ended' then print( 'keyhider touched' ); native.setKeyboardFocus( nil ); end end )


	ui.facebook_btn = Btn:new({
		group 		= group,
		y 			= Theme.login.fbY,
		width 		= screenWidth * 0.66,
		label 		= 'facebook',
		fontSize 	= 20,
		cornerRadius = Theme.cornerRadius,
		imageIcon 	= 'assets/images/login_facebook_icon.png',
		iconWidth 	= 12,
		iconHeight 	= 20,
		labelColor 	= { 0.88, 0.88, 0.88 },
		labelColorPressed = { 1, 1, 1 },
		bgColor 	= { 58/255, 90/255, 158/255 },
		bgColorPressed = { 28/255, 60/255, 128/255 },
		onRelease 	= function() ShopswellAuth:facebookAuth() end

	})

	ui.header.title.anchorX = 0
	ui.header.title.x = ui.facebook_btn.bg.x - ( ui.facebook_btn.bg.contentWidth / 2 )

	-- ui.twitter_btn = Btn:new({
	-- 	group 		= group,
	-- 	y 			= Theme.login.twY,
	-- 	width 		= screenWidth * 0.66,
	-- 	label 		= 'twitter',
	-- 	fontSize 	= 20,
	-- 	cornerRadius = Theme.cornerRadius,
	-- 	imageIcon 	= 'assets/images/login_twitter_icon.png',
	-- 	iconWidth 	= 20,
	-- 	iconHeight 	= 17,
	-- 	labelColor 	= { 0.88, 0.88, 0.88 },
	-- 	labelColorPressed = { 1, 1, 1 },
	-- 	bgColor 	= { 24/255, 167/255, 226/255 },
	-- 	bgColorPressed = { 0/255, 137/255, 196/255 },
	-- 	onRelease 	= function() ShopswellAuth:twitterAuth() end

	-- })

	ui.submit_btn = Btn:new({
		group 		= group,
		y 			= Theme.login.loginBtnY,
		width 		= screenWidth * 0.66,
		fontSize 	= 20,
		label 		= 'Sign in with email',	
		cornerRadius 	= Theme.cornerRadius,
		labelColor 	= { 0.88, 0.88, 0.88 },
		labelColorPressed = { 1, 1, 1 },
		bgColor 	= Theme.colors.purple,
		bgColorPressed 	= Theme.colors.dark_purple,
		onRelease 	= function() ShopswellAuth:login( ui.name_field.textField.text, ui.pw_field.textField.text ) end
	})

	ui.reg_btn = Btn:new({
		group 		= group,
		y 			= Theme.login.regBtnY,
		width 		= screenWidth * 0.66,
		label 		= "Don't have an account?",	
		cornerRadius  = Theme.cornerRadius,
		strokeWidth 	= 2,
		strokeColor 	= { 0.85, 0.85, 0.85, 1 },
		labelColor 	= { 0.3, 0.3, 0.3 },
		labelColorPressed = { 1, 1, 1 },
		bgColor 	= { 1, 1, 1, 1 },
		bgColorPressed 	= { 0.75, 0.75, 0.75, 1 },
		onRelease 	= function() Composer.gotoScene( 'scenes.register', { effect = 'fromRight' } ) end,
	})


	ui.learn_more = display.newText( group, 'Learn More', centerX, Theme.login.footerY, 'OpenSans', 16 )
	ui.learn_more.fill = { 0.33, 0.33, 0.66 }
	ui.learn_more.tap = function( e ) Composer.gotoScene( 'scenes.about' ); end
	ui.learn_more:addEventListener( 'tap', ui.learn_more )

	ui.forgot = display.newText( group, 'Forgot Password?', centerX, Theme.login.forgot, 'OpenSans', 16 )
	ui.forgot.fill = { 0.33, 0.33, 0.66 }
	local function forgot_touch( e )
		print( e.phase )
		if e.phase == 'ended' then 
			system.openURL( 'https://www.shopswell.com/users/password/new' )
		end
	end
	ui.forgot:addEventListener( 'touch', forgot_touch )

end

function scene:show( event )
	local group = self.view

	if event.phase == 'will' then

		display.setStatusBar( display.HiddenStatusBar )

		tab_bar:hide()

		user_data = ShopswellData:load()
		if user_data.token then
			Composer.gotoScene( "scenes.home" )
			return false
		end

		ui.name_field = TextField:new({
			group 		= group,
			y 			= Theme.login.emailY,
			-- font 		= 'OpenSans-Light',
			fontSize 	= 12,
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
			y 			= Theme.login.pwY,
			-- font 		= 'OpenSans-Light',
			strokeWidth = 1,
			strokeColor = { 0.85 },
			fontSize 	= 12,
			cornerRadius = Theme.cornerRadius,
			isSecure 	= true,
			icon 		= 'assets/images/icons/icon_passwordKey.png',
			iconSourceWidth = 75,
			iconSourceHeight = 75,
			iconWidth  	= 25,
			iconHeight 	= 25,
			height 		= 40,
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

		if ui.name_field ~= nil then ui.name_field:removeSelf() end
		if ui.pw_field ~= nil then ui.pw_field:removeSelf() end
	end

	if event.phase == "did" then
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

