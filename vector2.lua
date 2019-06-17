local mtvector2 = {}

function isvector2( o )
    return o.type == "Vector2"
end

--  > Vector2: methods

local Vector2 = {}
function Vector2:new( x, y )
    local _vector = {}
    _vector.x = x or 0
    _vector.y = y or 0
    _vector.type = "Vector2"
    
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

function Vector2:Angle()
    return math.deg( math.atan2( self.y, self.x ) )
end

function Vector2:Expose()
    return self.x, self.y
end

function Vector2:WithinBox( startPos, endPos )
    if not isvector2( startPos ) or not isvector2( endPos ) then return error( "args must be Vector2 !", 2 ) end
    
    return self.x >= startPos.x and self.x <= endPos.x and
           self.y >= startPos.y and self.y <= endPos.y 
end

function Vector2:Dot( v ) 
    if not isvector2( v ) then return error( "#1 arg must be Vector2 !", 2 ) end
      
    return self.x * v.x + self.y * v.y -- if > 0: look together, elseif < 0: look opposite, elseif == 0: look perpendicular directions
end

function Vector2:IsZero()
    return self.x == 0 and self.y == 0
end

function Vector2:Lenght()
    return math.sqrt( self.x^2 + self.y^2 )
end

function Vector2:Distance( v )
    if not isvector2( v ) then return error( "#1 arg must be Vector2 !", 2 ) end
    
    return math.sqrt( self:DistToSqr( v ) )
end

function Vector2:DistToSqr( v )
    if not isvector2( v ) then return error( "#1 arg must be Vector2 !", 2 ) end
    
    return ( v.x - self.x )^2 + ( v.y - self.y  )^2 
end

function Vector2:GetNormal()
    local m = self:Lenght()
    return Vector2( self.x / m, self.y / m )
end


function Vector2:Normalize()
    local m = self:Lenght()
    self.x = self.x / m
    self.y = self.y / m
    return self
end

function Vector2:Zero()
    self.x = 0
    self.y = 0
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
    return ("x: %f; y: %f"):format( v.x, v.y )
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

function mtvector2.__eq( v1, v2 )
    return v1.x == v2.x and v1.y == v2.y
end

function mtvector2.__newindex( _, k )
    error( ("can't create new index '%s' to Vector"):format( k ), 2 )
end

mtvector2.__metatable = true -- disable external modification
mtvector2.__index = Vector2 -- add Vector2 methods to metatable
mtvector2.__len = function( self )
    return self:Lenght()
end

--  > Vector2: set metamethod _call

setmetatable( Vector2, {
    __call = function( self, ... ) -- call Vector2:new() when we call Vector2()
        return self:new( ... )
    end
} )

return Vector2