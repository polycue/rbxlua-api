local Http = game:GetService("HttpService")
local spawn
local storage

if game:GetService("ReplicatedStorage"):FindFirstChild("Nevermore") then
	print("NevermoreEngine has been detected, removing fastSpawn...")
	script.fastSpawn:Destroy()
	local require = require(game:GetService("ReplicatedStorage"):FindFirstChild("Nevermore"))
	spawn = require("fastSpawn")
else
	spawn = require(script.fastSpawn)
end
if game.ReplicatedStorage:FindFirstChild("Storage") == nil then
	storage = Instance.new("Configuration", game.ReplicatedStorage) do storage.Name = "Storage" end
else
	storage = game.ReplicatedStorage:FindFirstChild("Storage")
end

local module = {}
module.ClassName = "Metadata"
module.__index = module
module.__tostring = function(t)
	return table.concat(t, ", ")
end
module.__tonumber = function(t)
	return table.getn(t)
end

function module:bulkInject(debug, ...)
	local dataTable = {...}
	local encDataTable = Http:JSONEncode(dataTable)
	for _,data in ipairs(dataTable) do
		self:inject(data)
	end
	if debug == true then
		print(#encDataTable .. " bytes injected into " .. self.Name)
	end
end
function module:inject(data, debug)
	if data.name and data.data and typeof(data) == "table" then
		local encoded
		if data.name == "version" or data.name == "Version" then
			if string.sub(data.data, 1, 1) ~= "v" and string.sub(data.data, 1, 1) ~= "V" then
				data.data = string.format("v%s", data.data)
				encoded = Http:JSONEncode(data)
			else
				encoded = Http:JSONEncode(data)
			end
		elseif data.name == "author" or data.name == "Author" then
			if string.sub(data.data, 1, 1) ~= "@" then
				data.data = string.format("@%s", data.data)
				encoded = Http:JSONEncode(data)
			else
				encoded = Http:JSONEncode(data)
			end
		else
			encoded = Http:JSONEncode(data)
		end
		if debug ~= nil and debug == true then
			if #encoded ~= 1 then
				print(#encoded .. " bytes injected into " .. self.Name)
			else
				print(#encoded .. " byte injected into " .. self.Name)
			end
		end
		table.insert(self.Table, #self.Table + 1, encoded)
	else
		error()
	end
end

function module.new(name)
	local self = {}

	setmetatable(self, module)

	self.Name = name
	self.Parent = storage
	self.Table = {}

	local Object = Instance.new("StringValue", storage) do Object.Name = self.Name .. "_Metadata" end

	spawn(function()
		while wait(0.000000001) do
			Object.Value = Http:JSONEncode(self)
		end
	end)

	return self
end

return module
