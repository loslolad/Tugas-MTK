local Package = {}

function Package:createDialogLabel(text, parent, xOffset, yOffset)
	local label = Instance.new("TextLabel")
	label.Parent = parent
	label.Name = text
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextTransparency = 1
	label.TextSize = 16
	label.TextColor3 = Color3.fromRGB(42, 44, 47)
	label.Position = UDim2.new(0, xOffset, 0, yOffset)
	label.Size = UDim2.new(0, label.TextBounds.X, 1, 0)
	label.ZIndex = 5
	return label
end

function Package:animateTextLabel(label)
	label.TextTransparency = 1
	label.Visible = true
	label.Position = UDim2.new(0, label.Position.X.Offset, 0, label.Position.Y.Offset - 20)

	local tweenInfo = TweenInfo.new(.75,Enum.EasingStyle.Elastic)
	local tween = game:GetService("TweenService"):Create(label, tweenInfo, {
		TextTransparency = 0,
		Position = UDim2.new(0, label.Position.X.Offset, 0, label.Position.Y.Offset + 20)
	})
	tween:Play()
end

function Package:animateTextLabels(labels,frame)
	for i, label in ipairs(labels) do
		self:animateTextLabel(label)
	--	script.Parent:WaitForChild('Keyboard Typing 33 (SFX)'):Play()
		task.wait()
	end
end

function Package:OutAnim(labels,dialogFrame)
	local cur = dialogFrame.Position
	dialogFrame.Position = cur
	for i, label in labels do
		local tweenInfo = TweenInfo.new(.75,Enum.EasingStyle.Elastic)
		local tween = game:GetService("TweenService"):Create(label, tweenInfo, {
			TextTransparency = 1,
			Position = UDim2.new(0, label.Position.X.Offset - 10, 0, label.Position.Y.Offset + 20)
		})
		tween:Play()
		task.wait()
	end
	dialogFrame:Destroy()
end
return Package
