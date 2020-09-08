return function()
	describe("rbxlua-api", function()
		it("should load", function()
			local rbxluaApi = require(script.Parent)

			expect(rbxluaApi).to.be.ok()
		end)
	end)
end
