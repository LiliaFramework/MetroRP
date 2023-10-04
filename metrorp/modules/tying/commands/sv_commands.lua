--------------------------------------------------------------------------------------------------------
lia.command.add(
	"charsearch",
	{
		onRun = function(client, arguments)
			local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client
			local target = util.TraceLine(data).Entity
			if IsValid(target) and target:IsPlayer() and target:getNetVar("restricted") then
				MODULE:searchPlayer(client, target)
			end
		end
	}
)
--------------------------------------------------------------------------------------------------------