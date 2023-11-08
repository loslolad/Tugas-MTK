local repl = game:GetService('ReplicatedStorage')
local DataManger = require(script.Parent.DataManager)

task.spawn(function()
	game:GetService('Players').PlayerAdded:Connect(function(pler)
		DataManger:playerAdded(pler)
		local getData = DataManger:GetData(pler)
		if not getData then warn('Data null') return end

		local fold = Instance.new('Folder',pler)
		fold.Name = 'leaderstats'

		local benar = Instance.new('IntValue',fold)
		benar.Name = 'Benar'


		local salah = Instance.new('IntValue',fold)
		salah.Name = 'Salah'


		benar.Value = getData.Score.Benar
		salah.Value = getData.Score.Salah
	end)
end)
repl.Profiles.OnServerEvent:Connect(function(players,Listener,Data1,Data2,Data3)
	if not players then return end
	if Data1 == '' and Data2 == '' and Data3 == '' then return end
	if Listener == '' or Listener == nil then warn('Listener Not Founded '..tostring(Listener)) return end


	local getData = DataManger:GetData(players)
	if Listener == 'Registration' then
		if not getData then warn('Data Failed loaded') return end
		if getData['playerData'].userName ~= '' and getData['playerData'].asalSekolah ~= '' and getData['playerData'].kelompok ~= 0 then  
			warn('this player already had account please login or erase your data if foget about your account') return		
		end



		getData['playerData'].userName = tostring(Data1)
		getData['playerData'].asalSekolah = tostring(Data2)
		getData['playerData'].kelompok = tonumber(Data3)
		DataManger:SaveData(players)

		repl.Profiles:FireClient(players,'Registered')

	elseif Listener ==  'RemoveData' then
		if not getData then warn('Data Failed loaded') return end
		warn('Removing Data')

		getData['playerData'] = {
			['userName'] = '',
			['kelompok'] = 0,
			['asalSekolah'] = '',


		}

		getData['Score'] = {
			['Benar'] = 0,
			['Salah'] = 0

		}

		DataManger:SaveData(players)
		repl.Profiles:FireClient(players,'RemoveDat')


	elseif Listener == 'Login' then
		if not getData then warn('Data Failed loaded') return end
		if getData['playerData'].userName == tostring(Data1) and getData['playerData'].asalSekolah == tostring(Data2) and getData['playerData'].kelompok == tonumber(Data3) then
			repl.Profiles:FireClient(players,'Login')
			print('Server Login Success')
		else warn('Incorrect, try again') return
		end
	end
end)


repl:WaitForChild('Question_').OnServerEvent:Connect(function(players,listener,data2,data3)
	if data2 == nil or data2 == '' then warn('Data2 Not Founded') return end
	if data3 == nil or data3 == '' then warn('Data3 Not Founded') return end
	local getData = DataManger:GetData(players)
	local lead : Folder= players:FindFirstChild('leaderstats')

	if not lead	then return end
	if not getData then warn('Data Failed loaded') return end
	if listener == 'Answer' then
		if data3 == data2['Jawaban'] then getData.Score.Benar += 1	 print('Jawaban Benar')			
		else getData.Score.Salah += 1 print('Jawaban Salah') end 
	elseif listener == 'kosong' then getData.Score.Salah += 3 warn('Jawaban Kosong')	
	else warn('listener Not Founded') return end
	lead:WaitForChild('Benar').Value = getData.Score.Benar
	lead:WaitForChild('Salah').Value = getData.Score.Salah

	DataManger:SaveData(players)


end)
