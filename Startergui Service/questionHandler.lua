local player 								= game:GetService('Players').LocalPlayer
local ts 									= game:GetService('TweenService')
local repl				: ReplicatedStorage = game:GetService('ReplicatedStorage')

local questioner_ 		: RemoteEvent 		= repl:WaitForChild('Question_')
local question  							= require(repl:WaitForChild('Library'):WaitForChild('Question'))
local guiAnimation 							= require(repl:WaitForChild('Library'):WaitForChild('guiAnimation'))

local mainFrame 		: CanvasGroup 		= script.Parent
local templateFold 		: Folder			= mainFrame.menuFrame.Temp


local function GetRandomQuestion()
	local randomIndex = math.random(1, #question.TestSoal) 
	local randomQuestion = question.TestSoal[randomIndex] 
	return randomQuestion
end


questioner_.OnClientEvent:Connect(function()


	mainFrame.Visible = true
	mainFrame.GroupTransparency = 0
	local fr,tr = false,false
	local randomQuestion = GetRandomQuestion()

	local currentCam = game:GetService('Workspace').CurrentCamera
	local template = templateFold:WaitForChild('Template'):Clone()
	template.Size = UDim2.fromScale(1.3,1.3)
	template.Parent = mainFrame.menuFrame
	template.Visible = true
	template.BackgroundTransparency = 0

	template.Soal.Text = string.format('%s', randomQuestion['Pertanyaan'])

	template.AnswerFrame.List.A.AnswerA.Text = string.format('A <font size="15">|</font> %s', randomQuestion['Pilihan'][1])
	template.AnswerFrame.List.B.AnswerB.Text = string.format('B <font size="15">|</font> %s', randomQuestion['Pilihan'][2])
	template.AnswerFrame.List.C.AnswerC.Text = string.format('C <font size="15">|</font> %s', randomQuestion['Pilihan'][3])
	template.AnswerFrame.List.D.AnswerD.Text = string.format('D <font size="15">|</font> %s', randomQuestion['Pilihan'][4])
	
	template.AnswerFrame.List.A.AnswerA:SetAttribute('Key',randomQuestion['Pilihan'][1])
	template.AnswerFrame.List.B.AnswerB:SetAttribute('Key',randomQuestion['Pilihan'][2])
	template.AnswerFrame.List.C.AnswerC:SetAttribute('Key',randomQuestion['Pilihan'][3])
	template.AnswerFrame.List.D.AnswerD:SetAttribute('Key',randomQuestion['Pilihan'][4])

	
	template.Parent = mainFrame.menuFrame
	
	
	local anim = ts:Create(template,TweenInfo.new(.75,Enum.EasingStyle.Quint),{BackgroundTransparency = 1,Size = UDim2.fromScale(1,1),GroupTransparency = 0})
	local anim_ = ts:Create(template,TweenInfo.new(.75,Enum.EasingStyle.Quint),{Size = UDim2.fromScale(1.5,1.5),GroupTransparency = 1})
	local animBlurIn = ts:Create(game:GetService('Lighting').UiEffect,TweenInfo.new(.35,Enum.EasingStyle.Cubic),{Size = 24})
	local animBlurOut = ts:Create(game:GetService('Lighting').UiEffect,TweenInfo.new(.35,Enum.EasingStyle.Cubic),{Size = 3})
	local animPOV = ts:Create(currentCam,TweenInfo.new(.35,Enum.EasingStyle.Cubic),{FieldOfView = 90})
	local animPOV_ = ts:Create(currentCam,TweenInfo.new(.35,Enum.EasingStyle.Cubic),{FieldOfView = 70})

	game:GetService('Lighting').UiEffect.Enabled = true
	game:GetService('Lighting').UiEffect.Size = 3
	
	local function outHandler()
		anim_:Play()
		ts:Create(mainFrame,TweenInfo.new(.75,Enum.EasingStyle.Quint),{GroupTransparency = 1}):Play()
		anim_.Completed:Wait()
		mainFrame.Visible = false

		guiAnimation.frameOut()
		animBlurOut:Play()
		animPOV_:Play()
		animBlurOut.Completed:Wait()
	end
	
	local function MouseHandler (template,randomQuestion)
		for _,v in template:GetDescendants() do
			if v:IsA('TextButton') then
				v.MouseButton1Click:Connect(function()

					local current = v
					if not current:GetAttribute('Key') then warn('Attribute not Founded') 
					else
						if current:GetAttribute('Key') ==  randomQuestion['Jawaban'] then
							repl:WaitForChild('soundLibs'):WaitForChild('Click Sound'):Play()
							outHandler()
							warn('Corrected')
							fr = true
							tr = tr
						else  warn('False Answer') fr = true
						end
						
					end
					
					questioner_:FireServer('Answer',randomQuestion,tostring(current:GetAttribute('Key')))
					repl:WaitForChild('soundLibs'):WaitForChild('Wrong'):Play()

					return
				end)
				
				v.MouseEnter:Connect(function()
					repl:WaitForChild('soundLibs'):WaitForChild('Hover sound'):Play()
				end)
			end
		end
	end
	
	anim:Play()
	animPOV:Play()
	animBlurIn:Play()
	guiAnimation.frameIn()
	animBlurIn.Completed:Wait()
	MouseHandler(template,randomQuestion)
	
 

	game.Debris:AddItem(template, 5)
	task.wait(4.5)
	if tr == true then return end
	outHandler()

	if fr == true then return end
	questioner_:FireServer('kosong','i love','money')
	repl:WaitForChild('soundLibs'):WaitForChild('getOut'):Play()

end)
