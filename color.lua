local mtcolor = {}

local function clamp( v, min, max )
    return v < min and min or v > max and max or v
end

--  > Color: methods

local Color = {}
function Color:new( r, g, b, a )
    assert( r and g and b, "arguments must be valid" )
    local _color = {}
    _color.r = clamp( r or 0, 0, 255 ) 
    _color.g = clamp( g or 0, 0, 255 ) 
    _color.b = clamp( b or 0, 0, 255 )
    _color.a = clamp( a or 255, 0, 255 )
    
    return setmetatable( _color, mtcolor )
end

function Color:GetRed()
    return self.r
end 

function Color:GetGreen()
    return self.g
end

function Color:GetBlue()
    return self.b
end

function Color:GetAlpha()
    return self.a
end

function Color:Expose()
    return self.r, self.g, self.b, self.a
end

function Color:GetSum( alpha )
    local sum = self.r + self.g + self.b
    return alpha and sum + self.a or sum
end

function Color:SetRed( r )
    self.r = clamp( r, 0, 255 )
    return self.r
end

function Color:SetGreen( g )
    self.g = clamp( g, 0, 255 )
    return self.g
end

function Color:SetBlue( b )
    self.b = clamp( b, 0, 255 )
    return self.b
end

function Color:SetAlpha( a )
    self.a = clamp( a, 0, 255 )
    return self.a
end

--  > mtcolor: metamethods

function mtcolor.__tostring( c )
    return ("r: %d; g: %d; b: %d; a: %d"):format( c.r, c.g, c.b, c.a )
end

function mtcolor.__add( c1, c2 )
    local r = c1.r + c2.r
    local g = c1.g + c2.g
    local b = c1.b + c2.b
    local a = c1.a + c2.a
    return Color:new( r, g, b, a )
end

function mtcolor.__sub( c1, c2 )
    local r = c1.r - c2.r
    local g = c1.g - c2.g
    local b = c1.b - c2.b
    local a = c1.a - c2.a
    return Color:new( r, g, b, a )
end

function mtcolor.__mul( c1, c2 )
    local r = c1.r * c2.r
    local g = c1.g * c2.g
    local b = c1.b * c2.b
    local a = c1.a * c2.a
    return Color:new( r, g, b, a )
end

function mtcolor.__div( c1, c2 )
    local r = c1.r / c2.r
    local g = c1.g / c2.g
    local b = c1.b / c2.b
    local a = c1.a / c2.a
    return Color:new( r, g, b, a )
end

function mtcolor.__newindex( _, k )
    error( ("can't create new index '%s' to Color"):format( k ), 2 )
end

mtcolor.__metatable = true
mtcolor.__index = Color

--  > Color: set metamethod _call

setmetatable( Color,  {
  __call = function ( self, ... )
      return self:new( ... )
  end
} )

return Color
