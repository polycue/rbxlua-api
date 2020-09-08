-- luacheck: globals __LEMUR__

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local isRobloxCli, ProcessService = pcall(game.GetService, game, "ProcessService")

local Roact = require(ReplicatedStorage.RBXLuaAPI)
local TestEZ = require(ReplicatedStorage.TestEZ)

local results = TestEZ.TestBootstrap:run(ReplicatedStorage.RBXLuaAPI, TestEZ.Reporters.TextReporter)

local statusCode = results.failureCount == 0 and 0 or 1

if __LEMUR__ then
	if results.failureCount > 0 then
		os.exit(statusCode)
	end
elseif isRobloxCli then
	ProcessService:Exit(statusCode)
end
