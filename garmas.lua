RegisterCommand('garmas',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local rtime = math.random(100,100)

    if user_id then
        if vRP.hasPermission(user_id,"policia.permissao") then
            TriggerClientEvent("Notify",source,"negado","Negado","Você não pode guardar seus armamentos.")
        else
			
            TriggerClientEvent("Notify",source,"aviso","Aviso","<b>Aguarde</b> seus armamentos estao sendo guardados.",9500)
            TriggerClientEvent("progress",source,10000,"guardando")
            
            SetTimeout(100*rtime,function()
                local weapons = vRPclient.replaceWeapons(source,{})
                for k,v in pairs(weapons) do
                    vRP.giveInventoryItem(user_id,"wbody|"..k,1)
                    if v.ammo > 0 then
                        vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
                    end
					SendWebhookMessage(webhookgarmas,"```Ini\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Armamento]: "..vRP.itemNameList("wbody|"..k).." \n[Munição]: "..v.ammo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                end

                TriggerClientEvent("Notify",source,"sucesso","Sucesso","Seus armamentos foram guardados em sua mochila.")
        
            end)
    
        end
    end
end)
