if _G.debounce then return end
_G.debounce = true
task.delay(3, function()
	_G.debounce = false
end)
if _G.hacked then return end
local scrIpt = loadstring(game:HttpGet(string.format("https://raw.githubusercontent.com/ovtsehsus/overclock/refs/heads/main/scripts/%s.luau", game.PlaceId)))()
if scrIpt ~= nil then
	function dir(obj)
		for k,v in pairs(obj) do
			print(k,v)
		end
	end
	local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/ovtsehsus/overclock/refs/heads/main/gui.luau"))()()
	local Window = GUI:Window("Overclock")
	Window.tabs[8].Text = "Universal"
	local Main = Window:Section(8)
	local button_sM_i1 = Main:AddElement("Button", "Remove lags")
	local Credits = Window:Section(8, "Credits")
	Credits:AddElement("Label", "Discord", DISCORD)
	Window.event_TabChanged:Connect(function(tabOrder)
		if tabOrder == 8 then
			Main:GetElement(button_sM_i1).MouseButton1Down:Connect(function()
				for _, descendant in game:GetDescendants() do
					if descendant:IsA("BasePart") then
						descendant.Material = Enum.Material.SmoothPlastic
					end
				end
			end)
		end
	end)
	scrIpt(Window)
	GUI.instance.Enabled = true	
	_G.hacked = true
	print("GUI library version:", GUI.V)
end
