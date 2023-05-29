local streetName = {}

-- Configuration. Please be careful when editing. It does not check for errors.
streetName.show = true
streetName.position = {x = 0.5, y = 0.02, centered = true}
streetName.textSize = 0.35
streetName.textColour = {r = 255, g = 255, b = 255, a = 255}
-- End of configuration


Citizen.CreateThread( function()
	local lastStreetA = 0
	local lastStreetB = 0
	local lastStreetName = ''
	
	while streetName.show do
		Wait(1000)

		if IsPedInAnyVehicle(PlayerPedId(), false) then
			SendNUIMessage({
				action = "setStreetName",
				streetname = lastStreetName
			})
			local playerPos = GetEntityCoords( PlayerPedId(), true )
			local streetA, streetB = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerPos.x, playerPos.y, playerPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
			local street = {}
			
			if not ((streetA == lastStreetA or streetA == lastStreetB) and (streetB == lastStreetA or streetB == lastStreetB)) then
				-- Ignores the switcharoo while doing circles on intersections
				lastStreetA = streetA
				lastStreetB = streetB
			end
			
			if lastStreetA ~= 0 then
				table.insert( street, GetStreetNameFromHashKey( lastStreetA ) )
			end
			
			if lastStreetB ~= 0 then
				table.insert( street, GetStreetNameFromHashKey( lastStreetB ) )
			end
			local fullStreetName = table.concat( street, " & " )
			if(lastStreetName ~= fullStreetName) then
				lastStreetName = fullStreetName
				SendNUIMessage({
					action = "setStreetName",
					streetname = fullStreetName
				})
			end

			if IsPauseMenuActive() then
				isPaused = true
				SendNUIMessage({
					close = true
				})
			elseif not IsPauseMenuActive() and isPaused then
				SendNUIMessage({
					action = "setStreetName",
					streetname = fullStreetName
				})
				isPaused = false
			end
		else
			SendNUIMessage({
				close = true
			})
		end
	end
end)

RegisterNetEvent('compasandstreer:close')
AddEventHandler('compasandstreer:close', function(close)
	if close then
		SendNUIMessage({
			close = true
		})
	else
		SendNUIMessage({
			action = "setStreetName",
			streetname = fullStreetName
		})
	end
end)
