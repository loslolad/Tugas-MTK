local module = {}

module.__index = module

local TweenService = game:GetService('TweenService')
local getmaid = require(script.Parent:WaitForChild('supportedMaid'))
local function init()
	local player = game:GetService('Players').LocalPlayer
	local vfx : ScreenGui

	if player.PlayerGui:FindFirstChild('VFX') then
		vfx = player.PlayerGui:FindFirstChild('VFX')
	else
		vfx = Instance.new('ScreenGui',player.PlayerGui)
		vfx.Name = 'VFX'
		vfx.IgnoreGuiInset = true
	end

	return vfx
end


function module.FadeBloom()

	warn('This is Client-Side')
	local vfx = init()
	local frame : Frame = Instance.new('Frame',vfx)
	frame.Size = UDim2.fromScale(0,0)
	frame.AnchorPoint = Vector2.new(.5,.5)
	frame.Position = UDim2.fromScale(.5,.5)
	frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
	frame.BackgroundTransparency = 1
	frame.Rotation = 180



	local ts = TweenService:Create(frame,TweenInfo.new(.25,Enum.EasingStyle.Cubic),{Size = UDim2.fromScale(.1,.18),BackgroundTransparency = 0,Rotation = 0})
	local ts_ = TweenService:Create(frame,TweenInfo.new(.5,Enum.EasingStyle.Quint),{Size = UDim2.fromScale(1,1),BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
	local ts__ = TweenService:Create(frame,TweenInfo.new(2,Enum.EasingStyle.Quad),{BackgroundColor3 = Color3.fromRGB(219, 222, 231)})
	local ts___ = TweenService:Create(frame,TweenInfo.new(.75,Enum.EasingStyle.Cubic),{BackgroundTransparency = 1})

	ts:Play()
	ts.Completed:Wait()
	ts_:Play()
	ts_.Completed:Wait()
	ts__:Play()
	ts__.Completed:Wait()
	ts___:Play()
	--ts___.Completed:Wait()]]
	warn('Bloom Finished')
	game.Debris:AddItem(frame,.5)
	TweenService:Create(game:GetService('Lighting').UiEffect,TweenInfo.new(.35,Enum.EasingStyle.Cubic),{Size = 3}):Play()
end

function module.frameIn()
	local player = game:GetService('Players').LocalPlayer
	local uiGUI 		= player.PlayerGui
	TweenService:Create(uiGUI.ScreenGui.SafeArea.Frame1,TweenInfo.new(.45,Enum.EasingStyle.Quint),{Position = UDim2.fromScale(0,0)}):Play()
	TweenService:Create(uiGUI.ScreenGui.SafeArea.Frame2,TweenInfo.new(.45,Enum.EasingStyle.Quint),{Position = UDim2.fromScale(0,0.9)}):Play()

end
function module.frameOut()
	local player = game:GetService('Players').LocalPlayer
	local uiGUI = player.PlayerGui
	TweenService:Create(uiGUI.ScreenGui.SafeArea.Frame1,TweenInfo.new(.45,Enum.EasingStyle.Quint),{Position = UDim2.fromScale(0,-.1)}):Play()
	TweenService:Create(uiGUI.ScreenGui.SafeArea.Frame2,TweenInfo.new(.45,Enum.EasingStyle.Quint),{Position = UDim2.fromScale(0,1)}):Play()

end

function module:moduleCinema1()
	self.FadeBloom()
	local vfx = init()
	local player = game:GetService('Players').LocalPlayer
	TweenService:Create(game:GetService('Lighting').UiEffect,TweenInfo.new(.35,Enum.EasingStyle.Cubic),{Size = 24}):Play()

	local frame : Frame = Instance.new('Frame',vfx)

	frame.Size = UDim2.fromScale(1,1)
	frame.AnchorPoint = Vector2.new(.5,.5)
	frame.Position = UDim2.fromScale(.5,.5)
	frame.BackgroundColor3 = Color3.fromRGB(219, 222, 231)
	frame.BackgroundTransparency = 0


	local frame_ : Frame = Instance.new('Frame',frame)
	frame_.Name = 'TextStore'
	frame_.Size = UDim2.fromScale(1,.35)
	frame_.AnchorPoint = Vector2.new(.5,.5)
	frame_.Position = UDim2.fromScale(.5,.5)
	frame_.BackgroundTransparency = 1
	frame_.ZIndex = 2

	local frame__ : Frame = Instance.new('Frame',frame)
	frame__.Size = UDim2.fromScale(0,0)
	frame__.AnchorPoint = Vector2.new(.5,.5)
	frame__.Position = UDim2.fromScale(.5,.5)
	frame__.BackgroundColor3 = Color3.fromRGB(0,0,0)
	frame__.BackgroundTransparency = 1
	frame__.Rotation = 180
	frame__.ZIndex = 1
	frame__.BorderSizePixel = 0
	local ts = TweenService:Create(frame__,TweenInfo.new(.25,Enum.EasingStyle.Cubic),{Size = UDim2.fromScale(.1,.18),BackgroundTransparency = 0,Rotation = 0})
	local ts_ = TweenService:Create(frame__,TweenInfo.new(.5,Enum.EasingStyle.Quint),{Size = UDim2.fromScale(1,.18),BackgroundColor3 = Color3.fromRGB(229, 231, 240)})
	local ts__ = TweenService:Create(frame__,TweenInfo.new(.35,Enum.EasingStyle.Cubic),{Size = UDim2.fromScale(0,.18),BackgroundTransparency = 1,BackgroundColor3 = Color3.fromRGB(42, 44, 47)})
	local ts___ = TweenService:Create(frame,TweenInfo.new(1,Enum.EasingStyle.Linear),{BackgroundTransparency = 1,BackgroundColor3 = Color3.fromRGB(42, 44, 47)})

	ts:Play()
	ts.Completed:Wait()
	ts_:Play()
	ts_.Completed:Wait()


	getmaid:addText_Once('| Game ini bentuk oleh Raffi Fajar Ahmad, Sebagai Programmer & Pembuat',frame_,0,0,UDim2.fromScale(.15,.5))
	getmaid:addText_Once('| Halo aku, Alpha. Sebagai Assitant pribadi milikmu',frame_,0,0,UDim2.fromScale(.15,.5))
	getmaid:addText_Once('| Alpha : ini adalah game yang di buat pakai engine RobloxStudio',frame_,0,0,UDim2.fromScale(.15,.5))
	getmaid:addText_Once('| Alpha : dan game ini tentang Matematika',frame_,0,0,UDim2.fromScale(.15,.5))
	getmaid:addText_Once('| Alpha : game ini didayai oleh Bluebird Studio',frame_,0,0,UDim2.fromScale(.15,.5))
	getmaid:addText_Once('| Alpha : sebelumnya terimakasih untuk telah memainkan game ini',frame_,0,0,UDim2.fromScale(.15,.5))
	getmaid:addText_Once('| Alpha : mari kita main kan gamenya',frame_,0,0,UDim2.fromScale(.15,.5))
	getmaid:addText_Once('Starting!',frame_,0,0,UDim2.fromScale(.48,.5))
	ts__:Play()
	ts__.Completed:Wait()
	task.wait(2)
	ts___:Play()
	ts___.Completed:Wait()
	warn('moduleCinema1 Finished')
	TweenService:Create(game:GetService('Lighting').UiEffect,TweenInfo.new(.35,Enum.EasingStyle.Cubic),{Size = 3}):Play()
	self.frameOut()
	

end




return module
