--------------------------------------------------------------------------------------------------------
function MODULE:LoadData()
	local savedTable = self:getData() or {}
	for k, v in ipairs(savedTable) do
		local camera = ents.Create(v.class)
		camera:SetPos(v.pos)
		camera:SetAngles(v.ang)
		camera:Spawn()
		camera:Activate()
	end
end

--------------------------------------------------------------------------------------------------------
function MODULE:SaveData()
	local savedTable = {}
	for k, v in ipairs(ents.GetAll()) do
		if v:isCamera() then
			table.insert(
				savedTable,
				{
					class = v:GetClass(),
					pos = v:GetPos(),
					ang = v:GetAngles()
				}
			)
		end
	end

	self:setData(savedTable)
end
--------------------------------------------------------------------------------------------------------