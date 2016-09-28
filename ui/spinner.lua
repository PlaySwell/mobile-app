-- Our Module object
local M = {}

local Debug = require( "utilities.debug" )
local Composer = require( 'composer' )
local fa = require( 'ui.font_awesome' )

M.defaults = { 

}

local spin = function( obj, func )
	if func then 
		obj.transitionLoop = func 
	end
	obj.rotation = 0 
	transition.to( obj, {rotation = 359, time = 1200, onComplete = obj.transitionLoop } )
end



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

	local spinner = display.newGroup()
	if opts.group then 
		opts.group:insert( spinner )
	end

	spinner.bg = display.captureScreen()
	spinner.bg.x = centerX 
	spinner.bg.y = centerY
	spinner.bg.fill.effect = "filter.blurGaussian"
	spinner.bg.fill.effect.horizontal.blurSize = 12
	spinner.bg.fill.effect.vertical.blurSize = 12


	spinner.icon = display.newText( fa.spinner, centerX, centerY, 'FontAwesome', 64 )
	spinner.icon.fill = { 149/255, 100/255, 158/255, 1 }

	function spinner:spin()
		spin( spinner, spin )
	end

	function spinner:cleanup()
		if spinner then 
			spinner.bg:removeSelf()
			transition.to( spinner.icon, {
				xScale=0.01,
				yScale=0.01,
				onComplete = function()
					if spinner then spinner:removeSelf(); spinner = nil end
				end
			})
		end
	end


	return spinner

end



-- return the module
return M





