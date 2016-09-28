---------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------

local Composer = require( "composer" )
local scene = Composer.newScene()

local Widget = require( 'widget' )

local Btn = require( 'ui.btn' )
local fa = require( 'ui.font_awesome' )

local Header = require( 'ui.shopswell_header' )
local Theme = require( 'ui.theme' )
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local ui = {}



-- Called when the scene's view does not exist:
function scene:create( event )
	local group = self.view
	
	ui.bg = display.newRect( group, 0, 0, screenWidth, screenHeight )
	ui.bg:setFillColor( 1, 1, 1, 1, 1 )
	ui.bg.x = centerX
	ui.bg.y = centerY

	ui.header = Header:new({
		group = group,
	})
	function ui.header.tap( e )
		Composer.gotoScene( Composer.getSceneName( "previous" ), { effect = 'fromRight' } )
	end
	ui.header:addEventListener( 'tap', ui.back_link )


	ui.back_link = display.newText( group, 'Back', 10, 15, 'OpenSans', 14 )
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



		tab_bar:hide()

		ui.scrollView = Widget.newScrollView({
			top 	= 100,
			left 	= 0,
			topPadding = 20,
			bottomPadding = 100,
			rightPadding = 50,
			width 	= screenWidth - 20,
			height 	= screenHeight - 100,
			horizontalScrollDisabled = true,
			hideBackground 	= true
			})

		local copy = [[
		Shopping online today can be overwhelming. With an entire world at your fingertips, it's often too hard to know what the right option is for you. It doesn't help that no one really seems to care about you or your needs. Sorting through endless pages of inauthentic reviews, rigged search results, or untrustworthy affiliate sites while being bombarded by advertising is not our idea of a good shopping experience.

		Shopswell members delight in sharing their taste through awesome product discoveries, curated lists, product reviews, and their own personal experiences so that everyone can shop smarter together.

		Read reviews, recommendations and helpful articles shared by people with tastes just like you. Find out what other savvy shoppers really think and make informed decisions when you buy.

		]]

		ui.about_txt = display.newText( copy, 0, 0, screenWidth-50, 0, 'OpenSans-Regular.ttf', 15 )
		-- ui.about_txt = display.newText({
		-- 	parent = group,
		-- 	text = copy,
		-- 	fontSize = 15,
		-- 	font = Theme.font
		-- 	})
		ui.about_txt.fill = { 0.33 }
		ui.about_txt.x = centerX
		ui.about_txt.anchorY = 0

		ui.scrollView:insert( ui.about_txt )

	end

	if event.phase == "did" then
	
	end

end

function scene:hide( event )
	if event.phase == "will" then
		display.remove( ui.scrollView )
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

