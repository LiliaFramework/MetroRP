--------------------------------------------------------------------------------------------------------
function MODULE:DrawCharInfo(client, character, info)
	if client:getNetVar("restricted") then
		info[#info + 1] = {L"isTied", Color(245, 215, 110)}
	end
end

--------------------------------------------------------------------------------------------------------
function MODULE:CanPlayerViewInventory()
	if IsValid(LocalPlayer():getNetVar("searcher")) then return false end
end
--------------------------------------------------------------------------------------------------------