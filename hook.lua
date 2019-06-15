local Hook = {}
      Hook.debug = true
local hooks = {}

local function _print( ... ) 
    if not Hook.debug then return end
    print( ... ) 
end

--  > Hook: methods

function Hook.Add( event, id, func )
    if not event or not type(event) == "string" then error( "#1 argument must be valid and be a string", 2 ) end
    if not id or not type(id) == "string" then error( "#2 argument must be valid and be a string", 2 ) end
    if not func or not type(func) == "function" then error( "#3 argument must be valid", 2 ) end
    
    if not hooks[event] then hooks[event] = {} end
    hooks[event][id] = func
    
    _print( ("Add hook with event '%s' and id '%s'"):format( event, id ) )
end

function Hook.Remove( event, id )
    if not event or not type(event) == "string" then error( "#1 argument must be valid and be a string", 2 ) end
    if not id or not type(id) == "string" then error( "#2 argument must be valid and be a string", 2 ) end
    
    if not hooks[event] or not hooks[event][id] then return print( ( "Hook with event '%s' and id '%s' doesn't exists" ):format( event, id ) ) end
    hooks[event][id] = nil
    
    _print( ("Remove hook with event '%s' and id '%s'"):format( event, id ) )
end

function Hook.Call( event, id, ... )
    if not event or not type(event) == "string" then error( "#1 argument must be valid and be a string", 2 ) end

    if not hooks[event] then return print( ( "Hooks with event '%s' don't exists" ):format( event ) ) end

    if hooks[event][id] then
        hooks[event][id]( ... )
        _print( ("Call hook with event '%s' and id '%s'"):format( event, id ) )
    elseif not id then
        _print( ("Call hooks with event '%s'"):format( event ) )
        for _, v in pairs( hooks[event] ) do 
            v( ... )
        end
    else
        _print( ("There is no hooks with event '%s' and id '%s'"):format( event, id ) )
    end
end

function Hook.SetDebug( state )
    if state == nil or not type(state) == "boolean" then error( "#1 argument must be valid and be a boolean", 2 ) end
    
    Hook.debug = state
end

return Hook