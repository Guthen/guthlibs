local mtvector2 = {}

--  > Vector2: methods

local Vector2 = {}
function Vector2:new( x, y )
    local _vector = {}
    _vector.x = x or 0
    _vector.y = y or 0
    
    return setmetatable( _vector, mtvector2 )
end

function Vector2:GetX()
    return self.x
end

function Vector2:GetY()
    return self.y
end

function Vector2:GetSum()
    return self.x + self.y
end

function Vector2:Expose()
    return self.x, self.y
end

function Vector2:SetX( x )
    self.x = x or 0
    return self.x
end

function Vector2:SetY( y )
    self.y = y or 0
    return self.y
end

--  > mtvector2: metamethods

function mtvector2.__tostring( v )
    return ("x: %d; y: %d"):format( v.x, v.y )
end 

function mtvector2.__add( v1, v2 )
    return Vector2:new( v1.x + v2.x, v1.y + v2.y )
end

function mtvector2.__sub( v1, v2 )
    return Vector2:new( v1.x - v2.x, v1.y - v2.y )
end

function mtvector2.__mul( v1, v2 )
    return Vector2:new( v1.x * v2.x, v1.y * v2.y )
end

function mtvector2.__div( v1, v2 )
    return Vector2:new( v1.x / v2.x, v1.y / v2.y )
end

function mtvector2.__newindex( _, k )
    error( ("can't create new index '%s' to Vector"):format( k ), 2 )
end

mtvector2.__metatable = true -- disable external modification
mtvector2.__index = Vector2 -- add Vector2 methods to metatable

--  > Vector2: set metamethod _call

setmetatable( Vector2, {
    __call = function( self, ... ) -- call Vector2:new() when we call Vector2()
        return self:new( ... )
    end
} )

return Vector2