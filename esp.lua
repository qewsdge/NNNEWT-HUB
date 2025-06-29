local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Создание Highlight для персонажа
local function createHighlight(player)
	if player == LocalPlayer then return end -- Не подсвечиваем себя

	local character = player.Character
	if not character or character:FindFirstChild("ESP_Highlight") then return end

	local highlight = Instance.new("Highlight")
	highlight.Name = "ESP_Highlight"
	highlight.FillColor = Color3.fromRGB(255, 0, 0)
	highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
	highlight.FillTransparency = 0.5
	highlight.OutlineTransparency = 0
	highlight.Adornee = character
	highlight.Parent = character
end

-- Добавить ESP ко всем текущим игрокам
for _, player in ipairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then
		player.CharacterAdded:Connect(function()
			wait(1) -- подождать прогрузку
			createHighlight(player)
		end)
		if player.Character then
			createHighlight(player)
		end
	end
end

-- Следить за новыми игроками
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		wait(1)
		createHighlight(player)
	end)
end)
