
local device = require( 'utilities.device' )

local logoY = 40

local tabBarHeight = 55

local webViewY
local webViewHeight

if device.isApple then 
	tabBarY = screenHeight - tabBarHeight 
	webViewY = 0 + display.topStatusBarContentHeight
	
	webViewHeight = screenHeight - tabBarHeight - display.topStatusBarContentHeight

	menuStartY = 60
	menuLogoutY = screenHeight - 120
else 
	tabBarY = display.topStatusBarContentHeight
	webViewY = tabBarHeight + display.topStatusBarContentHeight

	webViewHeight = screenHeight - tabBarHeight - display.topStatusBarContentHeight

	menuStartY = 110
	menuLogoutY = screenHeight - 60
end

print( "Screen Height = " .. screenHeight )
print( "WebViewY = " .. webViewY )
print( "Tab Bar Height = " .. tabBarHeight )
print( "WebViewHeight = " .. webViewHeight )

local T = {
	font 		= 'OpenSans',
	fonts 		= { 
		regular 	= 'OpenSans',
		light 		= 'OpenSans-Light',
		bold 		= 'OpenSans-Bold',
	},
	colors 		= {
		purple 		= { 149/255, 100/255, 158/255, 1 },
		lt_purple 	= { 219/255, 170/255, 228/255, 1 },
		dark_purple = { 99/255, 50/255, 108/255, 1 },
		dark_blue 	= { 43/255, 48/255, 62/255 },
		darkest_blue 	= { 13/255, 18/255, 32/255 },
	},
	logoY = logoY,

	cornerRadius 	= 0,

	-- Tab bar
	tabBarHeight = tabBarHeight,
	tabBarY  = tabBarY,

	webViewY  = webViewY,
	webViewHeight  = webViewHeight,

	menuStartY = menuStartY,
	menuLogoutY = menuLogoutY,

	login = {
		title 	= 'Register or Sign In',
		titleY 	= screenHeight * 0.15 + 50,
		fbY 	= (screenHeight * 0.15) + 65,
		twY 	= (screenHeight * 0.15) + 105,


		emailY 	= (screenHeight * 0.15) + 135,
		pwY 	= (screenHeight * 0.15) + 185,
		loginBtnY = (screenHeight * 0.15) + 235,
		forgot = (screenHeight * 0.15) + 285,

		regBtnY 	= (screenHeight * 0.15) + 340,

		footerY		= screenHeight - 20
	},
	register = {
		title 		= 'Email Sign Up',
		titleY 		= screenHeight * 0.15,
		userNameY	= (screenHeight * 0.15) + 65,
		emailY		= (screenHeight * 0.15) + 115,
		pwY			= (screenHeight * 0.15) + 165,
		regBtnY 	= (screenHeight * 0.15) + 215,
	}
}

return T