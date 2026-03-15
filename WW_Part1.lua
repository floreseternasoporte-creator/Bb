--[[
╔══════════════════════════════════════════════════════════════════════════════╗
║       ⚡ WIZARDING WORLD — HOGWARTS & BEYOND  v1.0  ⚡                      ║
║                                                                              ║
║  Mundo completo del Universo de Harry Potter:                               ║
║  • Castillo de Hogwarts con torres, almenas y grandes salones               ║
║  • Bosque Prohibido: árboles oscuros, niebla, hongos mágicos                ║
║  • Lago Negro con Giant Squid tentáculos y reflejo lunar                    ║
║  • Hogsmeade: casitas nevadas, Tres Escobas, Honeydukes                     ║
║  • Andén 9¾ oculto en la roca del acantilado                               ║
║  • Cielo mágico: aurora boreal, estrellas animadas, luna grande             ║
║  • Sistema de clima: niebla escocesa, lluvia, nieve mágica                 ║
║  • Luces flotantes (velas de Hogwarts), fantasmas Neon                      ║
║  • Plantas mágicas: Mandrágoras, Venomous Tentacula, Whomping Willow        ║
║  • Ciclo día/noche con atmósfera propia del mundo mágico                   ║
╚══════════════════════════════════════════════════════════════════════════════╝
--]]

local Workspace    = game:GetService("Workspace")
local Lighting     = game:GetService("Lighting")
local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Terrain      = Workspace.Terrain

-- ═══════════════════════════════════════════════════════════════════
-- CONFIG GLOBAL — WIZARDING WORLD
-- ═══════════════════════════════════════════════════════════════════
local W = {
    SIZE_X    = 3200,
    SIZE_Z    = 3200,
    BASE_Y    = 0,
    SEED      = 42,
    -- Posiciones clave del mundo
    HOGWARTS_X  = 0,
    HOGWARTS_Z  = -600,
    LAKE_X      = 200,
    LAKE_Z      = -200,
    FOREST_X    = -800,
    FOREST_Z    = 0,
    HOGSMEADE_X = 400,
    HOGSMEADE_Z = 300,
    C = {
        -- Terreno escocés
        G_BASE      = Color3.fromRGB(52,  88,  30),
        G_MID       = Color3.fromRGB(62, 102,  38),
        G_BRIGHT    = Color3.fromRGB(72, 118,  42),
        G_DARK      = Color3.fromRGB(35,  62,  18),
        G_MOOR      = Color3.fromRGB(72,  68,  42),   -- páramo
        G_HEATHER   = Color3.fromRGB(115, 68, 110),   -- brezo morado
        G_MOSS      = Color3.fromRGB(45,  85,  28),
        DIRT        = Color3.fromRGB(120,  95,  55),
        DIRT_D      = Color3.fromRGB( 88,  68,  35),
        MUD         = Color3.fromRGB( 72,  58,  38),
        -- Piedra del castillo (arenisca oscura escocesa)
        S_BASE      = Color3.fromRGB(105,  98,  85),
        S_DARK      = Color3.fromRGB( 68,  62,  52),
        S_LIGHT     = Color3.fromRGB(148, 138, 118),
        S_MID       = Color3.fromRGB(125, 115,  98),
        S_AGED      = Color3.fromRGB( 88,  82,  68),
        S_MOSS      = Color3.fromRGB( 65,  95,  48),
        S_STAIN     = Color3.fromRGB( 78,  72,  58),
        -- Tejado (pizarra)
        SLATE       = Color3.fromRGB( 55,  58,  68),
        SLATE_D     = Color3.fromRGB( 38,  40,  50),
        SLATE_L     = Color3.fromRGB( 78,  82,  95),
        -- Bosque Prohibido
        F_BARK      = Color3.fromRGB( 38,  28,  18),
        F_BARK2     = Color3.fromRGB( 55,  42,  25),
        F_BARK3     = Color3.fromRGB( 28,  22,  14),
        F_LEAF_D    = Color3.fromRGB( 18,  45,  12),
        F_LEAF_M    = Color3.fromRGB( 25,  58,  15),
        F_LEAF_B    = Color3.fromRGB( 12,  32,   8),  -- muy oscuro
        F_MOSS      = Color3.fromRGB( 38,  72,  28),
        F_FERN      = Color3.fromRGB( 52,  85,  35),
        F_MUSHROOM  = Color3.fromRGB(185,  45,  22),  -- hongos rojos
        F_MUSHROOM2 = Color3.fromRGB(228, 168,  28),  -- hongos dorados
        F_GLOW      = Color3.fromRGB( 88, 248,  88),  -- plantas luminosas
        -- Lago Negro
        LAKE_D      = Color3.fromRGB(  8,  18,  45),
        LAKE_M      = Color3.fromRGB( 12,  28,  65),
        LAKE_S      = Color3.fromRGB( 20,  42,  88),
        LAKE_GLOW   = Color3.fromRGB( 28,  68, 148),
        LAKE_REFLECT= Color3.fromRGB( 45,  95, 188),
        SQUID       = Color3.fromRGB( 48,  28,  55),  -- tentáculos
        -- Hogsmeade (casitas nevadas)
        H_WALL      = Color3.fromRGB(225, 215, 198),
        H_WALL2     = Color3.fromRGB(205, 192, 172),
        H_WOOD      = Color3.fromRGB(108,  72,  38),
        H_WOOD2     = Color3.fromRGB( 82,  52,  22),
        H_ROOF      = Color3.fromRGB( 78,  55,  38),
        H_SNOW_R    = Color3.fromRGB(235, 242, 255),  -- nieve en tejados
        H_SIGN      = Color3.fromRGB(175, 125,  48),
        H_CHIMNEY   = Color3.fromRGB( 88,  58,  38),
        H_WINDOW    = Color3.fromRGB(245, 218, 128),  -- luz cálida
        -- Magia / efectos
        MAGIC_GOLD  = Color3.fromRGB(255, 215,  45),
        MAGIC_PURP  = Color3.fromRGB(158,  45, 255),
        MAGIC_BLUE  = Color3.fromRGB( 45, 148, 255),
        MAGIC_GREEN = Color3.fromRGB( 45, 255, 128),
        MAGIC_SPARK = Color3.fromRGB(255, 245, 155),
        GHOST_COL   = Color3.fromRGB(195, 225, 255),
        CANDLE_F    = Color3.fromRGB(255, 188,  55),
        -- Clima
        FOG_MIST    = Color3.fromRGB(165, 175, 195),
        FOG_NIGHT   = Color3.fromRGB( 25,  32,  55),
        RAIN_DROP   = Color3.fromRGB(155, 185, 225),
        SNOW_W      = Color3.fromRGB(240, 248, 255),
        CLOUD_W     = Color3.fromRGB(195, 205, 225),
        CLOUD_D     = Color3.fromRGB(105, 115, 138),
        -- Montañas escocesas
        M_BASE      = Color3.fromRGB( 75,  65,  55),
        M_MID       = Color3.fromRGB(108,  98,  85),
        M_HIGH      = Color3.fromRGB(145, 135, 118),
        M_SNOW      = Color3.fromRGB(235, 242, 255),
        M_HEATHER   = Color3.fromRGB(105,  60, 100),
        -- Plantas mágicas
        MANDRAKE    = Color3.fromRGB( 85, 138,  48),
        MANDRAKE_R  = Color3.fromRGB(155,  68,  38),
        TENTACULA   = Color3.fromRGB( 28, 108,  48),
        TENTACULA2  = Color3.fromRGB( 18,  78,  32),
        WHOMPING    = Color3.fromRGB( 62,  42,  22),
        WHOMPING2   = Color3.fromRGB( 45,  28,  12),
        -- General
        PATH_COBBLE = Color3.fromRGB(118, 108,  92),
        PATH_EDGE   = Color3.fromRGB( 88,  80,  65),
        SAND_L      = Color3.fromRGB(195, 180, 148),
        WATER_EDGE  = Color3.fromRGB( 88, 125, 175),
    }
}

-- ═══════════════════════════════════════════════════════════════════
-- ESTADO DEL CLIMA
-- ═══════════════════════════════════════════════════════════════════
local WeatherState = {
    current     = "misty",  -- "misty", "rain", "snow", "storm", "clear"
    transition  = false,
    rainParts   = {},
    snowParts   = {},
    cloudParts  = {},
    weatherFolder = nil,
    magicRefs   = {},   -- efectos mágicos animados
    leafRefs    = {},   -- hojas para animaciones
    candleRefs  = {},   -- velas flotantes
    ghostRefs   = {},   -- fantasmas
}

-- ═══════════════════════════════════════════════════════════════════
-- UTILIDADES
-- ═══════════════════════════════════════════════════════════════════
local function rng(a,b)     return a + math.random()*(b-a) end
local function rngi(a,b)    return math.random(a,b) end
local function clamp(v,a,b) return math.max(a,math.min(b,v)) end
local function lerp(a,b,t)  return a+(b-a)*t end
local function lc(c1,c2,t)
    t=clamp(t,0,1)
    return Color3.new(lerp(c1.R,c2.R,t),lerp(c1.G,c2.G,t),lerp(c1.B,c2.B,t))
end
local function fnoise(x,z,oct,pers,lac,scale,seed)
    local val,amp,freq,maxV=0,1,1,0; seed=seed or 0
    for i=1,oct do
        val=val+math.noise(x/scale*freq+seed*0.13+i*17.3,
            z/scale*freq+seed*0.13+i*9.7)*amp
        maxV=maxV+amp; amp=amp*pers; freq=freq*lac
    end
    return val/maxV
end

-- Altura del terreno escocés (más ondulado y dramático)
local function groundH(x,z)
    local hX=W.SIZE_X*0.5; local hZ=W.SIZE_Z*0.5
    -- Base ondulada con colinas escocesas
    local h = fnoise(x,z,6,0.54,2.1,150,W.SEED)*8.5
    -- Elevación extra cerca de Hogwarts (acantilado)
    local distHog = math.sqrt((x-W.HOGWARTS_X)^2 + (z-W.HOGWARTS_Z)^2)
    local cliffBoost = math.max(0, (1 - distHog/300)) * 18
    -- Hondonada del lago
    local distLake = math.sqrt((x-W.LAKE_X)^2 + (z-W.LAKE_Z)^2)
    local lakeDip = math.max(0, (1 - distLake/220)) * -6
    -- Borde del mapa
    local fx=clamp(math.min((x+hX)/120,(hX-x)/120),0,1)
    local fz=clamp(math.min((z+hZ)/120,(hZ-z)/120),0,1)
    return W.BASE_Y + (h + cliffBoost + lakeDip)*fx*fz
end
local function surfaceH(x,z) return groundH(x,z)+0.5 end

local occupied = {}
local windParts = {}
local windStarted = false

local function isOcc(x,z,r)
    for _,p in ipairs(occupied) do
        local dx,dz=p.x-x,p.z-z
        if dx*dx+dz*dz<(p.r+r)*(p.r+r) then return true end
    end
    return false
end
local function markOcc(x,z,r) occupied[#occupied+1]={x=x,z=z,r=r} end

local function regWind(part,ampDeg,spd,phase,ax)
    if #windParts>3500 then return end
    windParts[#windParts+1]={p=part,base=part.CFrame,
        amp=math.rad(ampDeg),speed=spd,phase=phase or 0,axis=ax or 0.4}
end
local function startWind()
    if windStarted then return end; windStarted=true
    task.spawn(function()
        while true do
            local t=tick()
            for i=1,#windParts do
                local w=windParts[i]
                if w.p and w.p.Parent then
                    local sw=math.sin(t*w.speed+w.phase)*w.amp
                    local sd=math.cos(t*w.speed*0.65+w.phase*1.4)*w.amp*w.axis
                    w.p.CFrame=w.base*CFrame.Angles(sw,0,sd)
                end
            end
            task.wait(0.05)
        end
    end)
end

local FW
local function mkFolder(name,parent)
    parent=parent or Workspace
    local old=parent:FindFirstChild(name); if old then old:Destroy() end
    local f=Instance.new("Folder"); f.Name=name; f.Parent=parent; return f
end

-- ═══════════════════════════════════════════════════════════════════
-- HELPERS DE PARTES
-- ═══════════════════════════════════════════════════════════════════
local function mp(t)
    local p=Instance.new("Part")
    p.Anchored=true; p.CanCollide=t.cc~=false; p.CastShadow=t.cs~=false
    p.TopSurface=Enum.SurfaceType.Smooth; p.BottomSurface=Enum.SurfaceType.Smooth
    p.Size=t.sz or Vector3.new(4,1,4)
    p.Color=t.col or W.C.S_BASE
    p.Material=t.mat or Enum.Material.SmoothPlastic
    p.Transparency=t.tr or 0; p.Name=t.n or "P"
    if t.cf then p.CFrame=t.cf else p.Position=t.pos or Vector3.new(0,0,0) end
    p.Parent=t.par or FW; return p
end
local function mw(t)
    local p=Instance.new("WedgePart")
    p.Anchored=true; p.CanCollide=t.cc~=false; p.CastShadow=true
    p.TopSurface=Enum.SurfaceType.Smooth; p.BottomSurface=Enum.SurfaceType.Smooth
    p.Size=t.sz or Vector3.new(4,4,4)
    p.Color=t.col or W.C.S_BASE
    p.Material=t.mat or Enum.Material.SmoothPlastic
    p.Name=t.n or "W"; p.CFrame=t.cf or CFrame.new(0,0,0)
    p.Parent=t.par or FW; return p
end
local function mc(t)
    -- Cilindro
    local p=Instance.new("Part")
    p.Anchored=true; p.CanCollide=t.cc~=false; p.CastShadow=t.cs~=false
    p.Shape=Enum.PartType.Cylinder
    p.TopSurface=Enum.SurfaceType.Smooth; p.BottomSurface=Enum.SurfaceType.Smooth
    p.Size=t.sz or Vector3.new(4,4,4)
    p.Color=t.col or W.C.S_BASE
    p.Material=t.mat or Enum.Material.SmoothPlastic
    p.Transparency=t.tr or 0; p.Name=t.n or "C"
    if t.cf then p.CFrame=t.cf else p.Position=t.pos or Vector3.new(0,0,0) end
    p.Parent=t.par or FW; return p
end

-- ═══════════════════════════════════════════════════════════════════
-- 1. ATMÓSFERA MÁGICA
-- ═══════════════════════════════════════════════════════════════════
local atmoInst, bloomInst, ccInst, sunRaysInst

local function setupAtmosphere()
    for _,c in ipairs(Lighting:GetChildren()) do
        if c:IsA("Sky") or c:IsA("Atmosphere") or c:IsA("BloomEffect")
            or c:IsA("ColorCorrectionEffect") or c:IsA("SunRaysEffect") then c:Destroy() end
    end
    -- Hogwarts late afternoon / twilight feel
    Lighting.Brightness         = 1.8
    Lighting.ClockTime          = 17.5
    Lighting.GeographicLatitude = 57      -- Escocia
    Lighting.ShadowSoftness     = 0.45
    Lighting.Ambient            = Color3.fromRGB( 72,  78, 105)
    Lighting.OutdoorAmbient     = Color3.fromRGB(100, 108, 142)
    Lighting.EnvironmentDiffuseScale  = 0.65
    Lighting.EnvironmentSpecularScale = 0.35
    Lighting.FogEnd   = 1400; Lighting.FogStart = 700
    Lighting.FogColor = W.C.FOG_MIST

    atmoInst = Instance.new("Atmosphere")
    atmoInst.Density = 0.48; atmoInst.Offset = 0.18
    atmoInst.Color   = Color3.fromRGB(165, 178, 215)
    atmoInst.Decay   = Color3.fromRGB( 85, 100, 165)
    atmoInst.Glare   = 0.18; atmoInst.Haze = 2.8
    atmoInst.Parent  = Lighting

    bloomInst = Instance.new("BloomEffect")
    bloomInst.Intensity  = 0.55
    bloomInst.Size       = 28
    bloomInst.Threshold  = 0.72
    bloomInst.Parent     = Lighting

    ccInst = Instance.new("ColorCorrectionEffect")
    ccInst.Brightness = -0.04; ccInst.Contrast = 0.22
    ccInst.Saturation = 0.15
    ccInst.TintColor  = Color3.fromRGB(215, 222, 245)
    ccInst.Parent     = Lighting

    sunRaysInst = Instance.new("SunRaysEffect")
    sunRaysInst.Intensity = 0.22; sunRaysInst.Spread = 0.65
    sunRaysInst.Parent    = Lighting

    print("✅ Atmósfera mágica lista")
end

-- ═══════════════════════════════════════════════════════════════════
-- 2. CICLO DÍA/NOCHE — Ambiente Hogwarts
-- ═══════════════════════════════════════════════════════════════════
local DayNightCycle = {
    periods = {
        {time=6.0,  dur=55,  name="Amanecer Escocés",  fog=Color3.fromRGB(200,165,125), amb=Color3.fromRGB(145,105, 75), bright=1.2, sat=0.05},
        {time=9.0,  dur=80,  name="Mañana Brumosa",    fog=Color3.fromRGB(165,175,195), amb=Color3.fromRGB( 90, 98,132), bright=1.6, sat=0.12},
        {time=13.0, dur=85,  name="Mediodía",          fog=Color3.fromRGB(158,170,205), amb=Color3.fromRGB( 98,108,148), bright=2.0, sat=0.18},
        {time=16.5, dur=65,  name="Tarde Dorada",      fog=Color3.fromRGB(215,165, 95), amb=Color3.fromRGB(165,115, 65), bright=1.8, sat=0.15},
        {time=18.5, dur=50,  name="Atardecer Mágico",  fog=Color3.fromRGB(205,100, 65), amb=Color3.fromRGB(175, 75, 45), bright=1.1, sat=0.10},
        {time=20.5, dur=55,  name="Crepúsculo",        fog=Color3.fromRGB( 45, 52,105), amb=Color3.fromRGB( 38, 45, 95), bright=0.5, sat=-0.05},
        {time=23.0, dur=110, name="Noche Mágica",      fog=Color3.fromRGB( 12, 18, 55), amb=Color3.fromRGB( 18, 22, 72), bright=0.2, sat=-0.12},
        {time=3.5,  dur=50,  name="Madrugada",         fog=Color3.fromRGB( 28, 35, 82), amb=Color3.fromRGB( 35, 42,100), bright=0.3, sat=-0.08},
    },
    candleAnimParts = {},
    starParts       = {},
    moonPart        = nil,
}

local function startDayNightCycle(DNF)
    -- Estrellas mágicas
    local starCount = 200
    for i=1, starCount do
        local sx = rng(-W.SIZE_X*0.45, W.SIZE_X*0.45)
        local sz = rng(-W.SIZE_Z*0.45, W.SIZE_Z*0.45)
        local sy = W.BASE_Y + rng(320, 520)
        local ss = rng(0.3, 0.9)
        local star = mp({n="Star", sz=Vector3.new(ss,ss*0.3,ss),
            pos=Vector3.new(sx, sy, sz),
            col=lc(W.C.MAGIC_SPARK, W.C.GHOST_COL, rng(0,1)),
            mat=Enum.Material.Neon, tr=1.0, cc=false, cs=false, par=DNF})
        local pl = Instance.new("PointLight")
        pl.Brightness=0; pl.Range=4; pl.Color=W.C.MAGIC_SPARK; pl.Parent=star
        DayNightCycle.starParts[#DayNightCycle.starParts+1] = {part=star, light=pl, phase=rng(0,math.pi*2)}
    end

    -- Luna grande
    local moon = mp({n="Moon", sz=Vector3.new(55,55,12),
        pos=Vector3.new(W.LAKE_X+180, W.BASE_Y+440, W.LAKE_Z-120),
        col=Color3.fromRGB(235,238,255), mat=Enum.Material.Neon,
        tr=1.0, cc=false, cs=false, par=DNF})
    local moonLight = Instance.new("PointLight")
    moonLight.Brightness=0; moonLight.Range=600; moonLight.Color=Color3.fromRGB(200,210,255)
    moonLight.Parent=moon
    DayNightCycle.moonPart = {part=moon, light=moonLight}

    -- Velas flotantes de Hogwarts (animadas)
    local candleCount = 120
    local hx = W.HOGWARTS_X; local hz = W.HOGWARTS_Z
    for i=1, candleCount do
        local ang = rng(0, math.pi*2)
        local dist = rng(20, 85)
        local cx2 = hx + math.cos(ang)*dist
        local cz2 = hz + math.sin(ang)*dist
        local cy = groundH(cx2, cz2) + rng(8, 45)
        -- Cuerpo de vela
        local cand = mc({n="Candle", sz=Vector3.new(0.5, 0.5, 1.8),
            cf=CFrame.new(cx2, cy, cz2)*CFrame.Angles(0,0,math.rad(90)),
            col=Color3.fromRGB(248,242,225), mat=Enum.Material.SmoothPlastic,
            cc=false, cs=false, par=DNF})
        -- Llama Neon
        local flame = mp({n="Flame", sz=Vector3.new(0.38, 0.55, 0.38),
            pos=Vector3.new(cx2, cy+1.1, cz2),
            col=W.C.CANDLE_F, mat=Enum.Material.Neon,
            tr=0.25, cc=false, cs=false, par=DNF})
        local fl2 = Instance.new("PointLight")
        fl2.Brightness=1.8; fl2.Range=8; fl2.Color=W.C.CANDLE_F; fl2.Parent=flame
        WeatherState.candleRefs[#WeatherState.candleRefs+1] = {
            candle=cand, flame=flame, light=fl2,
            baseX=cx2, baseY=cy, baseZ=cz2, phase=rng(0,math.pi*2)
        }
    end

    -- Fantasmas (Nick Casi Decapitado, Moaning Myrtle...)
    local ghostDefs = {
        {x=W.HOGWARTS_X+12, z=W.HOGWARTS_Z+8,   name="Nick"},
        {x=W.HOGWARTS_X-20, z=W.HOGWARTS_Z+15,  name="Moaning"},
        {x=W.HOGWARTS_X+35, z=W.HOGWARTS_Z-18,  name="Friar"},
        {x=W.HOGWARTS_X-18, z=W.HOGWARTS_Z-22,  name="Baron"},
    }
    for _, gd in ipairs(ghostDefs) do
        local gy = groundH(gd.x, gd.z) + 4
        local ghost = mp({n="Ghost_"..gd.name, sz=Vector3.new(3.5, 5.5, 1.2),
            pos=Vector3.new(gd.x, gy, gd.z),
            col=W.C.GHOST_COL, mat=Enum.Material.Neon,
            tr=0.72, cc=false, cs=false, par=DNF})
        local gLight = Instance.new("PointLight")
        gLight.Brightness=0.8; gLight.Range=12; gLight.Color=W.C.GHOST_COL
        gLight.Parent=ghost
        WeatherState.ghostRefs[#WeatherState.ghostRefs+1] = {
            part=ghost, light=gLight, bx=gd.x, bz=gd.z, by=gy, phase=rng(0,math.pi*2)
        }
    end

    task.spawn(function()
        local periodIdx = 1
        while true do
            local p = DayNightCycle.periods[periodIdx]
            local nextIdx = (periodIdx % #DayNightCycle.periods) + 1
            local pNext = DayNightCycle.periods[nextIdx]
            local transTime = 8.0
            local holdTime = p.dur - transTime
            if holdTime > 0 then
                Lighting.ClockTime = p.time
                Lighting.FogColor  = p.fog
                Lighting.Ambient   = p.amb
                Lighting.Brightness = p.bright
                if ccInst then ccInst.Saturation = p.sat end
                task.wait(holdTime)
            end
            local steps = 40
            for s=1, steps do
                local t2 = s/steps
                local ct1 = p.time; local ct2 = pNext.time
                if ct2 < ct1 then ct2 = ct2 + 24 end
                local ct = ct1 + (ct2-ct1)*t2
                if ct >= 24 then ct = ct - 24 end
                Lighting.ClockTime  = ct
                Lighting.FogColor   = lc(p.fog, pNext.fog, t2)
                Lighting.Ambient    = lc(p.amb, pNext.amb, t2)
                Lighting.Brightness = lerp(p.bright, pNext.bright, t2)
                if ccInst then ccInst.Saturation = lerp(p.sat, pNext.sat, t2) end
                task.wait(transTime/steps)
            end
            periodIdx = nextIdx
        end
    end)

    -- Animación estrellas (parpadean de noche)
    task.spawn(function()
        while true do
            local t = tick()
            local isNight = Lighting.ClockTime > 19.5 or Lighting.ClockTime < 7
            local moonVis = Lighting.ClockTime > 20 or Lighting.ClockTime < 6
            -- Luna
            if DayNightCycle.moonPart then
                local m = DayNightCycle.moonPart
                m.part.Transparency = moonVis and 0.05 or 1.0
                m.light.Brightness  = moonVis and (0.6+math.sin(t*0.2)*0.15) or 0
            end
            -- Estrellas
            for _, st in ipairs(DayNightCycle.starParts) do
                if st.part and st.part.Parent then
                    local b = isNight and (math.sin(t*1.2+st.phase)*0.4+0.6) or 0
                    st.light.Brightness  = b * 1.8
                    st.part.Transparency = isNight and (1 - b*0.65) or 1.0
                end
            end
            -- Velas flotantes (siempre encendidas, flotan)
            for _, cv in ipairs(WeatherState.candleRefs) do
                if cv.candle and cv.candle.Parent then
                    local bob = math.sin(t*0.55 + cv.phase)*1.2
                    local sway = math.cos(t*0.38 + cv.phase)*0.8
                    cv.candle.Position = Vector3.new(cv.baseX+sway*0.2, cv.baseY+bob, cv.baseZ+sway*0.1)
                    cv.flame.Position  = Vector3.new(cv.baseX+sway*0.2, cv.baseY+bob+1.1, cv.baseZ+sway*0.1)
                    cv.light.Brightness = 1.6 + math.sin(t*2.1+cv.phase)*0.4
                end
            end
            -- Fantasmas flotan y aparecen de noche
            for _, gh in ipairs(WeatherState.ghostRefs) do
                if gh.part and gh.part.Parent then
                    local vis = isNight and 0.65 or 0.88
                    local bob = math.sin(t*0.45 + gh.phase)*1.5
                    local drift = math.cos(t*0.28 + gh.phase)*2.5
                    gh.part.Position = Vector3.new(gh.bx + drift, gh.by + bob + 2, gh.bz)
                    gh.part.Transparency = vis
                    gh.light.Brightness = isNight and (0.9+math.sin(t*0.8+gh.phase)*0.2) or 0.3
                end
            end
            task.wait(0.1)
        end
    end)

    print("✅ Ciclo día/noche mágico iniciado")
end

-- ═══════════════════════════════════════════════════════════════════
-- 3. SISTEMA DE CLIMA — Escocia Mágica
-- ═══════════════════════════════════════════════════════════════════
local function createMistSystem(WF2)
    local hX = W.SIZE_X*0.5; local hZ = W.SIZE_Z*0.5
    -- Bancos de niebla baja al nivel del suelo
    for i=1, 55 do
        local mx = rng(-hX*0.75, hX*0.75)
        local mz = rng(-hZ*0.75, hZ*0.75)
        local my = groundH(mx,mz) + rng(0.2, 2.5)
        local mW = rng(55, 180); local mD = rng(40, 140)
        mp({n="MistBank", sz=Vector3.new(mW, rng(1.5,4.5), mD),
            pos=Vector3.new(mx, my, mz),
            col=W.C.FOG_MIST, mat=Enum.Material.SmoothPlastic,
            tr=rng(0.52, 0.78), cc=false, cs=false, par=WF2})
    end
    print("✅ Niebla escocesa creada")
end

local function createRainSystem(WF2)
    local hX = W.SIZE_X*0.5; local hZ = W.SIZE_Z*0.5
    -- Nubes de tormenta escocesa
    for i=1, 30 do
        local cx = rng(-hX*0.7, hX*0.7)
        local cz = rng(-hZ*0.7, hZ*0.7)
        local cW = rng(200, 420); local cH = rng(35, 65)
        mp({n="StormCloud", sz=Vector3.new(cW, cH, rng(120,260)),
            pos=Vector3.new(cx, W.BASE_Y+rng(185,260), cz),
            col=W.C.CLOUD_D, mat=Enum.Material.SmoothPlastic,
            tr=rng(0.08,0.25), cc=false, cs=false, par=WF2})
        WeatherState.cloudParts[#WeatherState.cloudParts+1] = {x=cx, z=cz}
    end
    -- Gotas (lluvia escocesa diagonal y fuerte)
    local rainCount = 2200
    for i=1, rainCount do
        local rx = rng(-hX*0.85, hX*0.85)
        local rz = rng(-hZ*0.85, hZ*0.85)
        local ry = rng(W.BASE_Y+2, W.BASE_Y+70)
        local rLen = rng(1.5, 3.2)
        local r = mp({n="RainDrop", sz=Vector3.new(0.07, rLen, 0.07),
            cf=CFrame.new(rx,ry,rz)*CFrame.Angles(math.rad(rng(-12,-5)),0,math.rad(rng(-3,3))),
            col=W.C.RAIN_DROP, mat=Enum.Material.Neon,
            tr=rng(0.30,0.58), cc=false, cs=false, par=WF2})
        WeatherState.rainParts[#WeatherState.rainParts+1] = {
            part=r, speed=rng(32,52), ox=rx, oz=rz
        }
    end
    -- Charcos mágicos (brillan levemente)
    for i=1, 60 do
        local px = rng(-hX*0.7, hX*0.7)
        local pz = rng(-hZ*0.7, hZ*0.7)
        local py = surfaceH(px,pz)
        mp({n="Puddle", sz=Vector3.new(rng(2,9), 0.12, rng(2,7)),
            cf=CFrame.new(px,py+0.04,pz)*CFrame.Angles(0,rng(0,math.pi*2),0),
            col=W.C.LAKE_S, mat=Enum.Material.Glass,
            tr=0.22, cc=false, cs=false, par=WF2})
    end
    print("✅ Lluvia escocesa creada")
end

local function createSnowSystem(WF2)
    local hX = W.SIZE_X*0.5; local hZ = W.SIZE_Z*0.5
    -- Nubes de nieve
    for i=1, 28 do
        local cx = rng(-hX*0.7, hX*0.7)
        local cz = rng(-hZ*0.7, hZ*0.7)
        mp({n="SnowCloud", sz=Vector3.new(rng(220,420), rng(38,68), rng(130,275)),
            pos=Vector3.new(cx, W.BASE_Y+rng(188,248), cz),
            col=lc(W.C.CLOUD_W, W.C.CLOUD_D, 0.3),
            mat=Enum.Material.SmoothPlastic, tr=rng(0.07,0.20),
            cc=false, cs=false, par=WF2})
        WeatherState.cloudParts[#WeatherState.cloudParts+1] = {x=cx, z=cz}
    end
    -- Copos
    local snowCount = 2500
    for i=1, snowCount do
        local sx = rng(-hX*0.85, hX*0.85)
        local sz = rng(-hZ*0.85, hZ*0.85)
        local sy = rng(W.BASE_Y+2, W.BASE_Y+65)
        local ss = rng(0.20, 0.48)
        local s = mp({n="SnowFlake", sz=Vector3.new(ss, ss*0.30, ss),
            cf=CFrame.new(sx,sy,sz)*CFrame.Angles(rng(0,math.pi*2),rng(0,math.pi*2),0),
            col=W.C.SNOW_W, mat=Enum.Material.SmoothPlastic,
            tr=rng(0.08,0.38), cc=false, cs=false, par=WF2})
        WeatherState.snowParts[#WeatherState.snowParts+1] = {
            part=s, speed=rng(2.5,6.5), ox=sx, oz=sz,
            driftX=rng(-0.7,0.7), driftZ=rng(-0.3,0.3)
        }
    end
    -- Capa de nieve en suelo
    local step=24; local hXg=hX-22; local hZg=hZ-22
    for x=-hXg,hXg,step do
        for z=-hZg,hZg,step do
            local gy=groundH(x,z)
            mp({n="SnowGround", sz=Vector3.new(step+1, rng(0.5,1.2), step+1),
                pos=Vector3.new(x, gy+0.2, z),
                col=lc(W.C.SNOW_W, W.C.H_SNOW_R, rng(0,0.25)),
                mat=Enum.Material.Glacier, tr=rng(0,0.15),
                cc=false, cs=false, par=WF2})
        end
        task.wait()
    end
    print("✅ Nieve mágica creada")
end

local function animateRain()
    task.spawn(function()
        local hX=W.SIZE_X*0.5; local hZ=W.SIZE_Z*0.5
        while WeatherState.current=="rain" or WeatherState.current=="storm" do
            local dt=0.05
            for _, rd in ipairs(WeatherState.rainParts) do
                if rd.part and rd.part.Parent then
                    local pos=rd.part.Position
                    local newY=pos.Y - rd.speed*dt
                    if newY < W.BASE_Y-2 then
                        newY=W.BASE_Y+rng(50,72)
                        rd.part.Position=Vector3.new(rng(-hX*0.85,hX*0.85),newY,rng(-hZ*0.85,hZ*0.85))
                    else
                        rd.part.Position=Vector3.new(pos.X+rng(-0.15,-0.03),newY,pos.Z+rng(-0.04,0.04))
                    end
                end
            end
            task.wait(dt)
        end
    end)
end

local function animateSnow()
    task.spawn(function()
        local hX=W.SIZE_X*0.5; local hZ=W.SIZE_Z*0.5; local t=0
        while WeatherState.current=="snow" do
            local dt=0.07; t=t+dt
            for i,sd in ipairs(WeatherState.snowParts) do
                if sd.part and sd.part.Parent then
                    local pos=sd.part.Position
                    local newY=pos.Y - sd.speed*dt
                    local dX=math.sin(t*0.4+i*0.1)*sd.driftX*dt*7
                    local dZ=math.cos(t*0.3+i*0.15)*sd.driftZ*dt*7
                    if newY < W.BASE_Y-1 then
                        newY=W.BASE_Y+rng(42,65)
                        sd.part.Position=Vector3.new(rng(-hX*0.85,hX*0.85),newY,rng(-hZ*0.85,hZ*0.85))
                    else
                        sd.part.Position=Vector3.new(pos.X+dX,newY,pos.Z+dZ)
                    end
                    sd.part.CFrame=sd.part.CFrame*CFrame.Angles(math.rad(0.8),math.rad(0.4),0)
                end
            end
            task.wait(dt)
        end
    end)
end

local function setMistAtmosphere()
    if atmoInst then atmoInst.Density=0.58; atmoInst.Haze=4.2
        atmoInst.Color=Color3.fromRGB(140,152,182) end
    if ccInst then ccInst.Saturation=0.05; ccInst.Brightness=-0.02 end
    Lighting.Brightness=1.2; Lighting.FogColor=W.C.FOG_MIST
    Lighting.FogEnd=800; Lighting.FogStart=280
end
local function setRainAtmosphere()
    if atmoInst then atmoInst.Density=0.62; atmoInst.Haze=3.8
        atmoInst.Color=Color3.fromRGB(118,132,168) end
    if ccInst then ccInst.Saturation=-0.05; ccInst.Brightness=-0.06 end
    Lighting.Brightness=0.95; Lighting.FogColor=Color3.fromRGB(105,118,155)
    Lighting.FogEnd=720; Lighting.FogStart=260
end
local function setSnowAtmosphere()
    if atmoInst then atmoInst.Density=0.68; atmoInst.Haze=4.8
        atmoInst.Color=Color3.fromRGB(195,208,238) end
    if ccInst then ccInst.Saturation=-0.18; ccInst.Brightness=0.06 end
    Lighting.Brightness=0.80; Lighting.FogColor=Color3.fromRGB(205,218,245)
    Lighting.FogEnd=620; Lighting.FogStart=220
end
local function setClearAtmosphere()
    if atmoInst then atmoInst.Density=0.42; atmoInst.Haze=2.2
        atmoInst.Color=Color3.fromRGB(165,178,215) end
    if ccInst then ccInst.Saturation=0.15; ccInst.Brightness=-0.02 end
    Lighting.Brightness=1.8; Lighting.FogColor=W.C.FOG_MIST
    Lighting.FogEnd=1400; Lighting.FogStart=700
end

local function startWeatherSystem()
    task.spawn(function()
        WeatherState.current="misty"
        task.wait(30)
        local weatherCycle={"misty","clear","rain","misty","snow","clear","rain","misty"}
        local cycleIdx=1
        while true do
            local weather=weatherCycle[cycleIdx]
            cycleIdx=(cycleIdx % #weatherCycle)+1
            print("🌦️ Clima mágico cambiando a: "..weather)
            local oldWF=FW and FW:FindFirstChild("WeatherFX")
            if oldWF then oldWF:Destroy() end
            WeatherState.rainParts={}; WeatherState.snowParts={}; WeatherState.cloudParts={}
            WeatherState.current=weather
            local WF2=mkFolder("WeatherFX", FW)
            WeatherState.weatherFolder=WF2
            if weather=="rain" then
                setRainAtmosphere(); createRainSystem(WF2); animateRain()
                task.wait(rng(100,200))
            elseif weather=="snow" then
                setSnowAtmosphere(); createSnowSystem(WF2); animateSnow()
                task.wait(rng(90,170))
            elseif weather=="misty" then
                setMistAtmosphere(); createMistSystem(WF2)
                task.wait(rng(110,220))
            else
                setClearAtmosphere()
                task.wait(rng(130,250))
            end
            if WF2 and WF2.Parent then
                for _,child in ipairs(WF2:GetDescendants()) do
                    if child:IsA("BasePart") then
                        TweenService:Create(child,TweenInfo.new(5),{Transparency=1}):Play()
                    end
                end
                task.wait(6)
                if WF2.Parent then WF2:Destroy() end
            end
            setClearAtmosphere(); task.wait(18)
        end
    end)
    print("✅ Sistema clima escocés iniciado")
end

-- ═══════════════════════════════════════════════════════════════════
-- 4. TERRENO — Paisaje escocés
-- ═══════════════════════════════════════════════════════════════════
local function buildTerrain(TF)
    local TX=130; local TZ=130
    local tW=W.SIZE_X/TX; local tD=W.SIZE_Z/TZ
    local hX=W.SIZE_X*0.5; local hZ=W.SIZE_Z*0.5; local n=0
    for ix=1, TX do
        for iz=1, TZ do
            local px=-hX+(ix-0.5)*tW; local pz=-hZ+(iz-0.5)*tD
            local py=groundH(px,pz)
            local heatherNoise=math.noise(ix*0.22+5.1, iz*0.22+5.1)
            local moorNoise=math.noise(ix*0.14+12, iz*0.14+12)
            local col, mat
            if moorNoise>0.18 then
                col=W.C.G_MOOR; mat=Enum.Material.Ground
            elseif heatherNoise>0.12 then
                col=W.C.G_HEATHER; mat=Enum.Material.LeafyGrass
            elseif heatherNoise>-0.05 then
                col=W.C.G_MID; mat=Enum.Material.Grass
            else
                col=W.C.G_DARK; mat=Enum.Material.LeafyGrass
            end
            mp({n="T", sz=Vector3.new(tW+0.1, 1.2, tD+0.1),
                pos=Vector3.new(px, py-0.4, pz),
                col=col, mat=mat, par=TF})
            n=n+1
        end
        if ix%14==0 then task.wait()
            print(string.format("   Terreno %d%%", math.floor(ix/TX*100))) end
    end
    Terrain:FillBlock(CFrame.new(0,W.BASE_Y-5,0),
        Vector3.new(W.SIZE_X+900, 10, W.SIZE_Z+900), Enum.Material.Grass)
    mp({n="Floor", sz=Vector3.new(W.SIZE_X+900, 6, W.SIZE_Z+900),
        pos=Vector3.new(0,W.BASE_Y-6.5,0),
        col=W.C.G_DARK, mat=Enum.Material.Grass, par=TF})
    print("✅ Terreno escocés listo ("..n.." tiles)")
end

-- ═══════════════════════════════════════════════════════════════════
-- 5. LAGO NEGRO (The Black Lake)
-- ═══════════════════════════════════════════════════════════════════
local function buildBlackLake(LF)
    local lx=W.LAKE_X; local lz=W.LAKE_Z
    local lR=185  -- radio del lago

    -- Excavar cuenca con Terrain
    Terrain:FillBlock(CFrame.new(lx, W.BASE_Y-3.5, lz),
        Vector3.new(lR*2.1, 7, lR*1.85), Enum.Material.Water)

    -- Fondo oscuro
    mp({n="LakeFloor", sz=Vector3.new(lR*2.2, 1.5, lR*1.9),
        pos=Vector3.new(lx, W.BASE_Y-5.5, lz),
        col=W.C.LAKE_D, mat=Enum.Material.SmoothPlastic, par=LF})

    -- Capa profunda
    mp({n="LakeDeep", sz=Vector3.new(lR*1.85, 4, lR*1.6),
        cf=CFrame.new(lx, W.BASE_Y-2.5, lz)*CFrame.Angles(0, rng(0,0.5), 0),
        col=W.C.LAKE_D, mat=Enum.Material.Glass, tr=0.12, par=LF})

    -- Superficie principal (oscura, Glass)
    mp({n="LakeSurface", sz=Vector3.new(lR*2.0, 0.35, lR*1.75),
        cf=CFrame.new(lx, W.BASE_Y+0.18, lz)*CFrame.Angles(0, rng(0,0.3), 0),
        col=W.C.LAKE_M, mat=Enum.Material.Glass, tr=0.25, cc=false, par=LF})

    -- Ondas Neon reflejo lunar
    for w=1, 8 do
        local wR = lR*0.15*w
        local wT = 0.55 + w*0.06
        mp({n="LakeWave", sz=Vector3.new(wR*2.05, 0.08, wR*1.78),
            cf=CFrame.new(lx, W.BASE_Y+0.38, lz)*CFrame.Angles(0, w*0.22, 0),
            col=W.C.LAKE_REFLECT, mat=Enum.Material.Neon,
            tr=wT, cc=false, cs=false, par=LF})
    end

    -- Orillas con arena oscura y rocas
    local shoreCount = 38
    for i=1, shoreCount do
        local ang = (i/shoreCount)*math.pi*2 + rng(-0.15,0.15)
        local dist = lR*rng(0.90, 1.08)
        local sx2 = lx + math.cos(ang)*dist
        local sz2 = lz + math.sin(ang)*dist
        local sw = rng(12, 28)
        mp({n="Shore", sz=Vector3.new(sw, 0.65, sw*rng(0.6,1.0)),
            cf=CFrame.new(sx2, W.BASE_Y+0.08, sz2)*CFrame.Angles(0, ang, 0),
            col=lc(W.C.SAND_L, W.C.DIRT_D, 0.65), mat=Enum.Material.Sand, par=LF})
    end

    -- Rocas de orilla (19 rocas grandes)
    for i=1, 19 do
        local ang = rng(0, math.pi*2)
        local dist = lR*rng(0.85, 1.05)
        local rx2 = lx + math.cos(ang)*dist
        local rz2 = lz + math.sin(ang)*dist
        local rs = rng(2.5, 7.0)
        mp({n="LakeRock", sz=Vector3.new(rs*2, rs, rs*1.6),
            cf=CFrame.new(rx2, W.BASE_Y+rs*0.3, rz2)*CFrame.Angles(rng(-0.2,0.2), rng(0,math.pi*2), rng(-0.15,0.15)),
            col=lc(W.C.S_DARK, W.C.S_BASE, rng(0,0.5)), mat=Enum.Material.Rock, par=LF})
    end

    -- Tentáculos del Giant Squid (8 tentáculos emergiendo)
    for i=1, 8 do
        local tang = (i/8)*math.pi*2 + rng(-0.2,0.2)
        local tdist = lR*rng(0.18, 0.52)
        local tx2 = lx + math.cos(tang)*tdist
        local tz2 = lz + math.sin(tang)*tdist
        local tH = rng(8, 22)
        local tW2 = rng(0.8, 1.8)
        -- Segmentos del tentáculo
        for seg=1, 4 do
            local st = (seg-1)/3
            local segY = W.BASE_Y + st*tH
            local segW = tW2*(1-st*0.6)
            mp({n="Tentacle", sz=Vector3.new(segW*2, tH*0.28, segW*1.6),
                cf=CFrame.new(tx2+rng(-1.5,1.5), segY+tH*0.07, tz2+rng(-1,1))
                * CFrame.Angles(math.rad(rng(-25,25)), tang, math.rad(rng(-12,12))),
                col=lc(W.C.SQUID, Color3.fromRGB(32,18,42), rng(0,0.5)),
                mat=Enum.Material.SmoothPlastic, par=LF})
        end
        -- Ventosa Neon en la punta
        mp({n="TentTip", sz=Vector3.new(tW2*0.8, tW2*0.8, tW2*0.5),
            pos=Vector3.new(tx2, W.BASE_Y+tH, tz2),
            col=W.C.MAGIC_PURP, mat=Enum.Material.Neon, tr=0.4,
            cc=false, cs=false, par=LF})
    end

    -- Animación ondas del lago
    task.spawn(function()
        while true do
            local t = tick()
            for _, child in ipairs(LF:GetChildren()) do
                if child:IsA("BasePart") and child.Name=="LakeWave" then
                    local idx = tonumber(child.Name:match("%d+")) or 1
                    local bob = math.sin(t*0.6 + idx*0.8)*0.08
                    child.Position = Vector3.new(child.Position.X, W.BASE_Y+0.38+bob, child.Position.Z)
                    child.Transparency = clamp(child.Transparency + math.sin(t*0.4+idx)*0.002, 0.45, 0.85)
                end
            end
            task.wait(0.1)
        end
    end)

    print("✅ Lago Negro listo (con tentáculos del Giant Squid)")
end

-- ═══════════════════════════════════════════════════════════════════
-- 6. CASTILLO DE HOGWARTS
-- ═══════════════════════════════════════════════════════════════════
local function buildHogwarts(HF)
    local hx = W.HOGWARTS_X
    local hz = W.HOGWARTS_Z
    local gy = groundH(hx, hz)
    local S  = W.C.S_BASE  -- piedra base
    local SD = W.C.S_DARK
    local SL = W.C.S_LIGHT
    local SM = W.C.S_MID
    local SL2= W.C.SLATE
    local SA = W.C.S_AGED
    local mat= Enum.Material.SmoothPlastic

    -- === BASE / TERRAPLÉN DEL CASTILLO ===
    mp({n="HogBase", sz=Vector3.new(280, 18, 240),
        pos=Vector3.new(hx, gy+7, hz), col=SD, mat=Enum.Material.Rock, par=HF})
    mp({n="HogBase2", sz=Vector3.new(265, 12, 225),
        pos=Vector3.new(hx, gy+14, hz), col=SA, mat=mat, par=HF})
    -- Terraplén escalonado
    for step=1, 4 do
        local sw = 275 - step*12; local sd2 = 235 - step*10
        mp({n="HogStep", sz=Vector3.new(sw, 3, sd2),
            pos=Vector3.new(hx, gy+18+step*2.5, hz), col=lc(SD, S, step/4), mat=mat, par=HF})
    end

    -- === CUERPO PRINCIPAL (Gran Salón + Ala Principal) ===
    -- Bloque central
    mp({n="HogMain", sz=Vector3.new(120, 42, 88),
        pos=Vector3.new(hx, gy+40, hz), col=S, mat=mat, par=HF})
    mp({n="HogMainFront", sz=Vector3.new(118, 40, 86),
        pos=Vector3.new(hx, gy+39, hz+1), col=SM, mat=mat, par=HF})
    -- Almenas del cuerpo principal (merlones)
    for m=1, 12 do
        local mx2 = hx - 55 + m*10
        mp({n="Merlon", sz=Vector3.new(5, 7, 5),
            pos=Vector3.new(mx2, gy+63, hz-44), col=SD, mat=mat, par=HF})
        mp({n="Merlon", sz=Vector3.new(5, 7, 5),
            pos=Vector3.new(mx2, gy+63, hz+44), col=SD, mat=mat, par=HF})
    end
    for m=1, 10 do
        local mz2 = hz - 40 + m*8
        mp({n="MerlonS", sz=Vector3.new(5, 7, 5),
            pos=Vector3.new(hx-60, gy+63, mz2), col=SD, mat=mat, par=HF})
        mp({n="MerlonS", sz=Vector3.new(5, 7, 5),
            pos=Vector3.new(hx+60, gy+63, mz2), col=SD, mat=mat, par=HF})
    end

    -- === GRAN SALÓN (ala delantera, ligeramente más alta) ===
    mp({n="GreatHall", sz=Vector3.new(68, 52, 58),
        pos=Vector3.new(hx, gy+45, hz+60), col=S, mat=mat, par=HF})
    -- Ventanas grandes del Gran Salón (arco gótico)
    for w=1, 4 do
        local wx2 = hx - 25 + w*14
        -- Ventana arco
        mp({n="Window", sz=Vector3.new(7, 18, 2.5),
            pos=Vector3.new(wx2, gy+42, hz+90), col=W.C.H_WINDOW, mat=Enum.Material.Neon, tr=0.18, cc=false, par=HF})
        mp({n="WinArch", sz=Vector3.new(8.5, 4, 2.8),
            cf=CFrame.new(wx2, gy+52, hz+90)*CFrame.Angles(0,0,0),
            col=SD, mat=mat, par=HF})
        -- Detalles piedra ventana
        mp({n="WinFrame", sz=Vector3.new(8.5, 22, 3.5),
            pos=Vector3.new(wx2, gy+41, hz+89.8), col=SA, mat=mat, cc=false, par=HF})
    end
    -- Tejado del Gran Salón (pizarra)
    mw({n="GreatRoof", sz=Vector3.new(72, 28, 62),
        cf=CFrame.new(hx, gy+78, hz+60)*CFrame.Angles(0,0,0),
        col=SL2, mat=Enum.Material.SmoothPlastic, par=HF})

    -- === TORRES PRINCIPALES (7 torres icónicas) ===
    local towers = {
        -- {offsetX, offsetZ, radius, height, name}
        {-52, -38, 12, 88,  "GryffindorTower"},  -- Torre Gryffindor
        { 52, -38, 10, 78,  "SlytherinTower"},   -- Torre Slytherin
        {-52,  42, 11, 82,  "RavenclawTower"},   -- Torre Ravenclaw
        { 52,  42, 9,  72,  "HufflepuffTower"},  -- Torre Hufflepuff
        {  0, -52, 14, 105, "AstronomyTower"},   -- Torre de Astronomía (la más alta)
        {-68,  0,  9,  68,  "ClockTower"},       -- Torre del Reloj
        { 68,  0,  8,  62,  "NorthTower"},       -- Torre Norte
    }

    for _, tw in ipairs(towers) do
        local tx2 = hx + tw[1]; local tz2 = hz + tw[2]
        local tgy = groundH(tx2, tz2)
        local tr2 = tw[3]; local th = tw[4]
        markOcc(tx2, tz2, tr2+8)

        -- Base de la torre (cuadrada abajo, redonda arriba)
        mp({n=tw[5].."_Base", sz=Vector3.new(tr2*2.2, 12, tr2*2.0),
            pos=Vector3.new(tx2, tgy+5, tz2), col=SD, mat=mat, par=HF})

        -- Cuerpo cilíndrico (simulado con segmentos)
        local segments = 10
        for s=1, segments do
            local st = (s-1)/(segments-1)
            local segY = tgy + 12 + st*th
            local segH = th/segments * 1.12
            local segW = tr2 * (1 - st*0.08)
            local col = (s%2==0) and lc(S, SM, 0.3) or lc(SA, S, rng(0.2,0.7))
            mp({n=tw[5].."_Seg", sz=Vector3.new(segW*2, segH, segW*1.88),
                cf=CFrame.new(tx2, segY+segH*0.5, tz2)*CFrame.Angles(0, math.rad(s*18), 0),
                col=col, mat=mat, par=HF})
        end

        -- Almenas de la torre
        for m=1, 8 do
            local ma = (m/8)*math.pi*2
            local mx2_2 = tx2 + math.cos(ma)*tr2*0.88
            local mz2_2 = tz2 + math.sin(ma)*tr2*0.88
            mp({n=tw[5].."_Merlon", sz=Vector3.new(3.5, 6, 3.0),
                pos=Vector3.new(mx2_2, tgy+12+th+3, mz2_2),
                col=SD, mat=mat, par=HF})
        end

        -- Tejado cónico (aguja de pizarra)
        local coneH = tr2*2.8
        mw({n=tw[5].."_Spire", sz=Vector3.new(tr2*2.0, coneH, tr2*1.85),
            cf=CFrame.new(tx2, tgy+12+th+coneH*0.5, tz2)*CFrame.Angles(0, rng(0, math.pi*0.5), 0),
            col=SL2, mat=Enum.Material.SmoothPlastic, par=HF})
        -- Punta de la aguja (metal oscuro)
        mp({n=tw[5].."_Tip", sz=Vector3.new(1.2, coneH*0.35, 1.2),
            pos=Vector3.new(tx2, tgy+12+th+coneH+coneH*0.18, tz2),
            col=Color3.fromRGB(45,42,38), mat=Enum.Material.Metal, par=HF})

        -- Ventana de la torre (por piso)
        for wf=1, 4 do
            local wa = rng(0, math.pi*2)
            local wy = tgy + 14 + (wf/4)*th*0.85
            local twx = tx2 + math.cos(wa)*(tr2*0.98)
            local twz = tz2 + math.sin(wa)*(tr2*0.98)
            mp({n=tw[5].."_Win", sz=Vector3.new(4, 7, 1.8),
                cf=CFrame.new(twx, wy, twz)*CFrame.Angles(0, wa, 0),
                col=W.C.H_WINDOW, mat=Enum.Material.Neon, tr=0.28, cc=false, par=HF})
            -- Luz interior cálida
            local wLight = Instance.new("PointLight")
            wLight.Brightness=0.8; wLight.Range=14; wLight.Color=W.C.H_WINDOW
            wLight.Parent=mp({n=tw[5].."_WinLight", sz=Vector3.new(0.5,0.5,0.5),
                pos=Vector3.new(twx, wy, twz), col=W.C.H_WINDOW, mat=Enum.Material.Neon,
                tr=0.9, cc=false, cs=false, par=HF})
        end
    end

    -- === PUENTE DE HOGWARTS (cubierto, con pilares) ===
    local bridgeZ = hz + 110
    local bridgeLen = 65
    -- Plataforma del puente
    mp({n="Bridge", sz=Vector3.new(14, 2.5, bridgeLen),
        pos=Vector3.new(hx, gy+22, bridgeZ+bridgeLen*0.5),
        col=SM, mat=mat, par=HF})
    -- Tejado del puente
    mw({n="BridgeRoof", sz=Vector3.new(16, 8, bridgeLen),
        cf=CFrame.new(hx, gy+32, bridgeZ+bridgeLen*0.5),
        col=SL2, mat=Enum.Material.SmoothPlastic, par=HF})
    -- Pilares del puente
    for p=1, 5 do
        local pz2 = bridgeZ + p*12
        mp({n="BridgePillar", sz=Vector3.new(3, 26, 3),
            pos=Vector3.new(hx-8, gy+10, pz2), col=SD, mat=mat, par=HF})
        mp({n="BridgePillar", sz=Vector3.new(3, 26, 3),
            pos=Vector3.new(hx+8, gy+10, pz2), col=SD, mat=mat, par=HF})
    end
    -- Arcos del puente
    for p=1, 4 do
        local pz2 = bridgeZ + p*14 + 6
        mw({n="BridgeArch", sz=Vector3.new(16, 10, 7),
            cf=CFrame.new(hx, gy+26, pz2)*CFrame.Angles(0,0,0),
            col=SA, mat=mat, par=HF})
    end

    -- === ESCALINATA DE ENTRADA ===
    local stairZ = hz + 92
    for s=1, 8 do
        mp({n="Stair", sz=Vector3.new(28-s*0.5, 1.8, 3),
            pos=Vector3.new(hx, gy+18+s*1.8, stairZ+s*3),
            col=lc(S, SM, s/8), mat=mat, par=HF})
    end

    -- === MUROS EXTERIORES (circuito del castillo) ===
    local wallSegs = {
        {x=hx-148, z=hz,       w=3,  l=200, r=0},
        {x=hx+148, z=hz,       w=3,  l=200, r=0},
        {x=hx,     z=hz-108,   w=280,l=3,   r=0},
        {x=hx-88,  z=hz+108,   w=100,l=3,   r=0},
        {x=hx+88,  z=hz+108,   w=100,l=3,   r=0},
    }
    for _, ws in ipairs(wallSegs) do
        -- Muro
        mp({n="Wall", sz=Vector3.new(ws.w+0.5, 16, ws.l+0.5),
            pos=Vector3.new(ws.x, gy+25, ws.z), col=SD, mat=mat, par=HF})
        mp({n="Wall", sz=Vector3.new(ws.w, 14, ws.l),
            pos=Vector3.new(ws.x, gy+24, ws.z), col=SA, mat=mat, par=HF})
    end

    -- === TORRETA DE ENTRADA (2 pequeñas torres flanqueando) ===
    for side=-1, 1, 2 do
        local etx = hx + side*22; local etz = hz+112
        local etgy = groundH(etx, etz)
        mp({n="GateTower", sz=Vector3.new(14, 38, 14),
            pos=Vector3.new(etx, etgy+18, etz), col=S, mat=mat, par=HF})
        mw({n="GateRoof", sz=Vector3.new(16, 16, 16),
            cf=CFrame.new(etx, etgy+45, etz), col=SL2, mat=Enum.Material.SmoothPlastic, par=HF})
        -- Ventanas
        mp({n="GateWin", sz=Vector3.new(5, 9, 2),
            pos=Vector3.new(etx, etgy+24, etz+8),
            col=W.C.H_WINDOW, mat=Enum.Material.Neon, tr=0.25, cc=false, par=HF})
        local gl = Instance.new("PointLight")
        gl.Brightness=1.2; gl.Range=18; gl.Color=W.C.H_WINDOW
        gl.Parent=mp({n="GateLight", sz=Vector3.new(0.5,0.5,0.5),
            pos=Vector3.new(etx, etgy+24, etz+8.5),
            col=W.C.H_WINDOW, mat=Enum.Material.Neon, tr=0.9, cc=false, par=HF})
    end

    -- === PORTON DE ENTRADA ===
    mp({n="Gate", sz=Vector3.new(18, 24, 3),
        pos=Vector3.new(hx, gy+21, hz+115), col=SD, mat=mat, par=HF})
    mp({n="GateArch", sz=Vector3.new(20, 6, 4),
        pos=Vector3.new(hx, gy+34, hz+115), col=SA, mat=mat, par=HF})
    -- Puerta de madera
    mp({n="GateDoor_L", sz=Vector3.new(7, 20, 2),
        pos=Vector3.new(hx-4, gy+20, hz+115),
        col=W.C.H_WOOD, mat=Enum.Material.Wood, par=HF})
    mp({n="GateDoor_R", sz=Vector3.new(7, 20, 2),
        pos=Vector3.new(hx+4, gy+20, hz+115),
        col=W.C.H_WOOD2, mat=Enum.Material.Wood, par=HF})

    -- === CHIMENEAS (humo mágico) ===
    local chimneyPositions = {{-35,-18},{35,-18},{-22,15},{22,15},{0,-35},{-42,5},{42,5}}
    for _, cp in ipairs(chimneyPositions) do
        local cx2 = hx+cp[1]; local cz2 = hz+cp[2]
        local cgy = gy
        local ch = rng(52, 75)
        mp({n="Chimney", sz=Vector3.new(4, 12, 4),
            pos=Vector3.new(cx2, cgy+ch, cz2),
            col=W.C.H_CHIMNEY, mat=Enum.Material.Brick, par=HF})
        -- Humo (partículas estáticas)
        for sm=1, 6 do
            local sY = cgy + ch + sm*3.5
            local smoke = mp({n="Smoke", sz=Vector3.new(rng(3,7), rng(2,4), rng(3,7)),
                pos=Vector3.new(cx2+rng(-1,1), sY, cz2+rng(-1,1)),
                col=Color3.fromRGB(178,178,188), mat=Enum.Material.SmoothPlastic,
                tr=rng(0.55, 0.82), cc=false, cs=false, par=HF})
        end
    end

    -- === GREAT HALL INTERIOR DETAIL (vidrieras Neon) ===
    local glassColors = {
        W.C.MAGIC_GOLD, W.C.MAGIC_PURP, W.C.MAGIC_BLUE, W.C.MAGIC_GREEN,
        Color3.fromRGB(255,88,55), Color3.fromRGB(255,205,55)
    }
    for g=1, 6 do
        local ga = (g/6)*math.pi*2
        local gx2 = hx + math.cos(ga)*28
        local gz2 = hz + 60 + math.sin(ga)*8
        mp({n="Stained", sz=Vector3.new(5, 14, 1.5),
            cf=CFrame.new(gx2, gy+40, gz2)*CFrame.Angles(0, ga, 0),
            col=glassColors[g], mat=Enum.Material.Neon, tr=0.45, cc=false, par=HF})
        local gl2 = Instance.new("PointLight")
        gl2.Brightness=1.5; gl2.Range=20; gl2.Color=glassColors[g]; gl2.Parent=mp({
            n="StainedLight", sz=Vector3.new(0.5,0.5,0.5),
            pos=Vector3.new(gx2, gy+40, gz2+2),
            col=glassColors[g], mat=Enum.Material.Neon, tr=0.92, cc=false, par=HF})
    end

    print("✅ Castillo de Hogwarts listo")
end



-- ═══════════════════════════════════════════════════════════════════
-- MAIN BUILD — PARTE 1
-- Carga: Atmósfera, Terreno, Hierba, Hogwarts, Lago Negro
-- Parte 2 (WW_Part2) cargará: Bosque, Hogsmeade, Plantas, Montañas, Árboles, Caminos
-- ═══════════════════════════════════════════════════════════════════
local function buildWorld_Part1()
    print("════════════════════════════════════════════════════════════")
    print("⚡ WIZARDING WORLD — PARTE 1/2 — Iniciando…")
    print("════════════════════════════════════════════════════════════")
    local t0 = tick()

    local old = Workspace:FindFirstChild("WizardingWorld")
    if old then old:Destroy() end
    occupied = {}; windParts = {}; windStarted = false
    WeatherState.magicRefs  = {}
    WeatherState.leafRefs   = {}
    WeatherState.candleRefs = {}
    WeatherState.ghostRefs  = {}

    FW = mkFolder("WizardingWorld")
    local TF  = mkFolder("Terrain",    FW)
    local GF  = mkFolder("Grass",      FW)
    local LF  = mkFolder("BlackLake",  FW)
    local HF  = mkFolder("Hogwarts",   FW)
    local DNF = mkFolder("DayNight",   FW)

    print("🌌 [1/5] Atmósfera Mágica…");   setupAtmosphere()
    print("🏴󠁧󠁢󠁳󠁣󠁴󠁿 [2/5] Terreno Escocés…");  buildTerrain(TF)
    print("🌿 [3/5] Hierba y Brezo…");      buildGrass(GF)
    startWind()
    print("🏰 [4/5] Castillo Hogwarts…");   buildHogwarts(HF)
    print("🌊 [5/5] Lago Negro…");          buildBlackLake(LF)
    startDayNightCycle(DNF)
    startWeatherSystem()

    print("════════════════════════════════════════════════════════════")
    print(string.format("✅ PARTE 1 lista en %.1f s — Ahora ejecuta WW_Part2", tick()-t0))
    print("🏰 Hogwarts + Lago Negro activos")
    print("🕯️  Velas flotantes + Fantasmas + Ciclo día/noche activos")
    print("════════════════════════════════════════════════════════════")
end

buildWorld_Part1()
