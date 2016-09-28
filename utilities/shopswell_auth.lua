
local json = require( 'json' )
local Composer = require( 'composer' )
local ShopswellData = require( 'utilities.shopswell_data' )

local twitterKey = 'QMiw9BiioMzQEiIR00K9cw5JQ'
local twitterSecret = 'F9buTCHFFJwNQt2DdoJd5yXe8EKRF1ViZ7l2ae15pl3Bhyqtmn'


local function shopswellListener( e )
	
	--native.showAlert( 'Shopswell says', e.response , { 'Ok' } )
	print( 'Shopswell says' .. e.response )

	local decoded_response = json.decode( e.response )

	if decoded_response and decoded_response.status == "success" then
		ShopswellData:save( decoded_response )
		
		Composer.gotoScene( 'scenes.home', { effect='fromBottom' } )
	else
		local title = 'Something went wrong'
		local msg = 'Unknown error'

		if decoded_response and decoded_response.message then msg = decoded_response.message[1] end
		
		native.showAlert( title, msg, { 'Ok' } )
	end
end

local function twitterConfirmListener( e )
	local Twitter = require( 'plugin.twitter' )
	local decoded_response = json.decode( e.response )
	if decoded_response.email == nil or decoded_response.email == '' then 
		Composer.gotoScene( 'scenes.email_collect' )
	else
		local url = 'https://www.shopswell.com/api_access_token?provider=twitter'
		url = url .. '&token=' .. Twitter.user.accessToken .. '&secret=' .. Twitter.user.accessTokenSecret .. '&email=' .. email
		network.request( url, 'POST', shopswellListener )
	end
end



local function facebookListener( e )
	local Facebook = require( 'plugin.facebook.v4' )
	local accessToken

	--facebook.setFBConnectListener( facebookListener )

	if ( Facebook.isActive ) then
	    accessToken = Facebook.getCurrentAccessToken()
	    if ( accessToken ) then
			--native.showAlert( "Facebook user logged in", "User's access token: " .. accessToken.token, { 'Ok' } )
	        local url = 'https://www.shopswell.com/api_access_token'
	        local post_body = 'token=' .. accessToken.token .. '&provider=facebook'
	
			network.request( url, 'POST', shopswellListener, { body = post_body } )
	    else
			--native.showAlert( 'Not logged in', "Facebook logout or cancelled", { 'Ok' } )
	    end
	end
end



local function twitterSuccess( e )
	local Twitter = require( 'plugin.twitter' )
	--native.showAlert( 'Twitter worked!', "Twitter access toke: " .. Twitter.user.accessToken, { 'Ok' } )
	local url = 'https://www.shopswell.com/api_access_token/info?provider=twitter'
	url = url .. '&token=' .. Twitter.user.accessToken .. '&secret=' .. Twitter.user.accessTokenSecret
	network.request( url, 'POST', twitterConfirmListener )
end

local function twitterFail( e )
	native.showAlert( 'Error', "Twitter auth failed", { 'Ok' } )
end

local M = {}

	function M:login( cred, pw )
		local url = 'https://www.shopswell.com/api_access_token?provider=email'
		url = url .. '&login=' .. cred .. '&password=' .. pw
		network.request( url, 'POST', shopswellListener )
	end

	function M:signup( name, email, pw )
		local url = 'https://www.shopswell.com/api_access_token?provider=email'
		url = url .. '&username=' .. name .. '&email=' .. email .. '&password=' .. pw
		print( "signing up with: " .. url )
		network.request( url, 'POST', shopswellListener )
	end

	function M:facebookAuth()
		local Facebook = require( 'plugin.facebook.v4' )
		Facebook.login( facebookListener )
	end

	function M:twitterAuth()
		local Twitter = require( 'plugin.twitter' )
		Twitter.init( twitterKey, twitterSecret )
		Twitter.login( twitterSuccess, twitterFail )
	end

	function M:twitterFinalize( email )
		local Twitter = require( 'plugin.twitter' )
		Twitter.init( twitterKey, twitterSecret )
		local url = 'https://www.shopswell.com/api_access_token?provider=twitter'
		url = url .. '&token=' .. Twitter.user.accessToken .. '&secret=' .. Twitter.user.accessTokenSecret .. '&email=' .. email
		network.request( url, 'POST', shopswellListener )
	end



return M