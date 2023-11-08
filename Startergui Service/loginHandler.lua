local players  				= game:GetService('Players').LocalPlayer
local repl 				= game:GetService('ReplicatedStorage')
local guiAnimation 			= require(repl:WaitForChild('Library'):WaitForChild('guiAnimation'))
local ts 				= game:GetService('TweenService')
local profileEvent 	: RemoteEvent 	= repl.Profiles



local menuRegistration 	: Frame 	= script.Parent:WaitForChild('regisFrame')
local menuLogin 	: Frame 	= script.Parent:WaitForChild('loginFrame')
local menu 		: Frame 	= script.Parent:WaitForChild('menuFrame')


--[Register]--
local user		: TextBox 	= menuRegistration.Username
local asalSekolah 	: TextBox 	= menuRegistration.AsalSekolah
local Kelompok 		: TextBox 	= menuRegistration.Kelompok
local createButton	: TextButton 	= menuRegistration.CreateButton.Button
local eraseButton 	: TextButton 	= menuRegistration.EraseButton.Button

--[Login]--
local user_		: TextBox 	= menuLogin.Username
local asalSekolah_ 	: TextBox 	= menuLogin.AsalSekolah
local Kelompok_ 	: TextBox 	= menuLogin.Kelompok
local loginButton_ 	: TextButton	= menuLogin.LoginButton.Button

--[menu]--
local loginButton__ : TextButton 	= menu.LoginButton.Button
local createButton_ : TextButton 	= menu.RegisterButton.Button

local currentCam = workspace.CurrentCamera
local animPOV = ts:Create(currentCam,TweenInfo.new(.35,Enum.EasingStyle.Cubic),{FieldOfView = 125})
local animPOV_ = ts:Create(currentCam,TweenInfo.new(.35,Enum.EasingStyle.Cubic),{FieldOfView = 90})
local animPOV__ = ts:Create(currentCam,TweenInfo.new(.35,Enum.EasingStyle.Cubic),{FieldOfView = 70})
currentCam.FieldOfView = 125

local function visibleSelected(selected : string?)
	for _,v in script.Parent:GetChildren() do
		if v:isA('Frame') then
			v.Visible = false
		end
	end
	if selected == '' or selected == nil then return end
	script.Parent:FindFirstChild(selected).Visible = true
end
task.spawn(function()
	repl.Profiles.OnClientEvent:Connect(function(listener)
		if listener == '' or listener == nil then warn('Listener Not Founded '..tostring(listener)) return end

		if listener == 'Registered' then
			--menu.Parent.Visible = false
			visibleSelected()
			guiAnimation:moduleCinema1()
			animPOV__:Play()
			animPOV__.Completed:Wait()
		elseif listener == 'Login' then
			--menu.Parent.Visible = false
			warn('Succesfully Login')
			visibleSelected()
			guiAnimation.FadeBloom()
			guiAnimation.frameOut()
			animPOV__:Play()
			animPOV__.Completed:Wait()
		elseif listener == 'RemoveDat' then
			warn('Successfully Removing Data')
		
		end
	end)
end)

task.spawn(function()
	for _,v in script.Parent:GetDescendants() do 
		if v:isA('ImageButton') and v.Name == 'Back' then
			v.MouseButton1Click:Connect(function()
				v.Parent.Visible = false
				script.Parent.menuFrame.Visible = true
				animPOV:Play()
				animPOV.Completed:Wait()
			end)
		end
	end
end)


createButton.MouseButton1Click:Connect(function()
	if user.Text == '' and asalSekolah.Text == '' and Kelompok.Text == '' or tonumber(Kelompok.Text) == nil or tonumber(Kelompok.Text) ==  0 then 
		warn('Password or Userame or kelompok are null')
		return	
	end
	profileEvent:FireServer('Registration',user.Text,asalSekolah.Text,tonumber(Kelompok.Text))
end)

eraseButton.MouseButton1Click:Connect(function()
	profileEvent:FireServer('RemoveData')
	warn('Data Erased')
end)


loginButton_.MouseButton1Click:Connect(function()
	if user_.Text == '' and asalSekolah_.Text == '' and  Kelompok_.Text == '' or tonumber(Kelompok_.Text) == nil or tonumber(Kelompok_.Text) ==  0  then 	
		warn('Password or Userame are null')
		return 
	end
	profileEvent:FireServer('Login',user_.Text,asalSekolah_.Text,tonumber(Kelompok_.Text))
	
end)

loginButton__.MouseButton1Click:Connect(function()
	visibleSelected('loginFrame')
	animPOV_:Play()
	animPOV_.Completed:Wait()
end)

createButton_.MouseButton1Click:Connect(function()
	visibleSelected('regisFrame')
	animPOV_:Play()
	animPOV_.Completed:Wait()
end)


