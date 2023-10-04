--------------------------------------------------------------------------------------------------------
netstream.Hook(
    "searchPly",
    function(target, index)
        local inventory = lia.item.inventories[index]
        if not inventory then return netstream.Start("searchExit") end
        lia.gui.inv1 = vgui.Create("nutInventory")
        lia.gui.inv1:ShowCloseButton(true)
        lia.gui.inv1:setInventory(LocalPlayer():getChar():getInv())
        local panel = vgui.Create("nutInventory")
        panel:ShowCloseButton(true)
        panel:SetTitle(target:Name())
        panel:setInventory(inventory)
        panel:MoveLeftOf(lia.gui.inv1, 4)
        panel.OnClose = function(this)
            if IsValid(lia.gui.inv1) and not IsValid(lia.gui.menu) then
                lia.gui.inv1:Remove()
            end

            netstream.Start("searchExit")
        end

        local oldClose = lia.gui.inv1.OnClose
        lia.gui.inv1.OnClose = function()
            if IsValid(panel) and not IsValid(lia.gui.menu) then
                panel:Remove()
            end

            netstream.Start("searchExit")
            lia.gui.inv1.OnClose = oldClose
        end

        lia.gui["inv" .. index] = panel
    end
)
--------------------------------------------------------------------------------------------------------