-- Our Module object
local M = {}

local Debug = require( "utilities.debug" )
local Btn = require( 'ui.btn' )
local Composer = require( 'composer' )
local Theme = require( 'ui.theme' )
local device = require( 'utilities.device' )

M.defaults = { 
	x 				= centerX,
	y				= Theme.tabBarY,
	--bg_color 		= { 13/255, 18/255, 32/255, 1 },
	bgColor 		= { 1,1,1, 1 },
	font_color		= { 1, 1, 1, 1 },
	font_size 		= 16,
	width 			= screenWidth,
	height 			= Theme.tabBarHeight,
}

M.buttons = {
	{
		seq 		= 1,
		icon 		= 'assets/images/icons/icon_home',
		target 		= 'scenes.home',
		label 		= 'Home',
		selected 	= true
	},
	{
		seq 		= 2,
		icon 		= 'assets/images/icons/icon_browse',
		label 		= 'Browse',
		target 		= 'scenes.browse'
	},
	{
		seq 		= 3,
		icon 		= 'assets/images/icons/icon_questions',
		label 		= 'Questions',
		target 		= 'scenes.questions'
	},
	-- {
	-- 	seq 		= 4,
	-- 	icon 		= 'assets/images/icons/icon_profile',
	-- 	label 		= 'You',
	-- 	target 		= 'scenes.profile'
	-- },
	{
		seq 		= 4,
		icon 		= 'assets/images/icons/icon_moreMenu',
		target 		= 'scenes.menu',
		label 		= 'More'
	},
}

function M:new( opts )
	-- use defaults if no opts passed in
	if opts == nil then opts = M.defaults end
	
	-- fill in any missing opts from module defaults
	for key, value in pairs( M.defaults ) do
		if opts[key] == nil then 
			opts[key] = M.defaults[key]
		end
	end

	--Debug.print_table( opts )

	local tab_bar = display.newGroup()
	if opts.group then 
		opts.group:insert( tab_bar )
	end


	tab_bar.bg = display.newRect( tab_bar, opts.x, opts.y, opts.width, opts.height )
	tab_bar.bg.anchorY = 0

	local direction = 'up'
	if device.isApple then
		direction = 'down'
	end
	-- local paint = {
	-- 	type = 'gradient',
	--     color1 = Theme.colors.lt_purple,
	--     color2 = { 1, 1, 1, 1 },
	--     direction = direction
	-- }

	tab_bar.bg.fill = { 1, 1, 1, 1 }

	tab_bar.separator = display.newLine( tab_bar, 0, Theme.webViewY-1, screenWidth, Theme.webViewY-1 )
	tab_bar.separator:setStrokeColor( 0.66 )
	if device.isApple then 
		tab_bar.separator.y = screenHeight - Theme.tabBarHeight + 1
	end

	
	

	local y = opts.y + opts.height / 2
	if device.isApple then 
		y = y-5 
	else
		y = y - 8
	end


	local xOffset = screenWidth / #M.buttons
	local x = xOffset / 2

	tab_bar.buttons = {}



	function tab_bar:get_selected()
		for i=1, #tab_bar.buttons do 
			if tab_bar.buttons[i].selected then
				return tab_bar.buttons[i]
			end
		end
	end

	function tab_bar:hide()
		self.x = screenWidth + 5
	end

	function tab_bar:show( opts )
		if opts == nil then opts = {} end
		self.x = 0
		-- local speed = opts.time or 500
		-- if self.x > screenWidth then 
		-- 	transition.to( self, { x=0, time=speed } )
		-- end
	end

	
	function tab_bar:select_button( button )
		local prev_selected = tab_bar:get_selected()

		-- prev_selected.icon.fill = { 0.5, 0.5, 0.5, 1 }
		prev_selected.icon_selected.isVisible = false 
		prev_selected.icon.isVisible = true
		prev_selected.label.fill = Theme.colors.darkest_blue

		prev_selected.selected = false

		button.selected = true

		button.icon_selected.isVisible = true 
		button.icon.iVisible = false
		button.label.fill = Theme.colors.purple

		local transition
		if prev_selected.seq < button.seq then 
			transition = 'slideLeft'
		else 
			transition = 'slideRight'
		end
		return transition
	end


	function tab_bar:select_scene( scene )
		for i=1, #tab_bar.buttons do 
			if tab_bar.buttons[i].target == scene then
				tab_bar:select_button( tab_bar.buttons[i] )
			end
		end

	end



	function tab_bar:goto_button( button )

		local transition = self:select_button( button )

		print( '\nGoing to tab: ' .. button.target )

		Composer.gotoScene( button.target, { effect = transition, time = 400 } )
	end

	for i=1, #M.buttons do 
		print( M.buttons[i].seq .. ' : ' .. M.buttons[i].target )
		tab_bar.buttons[i] = display.newGroup()
		tab_bar:insert( tab_bar.buttons[i] )
		local btn = tab_bar.buttons[i]

		tab_bar.buttons[i].bg = display.newRect( tab_bar.buttons[i], x, y, xOffset, opts.height )
		tab_bar.buttons[i].strokeWidth = 2
		tab_bar.buttons[i].bg.fill = { 1, 1, 0, 0.01 }
		
		tab_bar.buttons[i].icon = display.newImageRect( tab_bar.buttons[i], M.buttons[i].icon .. '.png', 25, 25 )
		tab_bar.buttons[i].icon.x = x 
		tab_bar.buttons[i].icon.y = y

		tab_bar.buttons[i].label = display.newText( tab_bar, M.buttons[i].label, x, y+22, 'OpenSans', 10 )
		

		tab_bar.buttons[i].icon_selected = display.newImageRect( tab_bar.buttons[i], M.buttons[i].icon .. '_selected.png', 25, 25 )
		tab_bar.buttons[i].icon_selected.x = x 
		tab_bar.buttons[i].icon_selected.y = y
		tab_bar.buttons[i].icon_selected.isVisible = false
		
		
		tab_bar.buttons[i].selected = M.buttons[i].selected or false

		tab_bar.buttons[i].icon_selected.isVisible = M.buttons[i].selected
		tab_bar.buttons[i].icon.isVisible = not( M.buttons[i].selected )

		if tab_bar.buttons[i].selected then
			tab_bar.buttons[i].label.fill = Theme.colors.purple
		else
			tab_bar.buttons[i].label.fill = Theme.colors.darkest_blue
		end
		
		tab_bar.buttons[i].seq = M.buttons[i].seq
		tab_bar.buttons[i].target = M.buttons[i].target

		function btn:touch( e )
			if self.selected then --return false end
				if e.phase == 'ended' then 
					currentView:request( currentView.base_url )
					return false 
				else 
					return false 
				end
			end

			if e.phase == 'began' then
				--self.icon.fill = { 0.75, 0.75, 0.75, 1 }
				self.icon_selected.isVisible = true 
				self.icon.iVisible = false
				display.getCurrentStage():setFocus( e.target )
			elseif e.phase == 'ended' or e.phase == 'cancelled' then
				--self.icon.fill = { 0.5, 0.5, 0.5, 1 }
				display.getCurrentStage():setFocus( nil )

				tab_bar:goto_button( self )
			end

		end
		btn:addEventListener( 'touch', btn )

		x = x + xOffset
	end

	-- tab_bar.debug = display.newText({
	-- 	parent = tab_bar,
	-- 	fontSize = 10,
	-- 	width = screenWidth,
	-- 	x = centerX,
	-- 	y = tab_bar.buttons[1].label.y,
	-- 	text = 'Debug'
	-- 	})
	-- tab_bar.debug.fill = { 0 }


	return tab_bar

end



-- return the module
return M





