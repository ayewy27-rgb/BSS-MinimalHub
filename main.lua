-- GameExploitScanner
-- READ ONLY | DEV TOOL
-- DOES NOT MODIFY GAMEPLAY

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

print("=== GameExploitScanner LOADED ===")

-- CONFIG (ТОЛЬКО ДЛЯ ЛОГОВ)
local MAX_CALLS_PER_SEC = 20
local MAX_NUMBER_VALUE = 1e7

-- DATA
local callLog = {}

local function logWarning(...)
	warn("[EXPLOIT SCAN]", ...)
end

-- REMOTE EVENT SCAN
for _,remote in ipairs(ReplicatedStorage:GetDescendants()) do
	if remote:IsA("RemoteEvent") then
		callLog[remote] = {}

		remote.OnServerEvent:Connect(function(player, ...)
			local now = os.clock()

			callLog[remote][player] = callLog[remote][player] or {}
			local data = callLog[remote][player]

			data.calls = data.calls or {}
			table.insert(data.calls, now)

			-- clean old timestamps
			for i = #data.calls, 1, -1 do
				if now - data.calls[i] > 1 then
					table.remove(data.calls, i)
				end
			end

			-- 1️⃣ СПАМ REMOTE
			if #data.calls > MAX_CALLS_PER_SEC then
				logWarning(
					"REMOTE SPAM",
					player.Name,
					remote.Name,
					"calls/sec:",
					#data.calls
				)
			end

			-- 2️⃣ ВЫЗОВ БЕЗ ПЕРСОНАЖА
			if not player.Character then
				logWarning(
					"REMOTE WIT
