RegisterCommand("propfix", function()
    local ped = PlayerPedId()

    -- projdeme entity v okolí
    for obj in EnumerateObjects() do
        if IsEntityAttachedToEntity(obj, ped) then
            DetachEntity(obj, true, true)
            DeleteEntity(obj)
        end
    end

    ClearPedTasksImmediately(ped) -- ukončí případné animace

    TriggerEvent('chat:addMessage', {
        color = { 0, 255, 0 },
        multiline = false,
        args = { "PropFix", "Odstraněny všechny připojené objekty!" }
    })
end, false)

-- Enumerator pro objekty
function EnumerateObjects()
    return coroutine.wrap(function()
        local handle, object = FindFirstObject()
        if not handle or handle == -1 then return end
        local success
        repeat
            coroutine.yield(object)
            success, object = FindNextObject(handle)
        until not success
        EndFindObject(handle)
    end)
end
