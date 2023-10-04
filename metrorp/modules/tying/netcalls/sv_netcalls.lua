--------------------------------------------------------------------------------------------------------
netstream.Hook(
	"searchExit",
	function(client)
		local target = client.nutSearchTarget
		if IsValid(target) and target:getNetVar("searcher") == client then
			local inventory = target:getChar():getInv()
			inventory.onAuthorizeTransfer = inventory.oldOnAuthorizeTransfer
			inventory.oldOnAuthorizeTransfer = nil
			inventory.getReceiver = inventory.oldGetReceiver
			inventory.oldGetReceiver = nil
			inventory.onCheckAccess = nil
			local inventory2 = client:getChar():getInv()
			inventory2.onAuthorizeTransfer = inventory2.oldOnAuthorizeTransfer
			inventory2.oldOnAuthorizeTransfer = nil
			target:setNetVar("searcher", nil)
			client.nutSearchTarget = nil
		end
	end
)
--------------------------------------------------------------------------------------------------------