application =
{

	content =
	{
		fps = 30,
		width = 320,
		height = 480,
		xAlign 	= 'center',
		yAlign 	= 'center',
		scale = "adaptive",

		imageSuffix =
		{
			    ["@2x"] = 1.5,
			    ["@3x"] = 2.5
		},
	},

	--[[
	-- Push notifications
	notification =
	{
		iphone =
		{
			types =
			{
				"badge", "sound", "alert", "newsstand"
			}
		}
	},
	--]]    
}
