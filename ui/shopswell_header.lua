
local Theme = require( 'ui.theme' )

local M = {}

M.defaults = {
	animate 	= false,
	tagline 	= true
}

function M:new( opts )

	if opts == nil then opts = M.defaults end
	
	-- fill in any missing opts from module defaults
	for key, value in pairs( M.defaults ) do
		if opts[key] == nil then 
			opts[key] = M.defaults[key]
		end
	end

	local header = display.newGroup()

	header.logo_type = display.newImageRect( header, 'assets/images/shopswell_logo_type.png', 249, 51 )
	header.logo_type:scale( 0.66, 0.66 )
	header.logo_type.x = centerX + ( header.logo_type.contentWidth * 0.20 )
	header.logo_type.y = Theme.logoY

	header.logo = display.newImageRect( header, 'assets/images/shopswell_stamp.png', 200, 265 )
	header.logo:scale( 0.18, 0.18  )
	header.logo.x = header.logo_type.x - ( (header.logo_type.contentWidth*0.33) + 50 )
	header.logo.y = header.logo_type.y

	if opts.tagline then
		header.tagline = display.newText( header, 'Shopping Smarter, Together', centerX, centerY, Theme.fonts.bold, 14 )
		header.tagline.y = header.logo_type.contentHeight + ( screenHeight * 0.070 )
		header.tagline.fill = { 0.33, 0.33, 0.33 }
	end

	if opts.title then 
		header.title = display.newText( header, opts.title, centerX, centerY, Theme.fonts.light, 22 )
		header.title.y = header.title.contentHeight + 80
		header.title.fill = { 0.33, 0.33, 0.33 }
	end

	if opts.animate then 
		header.logo.y = -200
		header.drop_logo = transition.to( header.logo, { time=3000, y=header.logo_type.y, transition=easing.inOutBounce } )
	end

	if opts.group then 
		opts.group:insert( header )
	end

	return header
end

return M