
local FileUtils = require( "utilities.file" )

-- used to interface with local shopswell login data which stores:
-- name
-- token
-- email 

local M = {}

function M:load()
	-- load data from local storage and send back as a table
	-- returns whatever is saved or nil for all fields
	local existing_data = FileUtils.loadTable( "user_data.json" )

	if existing_data then 
		return existing_data 
	else 
		return {
			name = nil,
			token = nil,
			email = nil
		}
	end
end

function M:save( data )
	-- saves the data
	-- call with data=nil to clear all fields 
	if data == nil then
		FileUtils.saveTable( { token=nil, name=nil, email=nil }, 'user_data.json' )
	else
		FileUtils.saveTable( { token=data.token, name=data.name, email=data.email }, 'user_data.json' )
	end
end


return M