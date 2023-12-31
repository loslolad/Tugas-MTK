local dataManager = {}

local defaultTemplate = {
	['playerData'] = {
		['userName'] = '',
		['asalSekolah'] = '',
		['kelompok'] = 0,
		['level'] = 0,

	},
	
	['Score'] = {
		['Benar'] = 0,
		['Salah'] = 0
	}
}
local ProfileService = require(script.Parent.Libs.ProfileService)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ProfileStore = ProfileService.GetProfileStore("GameDatas #1", defaultTemplate)

local profiles = {} -- [player] = profile

--[[function updatedValueCurrency(player)
	local profile = dataManager:GetData(player)
	if profile then
		local lead = player:WaitForChild('leaderstats')
		local stat = player.PlayerGui:WaitForChild('Status')
		local status = stat.Frame.Keebutuhan
		local inv = player.PlayerGui:WaitForChild('Inventory')
		local bag2 = status.Bag2

		lead.Gulden.Value = profile.Gulden
		lead.Rupiah.Value = profile.IDR
		bag2.Money.Text = string.format('Gulden: <u><font color="rgb(73, 181, 43)">%s,00</font></u>',lead.Gulden.Value)
		bag2.Rupiah.Text = string.format('Rupiah: <u><font color="rgb(73, 181, 43)">%s,00</font></u>',lead.Rupiah.Value)
		--	bag2.Umur.Text = 'Umur: '..age.Value

		inv.Ransel.MineMoney.Text = string.format('Gulden Wallet: <u><font color="rgb(73, 181, 43)">%s,00</font></u>',lead.Gulden.Value)
		inv.Ransel.Saldo.Text = string.format('Rupiah: <u><font color="rgb(73, 181, 43)">%s,00</font></u>',lead.Rupiah.Value)
	end
end]]


-- Function to save a player's profile
function saveProfile(player)
	dataManager:SaveData(player)

end


function dataManager:GetData(player)
	local playerProfile = profiles[player]
	if playerProfile then
		return playerProfile.Data
	else
		return nil
	end
end
function dataManager:playerAdded(player)
	local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
	if profile then
		profile:AddUserId(player.UserId) -- Kompatibilitas GDPR
		profile:Reconcile() -- Mengisi variabel yang hilang dari DefaultTemplate (opsional)



		profile:ListenToRelease(function()
			profiles[player] = nil
			-- Profil mungkin sudah dimuat pada server Roblox lain:
			player:Kick()
		end)
		if player:IsDescendantOf(Players) == true then
			profiles[player] = profile
			-- Profil berhasil dimuat:
		else
			warn("Player tidak ditemukan")
		end
	end
end

-- Function to save profile data
function dataManager:SaveData(player)
	local profile = profiles[player]
	if profile then
		-- Save the player's profile data
		profile.Data = dataManager:GetData(player)
		if profile.Save then

			-- Save inventory data to ReplicatedStorage
		--[[	local inventoryData = profile.Data.Inventory
			local tempItemFolder = game:GetService('ServerStorage'):WaitForChild('ServerDat'):WaitForChild('TempItem')
			local rillItem = player:WaitForChild('Ransel')
			for itemName, itemValue in pairs(inventoryData) do
				local existingItem = rillItem:FindFirstChild(itemName)
				if existingItem then
					inventoryData[itemName] = existingItem.Value
					coroutine.wrap(function() print(inventoryData[itemName].. ' | '..itemName) end)				
				else
					warn('Item '..itemName..' is missing or corrupted')
					return
				end
			end]]
			-- Save profile
			profile:Save()
			print("Data berhasil disimpan untuk " .. player.Name)
		else
			warn("Save method not found in profile for player " .. player.Name)
		end
	else
		warn("Profile not found for player " .. player.Name)
	end
end



function dataManager:playerLeaving(player)
	local profile = profiles[player]
	saveProfile(player)
	if profile ~= nil then
		profile:Release()
		
	end
end
-- Main loop
--[[while true do
	-- Loop through all players and load their profiles
	for _, player in ipairs(game.Players:GetPlayers()) do
		loadProfile(player)
	end
	wait(1)
end]]

return dataManager