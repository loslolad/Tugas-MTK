local repl 			:	ReplicatedStorage 	= game:GetService('ReplicatedStorage')
local ts 									= game:GetService('TweenService')


local player 								= game:GetService('Players').LocalPlayer
local leaderstats 							= player:WaitForChild('leaderstats')
local scoreB : IntValue ,scoreS : IntValue 	= leaderstats:WaitForChild('Benar'),leaderstats:WaitForChild('Salah')

local frame 		: Frame 				= script.Parent.Frame
local Requirement 	: TextLabel 			= frame.Requirement
task.spawn(function()
	
	while true do 
		local scorevalB_,scorevalS_ = scoreB.Value,scoreS.Value
		local scoreReq = repl:WaitForChild('TotalV').Value
		local totalScore_ = scoreReq + scorevalS_
		
		Requirement.Text = string.format('Requirement <font color="rgb(176, 111, 46)">Correct answer</font> to open the door<font color="rgb(0,0,0)"> : </font><font color="rgb(50, 79, 125)">%s</font>',totalScore_)
		
		if scorevalB_ >= totalScore_ then
			warn('Finished')
			repl:WaitForChild('soundLibs'):WaitForChild('Door'):Play()
			ts:Create(workspace.Door,TweenInfo.new(15),{CFrame = workspace.Door.CFrame * CFrame.new(0,-5,0)}):Play()
			break
			
		end
		task.wait()
	end
end)