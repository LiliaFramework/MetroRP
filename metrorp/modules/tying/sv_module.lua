--------------------------------------------------------------------------------------------------------
function MODULE:PlayerLoadout(client)
    client:setNetVar("restricted")
end

--------------------------------------------------------------------------------------------------------
function MODULE:PlayerUse(client, entity)
    if not client:getNetVar("restricted") and entity:IsPlayer() and entity:getNetVar("restricted") and not entity.liaBeingUnTied then
        entity.liaBeingUnTied = true
        entity:setAction("beingUntied", 5)
        client:setAction("unTying", 5)
        client:doStaredAction(
            entity,
            function()
                entity:setRestricted(false)
                entity.liaBeingUnTied = false
                client:EmitSound("npc/roller/blade_in.wav")
            end,
            5,
            function()
                if IsValid(entity) then
                    entity.liaBeingUnTied = false
                    entity:setAction()
                end

                if IsValid(client) then
                    client:setAction()
                end
            end
        )
    end
end

--------------------------------------------------------------------------------------------------------
function MODULE:searchPlayer(client, target)
    if IsValid(target:getNetVar("searcher")) or IsValid(client.nutSearchTarget) then return false end
    if not target:getChar() or not target:getChar():getInv() then return false end
    local inventory = target:getChar():getInv()
    inventory.oldOnAuthorizeTransfer = inventory.onAuthorizeTransfer
    inventory.onAuthorizeTransfer = function(inventory, client2, oldInventory, item)
        if IsValid(client2) and client2 == client then return true end

        return false
    end

    inventory:sync(client)
    inventory.oldGetReceiver = inventory.getReceiver
    inventory.getReceiver = function(inventory) return {client, target} end
    inventory.onCheckAccess = function(inventory, client2)
        if client2 == client then return true end
    end

    local inventory2 = client:getChar():getInv()
    inventory2.oldOnAuthorizeTransfer = inventory2.onAuthorizeTransfer
    inventory2.onAuthorizeTransfer = function(inventory3, client2, oldInventory, item)
        if oldInventory == inventory then return true end

        return inventory2.oldOnAuthorizeTransfer(inventory3, client2, oldInventory, item)
    end

    netstream.Start(client, "searchPly", target, target:getChar():getInv():getID())
    client.nutSearchTarget = target
    target:setNetVar("searcher", client)

    return true
end

--------------------------------------------------------------------------------------------------------
function MODULE:CanPlayerInteractItem(client, action, item)
    if IsValid(client:getNetVar("searcher")) then return false end
end
--------------------------------------------------------------------------------------------------------