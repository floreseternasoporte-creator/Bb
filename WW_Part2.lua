--[[
╔══════════════════════════════════════════════════════════════════════════════╗
║   ⚡ WIZARDING WORLD — PARTE 2/2  ⚡                                         ║
║   REQUIERE: WW_Part1 ejecutado primero (crea WizardingWorld folder + FW)    ║
║                                                                              ║
║   Esta parte construye:                                                      ║
║   • Bosque Prohibido (árboles oscuros, hongos, arañas, niebla)              ║
║   • Hogsmeade (12 edificios, farolas, adoquines, nieve)                     ║
║   • Plantas Mágicas (Whomping Willow, Mandrágoras, Tentacula)               ║
║   • Montañas Escocesas (con brezo morado y nieve)                           ║
║   • Árboles Escoceses (por el mapa)                                         ║
║   • Caminos Adoquinados medievales + Spawn                                  ║
║   • Nubes decorativas                                                        ║
╚══════════════════════════════════════════════════════════════════════════════╝
--]]

local Workspace    = game:GetService("Workspace")
local Lighting     = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local Terrain      = Workspace.Terrain

-- ═══════════════════════════════════════════════════════════════════
-- REFERENCIA AL FOLDER PRINCIPAL (creado por Parte 1)
-- ═══════════════════════════════════════════════════════════════════
local FW = Workspace:WaitForChild("WizardingWorld", 30)
if not FW then
    error("❌ ERROR: Ejecuta WW_Part1 primero! No se encontró WizardingWorld.")
end
print("✅ WizardingWorld folder encontrado — Iniciando Parte 2…")

-- ═══════════════════════════════════════════════════════════════════
-- CONFIG GLOBAL (copia de Parte 1 — DEBE SER IDÉNTICA)
-- ═══════════════════════════════════════════════════════════════════
local W = {
    SIZE_X    = 3200,
    SIZE_Z    = 3200,
    BASE_Y    = 0,
    SEED      = 42,
    HOGWARTS_X  = 0,
    HOGWARTS_Z  = -600,
    LAKE_X      = 200,
    LAKE_Z      = -200,
    FOREST_X    = -800,
    FOREST_Z    = 0,
    HOGSMEADE_X = 400,
    HOGSMEADE_Z = 300,
    C = {
        G_BASE      = Color3.fromRGB(52,  88,  30),
        G_MID       = Color3.fromRGB(62, 102,  38),
        G_BRIGHT    = Color3.fromRGB(72, 118,  42),
        G_DARK      = Color3.fromRGB(35,  62,  18),
        G_MOOR      = Color3.fromRGB(72,  68,  42),
        G_HEATHER   = Color3.fromRGB(115, 68, 110),
        G_MOSS      = Color3.fromRGB(45,  85,  28),
        DIRT        = Color3.fromRGB(120,  95,  55),
        DIRT_D      = Color3.fromRGB( 88,  68,  35),
        MUD         = Color3.fromRGB( 72,  58,  38),
        S_BASE      = Color3.fromRGB(105,  98,  85),
        S_DARK      = Color3.fromRGB( 68,  62,  52),
        S_LIGHT     = Color3.fromRGB(148, 138, 118),
        S_MID       = Color3.fromRGB(125, 115,  98),
        S_AGED      = Color3.fromRGB( 88,  82,  68),
        S_MOSS      = Color3.fromRGB( 65,  95,  48),
        SLATE       = Color3.fromRGB( 55,  58,  68),
        SLATE_D     = Color3.fromRGB( 38,  40,  50),
        SLATE_L     = Color3.fromRGB( 78,  82,  95),
        F_BARK      = Color3.fromRGB( 38,  28,  18),
        F_BARK2     = Color3.fromRGB( 55,  42,  25),
        F_BARK3     = Color3.fromRGB( 28,  22,  14),
        F_LEAF_D    = Color3.fromRGB( 18,  45,  12),
        F_LEAF_M    = Color3.fromRGB( 25,  58,  15),
        F_LEAF_B    = Color3.fromRGB( 12,  32,   8),
        F_MOSS      = Color3.fromRGB( 38,  72,  28),
        F_FERN      = Color3.fromRGB( 52,  85,  35),
        F_MUSHROOM  = Color3.fromRGB(185,  45,  22),
        F_MUSHROOM2 = Color3.fromRGB(228, 168,  28),
        F_GLOW      = Color3.fromRGB( 88, 248,  88),
        LAKE_D      = Color3.fromRGB(  8,  18,  45),
        LAKE_M      = Color3.fromRGB( 12,  28,  65),
        LAKE_S      = Color3.fromRGB( 20,  42,  88),
        LAKE_GLOW   = Color3.fromRGB( 28,  68, 148),
        H_WALL      = Color3.fromRGB(225, 215, 198),
        H_WALL2     = Color3.fromRGB(205, 192, 172),
        H_WOOD      = Color3.fromRGB(108,  72,  38),
        H_WOOD2     = Color3.fromRGB( 82,  52,  22),
        H_ROOF      = Color3.fromRGB( 78,  55,  38),
        H_SNOW_R    = Color3.fromRGB(235, 242, 255),
        H_SIGN      = Color3.fromRGB(175, 125,  48),
        H_CHIMNEY   = Color3.fromRGB( 88,  58,  38),
        H_WINDOW    = Color3.fromRGB(245, 218, 128),
        MAGIC_GOLD  = Color3.fromRGB(255, 215,  45),
        MAGIC_PURP  = Color3.fromRGB(158,  45, 255),
        MAGIC_BLUE  = Color3.fromRGB( 45, 148, 255),
        MAGIC_GREEN = Color3.fromRGB( 45, 255, 128),
        MAGIC_SPARK = Color3.fromRGB(255, 245, 155),
        CANDLE_F    = Color3.fromRGB(255, 188,  55),
        FOG_MIST    = Color3.fromRGB(165, 175, 195),
        SNOW_W      = Color3.fromRGB(240, 248, 255),
        CLOUD_W     = Color3.fromRGB(195, 205, 225),
        CLOUD_D     = Color3.fromRGB(105, 115, 138),
        M_BASE      = Color3.fromRGB( 75,  65,  55),
        M_MID       = Color3.fromRGB(108,  98,  85),
        M_HIGH      = Color3.fromRGB(145, 135, 118),
        M_SNOW      = Color3.fromRGB(235, 242, 255),
        M_HEATHER   = Color3.fromRGB(105,  60, 100),
        MANDRAKE    = Color3.fromRGB( 85, 138,  48),
        MANDRAKE_R  = Color3.fromRGB(155,  68,  38),
        TENTACULA   = Color3.fromRGB( 28, 108,  48),
        TENTACULA2  = Color3.fromRGB( 18,  78,  32),
        WHOMPING    = Color3.fromRGB( 62,  42,  22),
        WHOMPING2   = Color3.fromRGB( 45,  28,  12),
        PATH_COBBLE = Color3.fromRGB(118, 108,  92),
        PATH_EDGE   = Color3.fromRGB( 88,  80,  65),
        SAND_L      = Color3.fromRGB(195, 180, 148),
    }
}

-- ═══════════════════════════════════════════════════════════════════
-- ESTADO COMPARTIDO
-- ═══════════════════════════════════════════════════════════════════
local WeatherState = { leafRefs = {} }

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
local function groundH(x,z)
    local hX=W.SIZE_X*0.5; local hZ=W.SIZE_Z*0.5
    local h=fnoise(x,z,6,0.54,2.1,150,W.SEED)*8.5
    local distHog=math.sqrt((x-W.HOGWARTS_X)^2+(z-W.HOGWARTS_Z)^2)
    local cliffBoost=math.max(0,(1-distHog/300))*18
    local distLake=math.sqrt((x-W.LAKE_X)^2+(z-W.LAKE_Z)^2)
    local lakeDip=math.max(0,(1-distLake/220))*-6
    local fx=clamp(math.min((x+hX)/120,(hX-x)/120),0,1)
    local fz=clamp(math.min((z+hZ)/120,(hZ-z)/120),0,1)
    return W.BASE_Y+(h+cliffBoost+lakeDip)*fx*fz
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
local function startWind2()
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

local function mkFolder(name,parent)
    parent=parent or Workspace
    local old=parent:FindFirstChild(name); if old then old:Destroy() end
    local f=Instance.new("Folder"); f.Name=name; f.Parent=parent; return f
end

-- helpers de partes
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

local function buildForbiddenForest(FF)
    local fx = W.FOREST_X; local fz = W.FOREST_Z
    local forestR = 650

    -- Suelo del bosque (oscuro, húmedo)
    Terrain:FillBlock(CFrame.new(fx, W.BASE_Y-0.5, fz),
        Vector3.new(forestR*2, 2, forestR*1.8), Enum.Material.LeafyGrass)

    local function buildDarkTree(tx2, tz2, TF2)
        local gy = groundH(tx2, tz2)
        local scale = rng(0.85, 1.55)
        local trH = 20*scale; local trW = 2.2*scale; local cpR = 11*scale
        local yRot = rng(0, math.pi*2)

        -- Base de barro
        mp({n="DarkBase", sz=Vector3.new(trW*5.5, 0.6, trW*5.0),
            cf=CFrame.new(tx2, gy+0.2, tz2)*CFrame.Angles(0, yRot, 0),
            col=W.C.MUD, mat=Enum.Material.Ground, par=TF2})

        -- Raíces sinuosas y retorcidas
        local rootN = rngi(5, 8)
        for ri=1, rootN do
            local ra = yRot + (ri/rootN)*math.pi*2 + rng(-0.3,0.3)
            local rLen = trW*rng(3.0, 5.5)
            mp({n="DRoot", sz=Vector3.new(trW*rng(0.5,0.9), trW*rng(0.35,0.55), rLen),
                cf=CFrame.new(tx2+math.cos(ra)*rLen*0.5, gy+trW*0.2, tz2+math.sin(ra)*rLen*0.5)
                *CFrame.Angles(math.rad(-8), ra, math.rad(rng(-12,12))),
                col=lc(W.C.F_BARK3, W.C.F_BARK, rng(0,0.5)),
                mat=Enum.Material.Wood, par=TF2})
        end

        -- Tronco retorcido (segmentos con torsión)
        local segments = 6
        for s=1, segments do
            local st = (s-1)/(segments-1)
            local segY = gy + st*trH
            local segH = (trH/segments)*1.10
            local segW = lerp(trW, trW*0.28, st)
            local twist = s*0.22 + rng(-0.1,0.1)
            mp({n="DarkTrunk", sz=Vector3.new(segW*2, segH, segW*1.82),
                cf=CFrame.new(tx2+rng(-0.5,0.5)*st*2, segY+segH*0.5, tz2+rng(-0.3,0.3)*st*2)
                *CFrame.Angles(math.rad(rng(-4,4)*st), twist, math.rad(rng(-3,3)*st)),
                col=lc(W.C.F_BARK, W.C.F_BARK2, rng(0,0.4)),
                mat=Enum.Material.Wood, par=TF2})
            WeatherState.leafRefs[#WeatherState.leafRefs+1]=mp({n="DarkTrunk",
                sz=Vector3.new(segW*2,segH,segW*1.82),
                cf=CFrame.new(tx2,segY+segH*0.5,tz2)*CFrame.Angles(0,twist,0),
                col=W.C.F_BARK3, mat=Enum.Material.Wood, tr=0.85,
                cc=false, cs=false, par=TF2})
        end

        -- Copa muy oscura y densa
        local canopyBaseY = gy + trH*0.6
        for i=1, 8 do
            local ang = (i/8)*math.pi*2 + yRot + rng(-0.2,0.2)
            local dist = cpR*rng(0.5,0.82)
            local lump = mp({n="DarkCan", sz=Vector3.new(cpR*rng(0.55,0.88), cpR*rng(0.4,0.65), cpR*rng(0.5,0.82)),
                cf=CFrame.new(tx2+math.cos(ang)*dist, canopyBaseY+rng(cpR*0.08,cpR*0.35), tz2+math.sin(ang)*dist)
                *CFrame.Angles(math.rad(rng(-8,8)), rng(0,math.pi*2), math.rad(rng(-8,8))),
                col=lc(W.C.F_LEAF_D, W.C.F_LEAF_B, rng(0,0.6)),
                mat=Enum.Material.LeafyGrass, cc=false, par=TF2})
            WeatherState.leafRefs[#WeatherState.leafRefs+1]=lump
        end
        -- Núcleo oscuro
        local core = mp({n="DarkCore", sz=Vector3.new(cpR*1.5, cpR*0.95, cpR*1.42),
            cf=CFrame.new(tx2, canopyBaseY+cpR*0.45, tz2),
            col=W.C.F_LEAF_B, mat=Enum.Material.LeafyGrass, cc=false, par=TF2})
        WeatherState.leafRefs[#WeatherState.leafRefs+1]=core

        -- Musgo brillante (pequeñas plantas mágicas)
        for m=1, rngi(3,7) do
            local ma = rng(0,math.pi*2)
            local md = trW*rng(0.8,1.6)
            local glowMoss = mp({n="GlowMoss", sz=Vector3.new(rng(0.6,1.4), rng(0.4,0.8), rng(0.5,1.2)),
                cf=CFrame.new(tx2+math.cos(ma)*md, gy+rng(0.2,1.0), tz2+math.sin(ma)*md),
                col=W.C.F_GLOW, mat=Enum.Material.Neon, tr=rng(0.3,0.6),
                cc=false, cs=false, par=TF2})
            local gl3 = Instance.new("PointLight")
            gl3.Brightness=0.5; gl3.Range=5; gl3.Color=W.C.F_GLOW; gl3.Parent=glowMoss
        end
    end

    -- Generar árboles del bosque
    local forestCount = 650; local done = 0
    for i=1, forestCount do
        local ang = rng(0, math.pi*2)
        local dist = rng(35, forestR)
        local tx2 = fx + math.cos(ang)*dist
        local tz2 = fz + math.sin(ang)*dist
        if not isOcc(tx2, tz2, 9) then
            markOcc(tx2, tz2, 8)
            buildDarkTree(tx2, tz2, FF)
            done=done+1
        end
        if i%60==0 then task.wait()
            print(string.format("   Bosque Prohibido %d%%", math.floor(i/forestCount*100))) end
    end

    -- === HONGOS MÁGICOS ===
    for m=1, 180 do
        local mx2 = fx + rng(-forestR*0.85, forestR*0.85)
        local mz2 = fz + rng(-forestR*0.85, forestR*0.85)
        local mgy = groundH(mx2, mz2)
        local mCol = rngi(1,3)==1 and W.C.F_MUSHROOM
            or (rngi(1,2)==1 and W.C.F_MUSHROOM2 or W.C.MAGIC_PURP)
        local mH = rng(0.8, 3.2); local mR = rng(0.6, 2.5)
        -- Tallo
        mc({n="MushroomStem", sz=Vector3.new(mR*0.7, mR*0.7, mH*1.2),
            cf=CFrame.new(mx2, mgy+mH*0.5, mz2)*CFrame.Angles(0,0,math.rad(90)),
            col=Color3.fromRGB(225,215,195), mat=Enum.Material.SmoothPlastic,
            cc=false, par=FF})
        -- Sombrero
        mp({n="MushroomCap", sz=Vector3.new(mR*2.5, mH*0.55, mR*2.2),
            cf=CFrame.new(mx2, mgy+mH*1.1, mz2)*CFrame.Angles(0, rng(0,math.pi*2), 0),
            col=mCol, mat=Enum.Material.SmoothPlastic, par=FF})
        -- Brillo mágico
        local mLight = Instance.new("PointLight")
        mLight.Brightness=0.6; mLight.Range=6; mLight.Color=mCol
        mLight.Parent=mp({n="MushroomGlow", sz=Vector3.new(0.4,0.4,0.4),
            pos=Vector3.new(mx2, mgy+mH*0.8, mz2),
            col=mCol, mat=Enum.Material.Neon, tr=0.5,
            cc=false, cs=false, par=FF})
        if m%30==0 then task.wait() end
    end

    -- === HELECHO Y HELECHOS MÁGICOS ===
    for f=1, 280 do
        local fx2 = fx + rng(-forestR*0.8, forestR*0.8)
        local fz2 = fz + rng(-forestR*0.8, forestR*0.8)
        local fgy = groundH(fx2, fz2)
        local fH = rng(1.5, 4.0); local fW2 = rng(0.22, 0.48)
        local fern = mw({n="Fern",
            sz=Vector3.new(fW2, fH, fW2*0.4),
            cf=CFrame.new(fx2, fgy+fH*0.5, fz2)
            *CFrame.Angles(math.rad(rng(-20,20)), rng(0,math.pi*2), math.rad(rng(-10,10))),
            col=lc(W.C.F_FERN, W.C.F_LEAF_D, rng(0,0.5)),
            mat=Enum.Material.LeafyGrass, cc=false, par=FF})
        regWind(fern, rng(5,10), rng(0.5,0.9), rng(0,math.pi*2), 0.5)
        WeatherState.leafRefs[#WeatherState.leafRefs+1]=fern
        if f%50==0 then task.wait() end
    end

    -- === ARAÑAS GIGANTES (Aragog) — decorativas ===
    for s=1, 8 do
        local sx2 = fx + rng(-forestR*0.5, forestR*0.5)
        local sz2 = fz + rng(-forestR*0.5, forestR*0.5)
        local sgy = groundH(sx2, sz2)
        -- Cuerpo
        mp({n="AcromantulBody", sz=Vector3.new(4, 3, 5),
            pos=Vector3.new(sx2, sgy+2, sz2),
            col=Color3.fromRGB(22,18,28), mat=Enum.Material.SmoothPlastic, par=FF})
        mp({n="AcromantulHead", sz=Vector3.new(2.5, 2.5, 2.5),
            pos=Vector3.new(sx2, sgy+2.5, sz2+3.5),
            col=Color3.fromRGB(28,22,35), mat=Enum.Material.SmoothPlastic, par=FF})
        -- Ojos brillantes
        for e=1, 4 do
            local ex2 = sx2 + (e%2==0 and 0.6 or -0.6)*((e<=2) and 1 or 0.4)
            local ey = sgy + 2.8 + (e<=2 and 0 or 0.4)
            mp({n="SpiderEye", sz=Vector3.new(0.35,0.35,0.35),
                pos=Vector3.new(ex2, ey, sz2+4.2),
                col=Color3.fromRGB(220,20,20), mat=Enum.Material.Neon, tr=0.15, cc=false, par=FF})
        end
        -- Patas
        for leg=1, 8 do
            local la = (leg/8)*math.pi*2
            local lx2 = sx2 + math.cos(la)*3.5; local lz2 = sz2 + math.sin(la)*2.5
            mp({n="SpiderLeg", sz=Vector3.new(0.4, 0.4, 4.5),
                cf=CFrame.new(lx2, sgy+1.2, lz2)*CFrame.Angles(math.rad(rng(-20,20)), la, math.rad(25)),
                col=Color3.fromRGB(18,14,22), mat=Enum.Material.SmoothPlastic, par=FF})
        end
    end

    -- === NIEBLA MÁGICA DEL BOSQUE (bancos de niebla baja) ===
    for n=1, 40 do
        local nx2 = fx + rng(-forestR*0.9, forestR*0.9)
        local nz2 = fz + rng(-forestR*0.9, forestR*0.9)
        local ngy = groundH(nx2, nz2)
        mp({n="ForestMist", sz=Vector3.new(rng(30,90), rng(2,5), rng(25,75)),
            cf=CFrame.new(nx2, ngy+1.2, nz2)*CFrame.Angles(0, rng(0,math.pi*2), 0),
            col=lc(W.C.FOG_MIST, W.C.FOG_NIGHT, 0.4),
            mat=Enum.Material.SmoothPlastic, tr=rng(0.60,0.82),
            cc=false, cs=false, par=FF})
    end

    print("✅ Bosque Prohibido listo ("..done.." árboles oscuros)")
end

-- ═══════════════════════════════════════════════════════════════════
-- 8. HOGSMEADE — Pueblo mágico nevado
-- ═══════════════════════════════════════════════════════════════════
local function buildHogsmeade(VMF)
    local vx = W.HOGSMEADE_X; local vz = W.HOGSMEADE_Z

    local buildings = {
        -- {offsetX, offsetZ, width, depth, height, name, chimneys}
        { 0,    0,   22, 18, 28, "ThreeBroomsticks", 2},
        {-38,  12,   14, 12, 20, "Honeydukes",       1},
        { 38,   8,   12, 10, 18, "Ollivanders",      1},
        {-32, -22,   10, 10, 16, "PostOffice",       1},
        { 30, -20,   12, 10, 16, "ZonakosBrooms",    1},
        {-18,  28,   10,  9, 14, "Puddifoots",       1},
        { 18,  25,   10,  9, 14, "MagicShop",        1},
        {-48,  -5,    9,  9, 12, "SmallHouse1",      1},
        { 48,   2,    9,  9, 12, "SmallHouse2",      1},
        { 0,  -32,   16, 14, 18, "Shrieking",        2},  -- La Casa Chillona
        {-12, -48,    8,  8, 10, "Shed1",            0},
        { 14, -42,    8,  8, 10, "Shed2",            0},
    }

    for _, bd in ipairs(buildings) do
        local bx = vx + bd[1]; local bz = vz + bd[2]
        local bgy = groundH(bx, bz)
        local bw = bd[3]; local bdp = bd[4]; local bh = bd[5]
        local bname = bd[6]; local bch = bd[7]
        markOcc(bx, bz, math.max(bw,bdp)*0.7)

        -- Cimientos
        mp({n=bname.."_Found", sz=Vector3.new(bw+2, 3, bdp+2),
            pos=Vector3.new(bx, bgy+0.5, bz),
            col=W.C.S_DARK, mat=Enum.Material.Rock, par=VMF})

        -- Paredes
        local wallCol = rngi(1,3)==1 and W.C.H_WALL or
            (rngi(1,2)==1 and W.C.H_WALL2 or lc(W.C.H_WALL, W.C.S_LIGHT, 0.3))
        mp({n=bname.."_Walls", sz=Vector3.new(bw, bh, bdp),
            pos=Vector3.new(bx, bgy+2+bh*0.5, bz),
            col=wallCol, mat=Enum.Material.SmoothPlastic, par=VMF})
        -- Vigas de madera (entramado)
        for v=1, 4 do
            local va = v/4
            mp({n=bname.."_Beam", sz=Vector3.new(bw+0.4, 0.6, 0.6),
                pos=Vector3.new(bx, bgy+2+bh*va, bz-bdp*0.5),
                col=W.C.H_WOOD2, mat=Enum.Material.Wood, par=VMF})
            mp({n=bname.."_Beam", sz=Vector3.new(0.6, 0.6, bdp+0.4),
                pos=Vector3.new(bx-bw*0.35, bgy+2+bh*va, bz),
                col=W.C.H_WOOD2, mat=Enum.Material.Wood, par=VMF})
            mp({n=bname.."_Beam", sz=Vector3.new(0.6, 0.6, bdp+0.4),
                pos=Vector3.new(bx+bw*0.35, bgy+2+bh*va, bz),
                col=W.C.H_WOOD2, mat=Enum.Material.Wood, par=VMF})
        end

        -- Tejado (pizarra con nieve encima)
        mw({n=bname.."_Roof", sz=Vector3.new(bw+2.5, bh*0.48, bdp+2.5),
            cf=CFrame.new(bx, bgy+2+bh+bh*0.24, bz),
            col=W.C.H_ROOF, mat=Enum.Material.SmoothPlastic, par=VMF})
        -- Capa de nieve en tejado
        mw({n=bname.."_RoofSnow", sz=Vector3.new(bw+2.8, bh*0.48+0.5, bdp+2.8),
            cf=CFrame.new(bx, bgy+2+bh+bh*0.24+0.4, bz),
            col=W.C.H_SNOW_R, mat=Enum.Material.Glacier, tr=0.08, par=VMF})

        -- Ventanas con luz cálida
        local winCount = math.floor(bw/7)
        for wn=1, winCount do
            local wx2 = bx - bw*0.4 + wn*(bw*0.8/winCount)
            for floor=1, 2 do
                mp({n=bname.."_Win", sz=Vector3.new(3.5, 5, 1.5),
                    pos=Vector3.new(wx2, bgy+4+floor*bh*0.38, bz-bdp*0.5-0.8),
                    col=W.C.H_WINDOW, mat=Enum.Material.Neon, tr=0.22, cc=false, par=VMF})
                local winLight = Instance.new("PointLight")
                winLight.Brightness=0.85; winLight.Range=12; winLight.Color=W.C.H_WINDOW
                winLight.Parent=mp({n=bname.."_WinL", sz=Vector3.new(0.4,0.4,0.4),
                    pos=Vector3.new(wx2, bgy+4+floor*bh*0.38, bz-bdp*0.5),
                    col=W.C.H_WINDOW, mat=Enum.Material.Neon, tr=0.9,
                    cc=false, cs=false, par=VMF})
            end
        end

        -- Chimeneas con humo
        for c=1, bch do
            local cOff = bch==1 and 0 or (c==1 and -bw*0.22 or bw*0.22)
            local chx = bx + cOff
            local chgy = bgy+2+bh
            mp({n=bname.."_Chimney", sz=Vector3.new(3.5, bh*0.35, 3.5),
                pos=Vector3.new(chx, chgy+bh*0.18, bz),
                col=W.C.H_CHIMNEY, mat=Enum.Material.Brick, par=VMF})
            for sm=1, 5 do
                local sY = chgy + bh*0.35 + sm*3
                mp({n="VillageSmoke", sz=Vector3.new(rng(2.5,5.5), rng(1.8,3.5), rng(2.5,5.0)),
                    pos=Vector3.new(chx+rng(-0.8,0.8), sY, bz+rng(-0.5,0.5)),
                    col=Color3.fromRGB(175,175,185), mat=Enum.Material.SmoothPlastic,
                    tr=rng(0.58,0.82), cc=false, cs=false, par=VMF})
            end
        end

        -- Letreros de tienda
        mp({n=bname.."_Sign", sz=Vector3.new(bw*0.6, 2.5, 0.4),
            pos=Vector3.new(bx, bgy+4, bz-bdp*0.5-1.5),
            col=W.C.H_SIGN, mat=Enum.Material.Wood, par=VMF})
        -- Poste del letrero
        mp({n=bname.."_SignPost", sz=Vector3.new(0.4, 5.5, 0.4),
            pos=Vector3.new(bx-bw*0.28, bgy+2.5, bz-bdp*0.5-1.5),
            col=W.C.H_WOOD, mat=Enum.Material.Wood, par=VMF})

        -- Nieve en el suelo alrededor
        mp({n=bname.."_GroundSnow", sz=Vector3.new(bw+8, 0.5, bdp+8),
            pos=Vector3.new(bx, bgy+0.22, bz),
            col=W.C.H_SNOW_R, mat=Enum.Material.Glacier, tr=0.05, cc=false, par=VMF})
    end

    -- === ADOQUINES DE HOGSMEADE ===
    local step=3.5; local villR=62
    for x=-villR, villR, step do
        for z=-villR, villR, step do
            local wx2=vx+x; local wz=vz+z
            local wgy=groundH(wx2, wz)
            local cn=math.noise(wx2*0.25, wz*0.25)
            mp({n="Cobble", sz=Vector3.new(step+0.2, 0.45, step+0.2),
                pos=Vector3.new(wx2, wgy+0.12, wz),
                col=cn>0.1 and W.C.PATH_COBBLE or lc(W.C.PATH_COBBLE, W.C.PATH_EDGE, 0.4),
                mat=Enum.Material.Concrete, cc=false, par=VMF})
        end
        task.wait()
    end

    -- === FAROLAS MÁGICAS ===
    for f=1, 22 do
        local fa = (f/22)*math.pi*2
        local fd = rng(18, 55)
        local fx2 = vx + math.cos(fa)*fd
        local fz2 = vz + math.sin(fa)*fd
        local fgy = groundH(fx2, fz2)
        mp({n="Lamppost", sz=Vector3.new(0.5, 9, 0.5),
            pos=Vector3.new(fx2, fgy+4.5, fz2),
            col=Color3.fromRGB(28,28,28), mat=Enum.Material.Metal, par=VMF})
        mp({n="LampHead", sz=Vector3.new(1.8, 1.8, 1.8),
            pos=Vector3.new(fx2, fgy+9.5, fz2),
            col=W.C.H_WINDOW, mat=Enum.Material.Neon, tr=0.18, cc=false, par=VMF})
        local lp = Instance.new("PointLight")
        lp.Brightness=1.8; lp.Range=22; lp.Color=W.C.CANDLE_F
        lp.Parent=mp({n="LampLight", sz=Vector3.new(0.3,0.3,0.3),
            pos=Vector3.new(fx2, fgy+9.5, fz2),
            col=W.C.CANDLE_F, mat=Enum.Material.Neon, tr=0.9,
            cc=false, cs=false, par=VMF})
    end

    print("✅ Hogsmeade listo (pueblo mágico nevado)")
end

-- ═══════════════════════════════════════════════════════════════════
-- 9. PLANTAS MÁGICAS (Mandrágoras, Whomping Willow, Tentacula)
-- ═══════════════════════════════════════════════════════════════════
local function buildMagicPlants(MPlF)
    local hX=W.SIZE_X*0.5-60; local hZ=W.SIZE_Z*0.5-60

    -- === WHOMPING WILLOW (único, icónico) ===
    local wwx = W.HOGWARTS_X - 180; local wwz = W.HOGWARTS_Z + 120
    local wwgy = groundH(wwx, wwz)
    markOcc(wwx, wwz, 22)
    -- Tronco enorme y retorcido
    for s=1, 7 do
        local st=(s-1)/6
        mp({n="WW_Trunk", sz=Vector3.new(lerp(5,1.8,st)*2, 6.5, lerp(4.5,1.5,st)*1.88),
            cf=CFrame.new(wwx+rng(-1,1)*st*2, wwgy+s*6, wwz+rng(-0.5,0.5)*st*2)
            *CFrame.Angles(math.rad(rng(-8,8)*st), s*0.18, math.rad(rng(-5,5)*st)),
            col=W.C.WHOMPING, mat=Enum.Material.Wood, par=MPlF})
    end
    -- Ramas que azotan
    for b=1, 12 do
        local bang = (b/12)*math.pi*2 + rng(-0.3,0.3)
        local bLen = rng(18, 38)
        local bH = rng(1.2, 2.2)
        local branch = mp({n="WW_Branch", sz=Vector3.new(bH, bH*0.7, bLen),
            cf=CFrame.new(wwx+math.cos(bang)*8, wwgy+32+rng(-5,8), wwz+math.sin(bang)*8)
            *CFrame.Angles(math.rad(rng(-20,10)), bang, math.rad(rng(-15,15))),
            col=W.C.WHOMPING2, mat=Enum.Material.Wood, par=MPlF})
        regWind(branch, rng(15,28), rng(0.35,0.65), rng(0,math.pi*2), 0.8)
        WeatherState.leafRefs[#WeatherState.leafRefs+1]=branch
    end
    -- Hojas oscuras y agresivas
    for l=1, 20 do
        local la = rng(0, math.pi*2); local ld = rng(8,28)
        local leaf = mp({n="WW_Leaf", sz=Vector3.new(rng(4,9), rng(2.5,6), rng(3,8)),
            cf=CFrame.new(wwx+math.cos(la)*ld, wwgy+28+rng(0,15), wwz+math.sin(la)*ld)
            *CFrame.Angles(rng(-0.4,0.4), rng(0,math.pi*2), rng(-0.3,0.3)),
            col=lc(W.C.WHOMPING, W.C.F_LEAF_D, rng(0,0.3)),
            mat=Enum.Material.LeafyGrass, cc=false, par=MPlF})
        regWind(leaf, rng(10,20), rng(0.4,0.7), rng(0,math.pi*2), 0.6)
        WeatherState.leafRefs[#WeatherState.leafRefs+1]=leaf
    end
    -- Ojos de la Whomping Willow (ojos que "observan")
    mp({n="WW_Eye_L", sz=Vector3.new(1.5,1.2,0.8),
        pos=Vector3.new(wwx-1.2, wwgy+20, wwz-4.8),
        col=Color3.fromRGB(220,175,20), mat=Enum.Material.Neon, tr=0.1, cc=false, par=MPlF})
    mp({n="WW_Eye_R", sz=Vector3.new(1.5,1.2,0.8),
        pos=Vector3.new(wwx+1.2, wwgy+20, wwz-4.8),
        col=Color3.fromRGB(220,175,20), mat=Enum.Material.Neon, tr=0.1, cc=false, par=MPlF})

    -- === MANDRÁGORAS (grupo cerca del invernadero) ===
    local mdrBase_x = W.HOGWARTS_X + 85; local mdrBase_z = W.HOGWARTS_Z + 45
    for m=1, 18 do
        local mx2 = mdrBase_x + rng(-28, 28)
        local mz2 = mdrBase_z + rng(-22, 22)
        local mgy = groundH(mx2, mz2)
        local mH = rng(1.5, 3.2); local mR = rng(0.6, 1.2)
        -- Maceta de barro
        mc({n="ManPot", sz=Vector3.new(mR*2, mR*2, mH*0.5),
            cf=CFrame.new(mx2, mgy+mH*0.12, mz2)*CFrame.Angles(0,0,math.rad(90)),
            col=W.C.DIRT_D, mat=Enum.Material.SmoothPlastic, par=MPlF})
        -- Cuerpo de la mandrágora (raíz humanoide)
        mp({n="ManBody", sz=Vector3.new(mR*1.2, mH*0.65, mR*1.0),
            pos=Vector3.new(mx2, mgy+mH*0.55, mz2),
            col=W.C.MANDRAKE_R, mat=Enum.Material.SmoothPlastic, par=MPlF})
        -- Hojas de la cabeza
        for lf=1, 4 do
            local lfA = (lf/4)*math.pi*2
            local leaf = mw({n="ManLeaf", sz=Vector3.new(mR*1.1, mH*0.48, mR*0.3),
                cf=CFrame.new(mx2+math.cos(lfA)*mR*0.5, mgy+mH, mz2+math.sin(lfA)*mR*0.5)
                *CFrame.Angles(math.rad(-30), lfA+math.pi*0.5, 0),
                col=W.C.MANDRAKE, mat=Enum.Material.LeafyGrass, cc=false, par=MPlF})
            regWind(leaf, rng(4,8), rng(0.7,1.2), rng(0,math.pi*2), 0.4)
        end
        -- "Boca" de la mandrágora
        mp({n="ManMouth", sz=Vector3.new(mR*0.55, mR*0.25, 0.4),
            pos=Vector3.new(mx2, mgy+mH*0.62, mz2-mR*0.62),
            col=Color3.fromRGB(188,55,35), mat=Enum.Material.SmoothPlastic, par=MPlF})
        if m%6==0 then task.wait() end
    end

    -- === VENOMOUS TENTACULA ===
    local vtBase_x = W.HOGWARTS_X - 65; local vtBase_z = W.HOGWARTS_Z + 55
    for v=1, 12 do
        local vx = vtBase_x + rng(-30, 30)
        local vz2 = vtBase_z + rng(-25, 25)
        local vgy = groundH(vx, vz2)
        -- Base bulbosa
        mp({n="VT_Bulb", sz=Vector3.new(3.5, 2.8, 3.0),
            pos=Vector3.new(vx, vgy+1.2, vz2),
            col=W.C.TENTACULA2, mat=Enum.Material.SmoothPlastic, par=MPlF})
        -- Tentáculos (brazos que se ondulan)
        for t=1, 5 do
            local ta = (t/5)*math.pi*2 + rng(-0.3,0.3)
            local tLen = rng(3.5, 7.5)
            local tent = mw({n="VT_Tendril", sz=Vector3.new(0.7, tLen, 0.55),
                cf=CFrame.new(vx+math.cos(ta)*1.5, vgy+tLen*0.5+rng(0.5,2), vz2+math.sin(ta)*1.5)
                *CFrame.Angles(math.rad(rng(-35,10)), ta, math.rad(rng(-15,15))),
                col=W.C.TENTACULA, mat=Enum.Material.LeafyGrass, cc=false, par=MPlF})
            regWind(tent, rng(8,16), rng(0.5,0.9), rng(0,math.pi*2), 0.7)
            -- Punta con espinas/veneno
            mp({n="VT_Tip", sz=Vector3.new(0.9, 1.8, 0.9),
                cf=CFrame.new(vx+math.cos(ta)*(1.5+tLen*0.45), vgy+tLen*0.85, vz2+math.sin(ta)*(1.5+tLen*0.45)),
                col=W.C.MAGIC_GREEN, mat=Enum.Material.Neon, tr=0.3,
                cc=false, cs=false, par=MPlF})
            local vtLight = Instance.new("PointLight")
            vtLight.Brightness=0.5; vtLight.Range=5; vtLight.Color=W.C.MAGIC_GREEN
            vtLight.Parent=mp({n="VT_TipG", sz=Vector3.new(0.3,0.3,0.3),
                cf=CFrame.new(vx+math.cos(ta)*(1.5+tLen*0.45), vgy+tLen*0.85, vz2+math.sin(ta)*(1.5+tLen*0.45)),
                col=W.C.MAGIC_GREEN, mat=Enum.Material.Neon, tr=0.9, cc=false, par=MPlF})
        end
        if v%4==0 then task.wait() end
    end

    -- === FLOR DE CÁNAMO GIRATORIO (Alihotsy) — plantas brillantes scattered ===
    for f=1, 55 do
        local flx = rng(-hX*0.6, hX*0.6); local flz = rng(-hZ*0.6, hZ*0.6)
        local flgy = groundH(flx, flz)
        local flCol = rngi(1,4)==1 and W.C.MAGIC_GOLD
            or (rngi(1,3)==1 and W.C.MAGIC_BLUE
            or (rngi(1,2)==1 and W.C.MAGIC_PURP or W.C.MAGIC_GREEN))
        -- Tallo
        mp({n="MagicFlower_Stem", sz=Vector3.new(0.25, rng(1.0,2.2), 0.25),
            pos=Vector3.new(flx, flgy+rng(0.5,1.1), flz),
            col=W.C.F_FERN, mat=Enum.Material.LeafyGrass, cc=false, par=MPlF})
        -- Pétalos Neon
        for p=1, 5 do
            local pa = (p/5)*math.pi*2
            mw({n="MagicFlower_Petal", sz=Vector3.new(0.5, 0.9, 0.18),
                cf=CFrame.new(flx+math.cos(pa)*0.45, flgy+rng(1.5,2.5), flz+math.sin(pa)*0.45)
                *CFrame.Angles(math.rad(-35), pa+math.pi*0.5, 0),
                col=flCol, mat=Enum.Material.Neon, cc=false, par=MPlF})
        end
        local flLight = Instance.new("PointLight")
        flLight.Brightness=0.7; flLight.Range=6; flLight.Color=flCol
        flLight.Parent=mp({n="MagicFlower_Center", sz=Vector3.new(0.4,0.3,0.4),
            pos=Vector3.new(flx, flgy+2.4, flz),
            col=flCol, mat=Enum.Material.Neon, tr=0.2, cc=false, par=MPlF})
        if f%15==0 then task.wait() end
    end

    print("✅ Plantas mágicas listas (Whomping Willow, Mandrágoras, Tentacula)")
end

-- ═══════════════════════════════════════════════════════════════════
-- 10. MONTAÑAS ESCOCESAS
-- ═══════════════════════════════════════════════════════════════════
local function buildOnePeak(cx,cz,peakH,baseR,seed,MF2)
    seed=seed or math.random()*200
    local function nR(ang,layer,base)
        local n=math.noise(math.cos(ang)*3.0+cx*0.005+seed*0.06+layer*1.6,
            math.sin(ang)*3.0+cz*0.005+seed*0.06+layer*1.0)
        return base*(1+n*0.30)
    end
    local function layCol(lt)
        if     lt>0.78 then return lc(W.C.M_HIGH, W.C.M_SNOW,  (lt-0.78)/0.22)
        elseif lt>0.55 then return lc(W.C.M_MID,  W.C.M_HIGH,  (lt-0.55)/0.23)
        elseif lt>0.30 then return lc(W.C.M_BASE, W.C.M_MID,   (lt-0.30)/0.25)
        else                 return lc(W.C.G_MOOR, W.C.M_BASE,  lt/0.30) end
    end
    local function layMat(lt)
        return lt>0.72 and Enum.Material.Glacier
            or (lt>0.40 and Enum.Material.Rock or Enum.Material.Ground)
    end
    local LYRS=math.floor(peakH/9)+4; local SEGS=20
    -- Falda con brezo
    local skirtN=28
    for i=1,skirtN do
        local a1=(i-1)/skirtN*math.pi*2; local a2=i/skirtN*math.pi*2; local aMid=(a1+a2)*0.5
        local rM=(nR(a1,0,baseR*1.15)+nR(a2,0,baseR*1.15))*0.5
        local sx=cx+math.cos(aMid)*rM*0.80; local sz2=cz+math.sin(aMid)*rM*0.80
        local sW=rM*(math.pi*2/skirtN)*1.08; local sH=rng(peakH*0.04,peakH*0.09)
        local sD=rng(baseR*0.25,baseR*0.45)
        local heatherChance = math.noise(sx*0.02, sz2*0.02) > 0.1
        mw({n="MFalda",sz=Vector3.new(sW,sH,sD),
            cf=CFrame.new(sx,W.BASE_Y+sH*0.35,sz2)*CFrame.Angles(math.rad(rng(5,18)),aMid+math.pi*0.5,0),
            col=heatherChance and W.C.M_HEATHER or lc(W.C.M_BASE,W.C.G_DARK,rng(0.2,0.5)),
            mat=Enum.Material.Ground, par=MF2})
    end
    for layer=1,LYRS do
        local lt=(layer-1)/(LYRS-1); local layerY=W.BASE_Y+lt*peakH
        local layerR=baseR*(1-lt*0.86)
        local col=layCol(lt); local mat=layMat(lt)
        local segH=rng(7,13)*(1-lt*0.52); local coreR=math.max(layerR*0.66,2.5)
        mp({n="MCore",sz=Vector3.new(coreR*2,segH*1.05,coreR*1.85),
            cf=CFrame.new(cx,layerY+segH*0.44,cz)*CFrame.Angles(0,math.rad(layer*17),0),
            col=lc(col,W.C.M_BASE,0.12),mat=mat,par=MF2})
        for s=1,SEGS do
            local ang=(s/SEGS)*math.pi*2; local segR=nR(ang,layer,layerR)
            local segX=cx+math.cos(ang)*segR; local segZ2=cz+math.sin(ang)*segR
            local arcW=segR*(math.pi*2/SEGS)*1.15
            local sH2=rng(6,12)*(1-lt*0.50); local sD=rng(3.5,8)*(1-lt*0.25)
            if s%2==0 then
                mw({n="MSeg",sz=Vector3.new(arcW,sH2,sD),
                    cf=CFrame.new(segX,layerY+sH2*0.4,segZ2)
                    *CFrame.Angles(math.rad(rng(-7,7)),ang+math.pi*0.5,0),
                    col=lc(col,W.C.M_BASE,rng(0,0.18)),mat=mat,par=MF2})
            else
                mp({n="MSeg",sz=Vector3.new(arcW,sH2*1.05,sD),
                    cf=CFrame.new(segX,layerY+sH2*0.48,segZ2)*CFrame.Angles(0,ang,0),
                    col=lc(col,W.C.M_BASE,rng(0,0.16)),mat=mat,par=MF2})
            end
        end
        if lt>0.55 then
            for s=1,SEGS do
                if math.random()<0.7 then
                    local sa=(s/SEGS)*math.pi*2
                    local snR=nR(sa,layer,layerR)*rng(0.25,0.82)
                    mp({n="MSnow",sz=Vector3.new(rng(2.8,layerR*0.58),1.4,rng(2.0,layerR*0.46)),
                        cf=CFrame.new(cx+math.cos(sa)*snR,layerY+segH*0.88,cz+math.sin(sa)*snR),
                        col=W.C.M_SNOW, mat=Enum.Material.Glacier,
                        cc=false,cs=false,par=MF2})
                end
            end
        end
        task.wait()
    end
    -- Cima
    local tipX=cx+rng(-1.5,1.5); local tipZ=cz+rng(-1.5,1.5)
    for pk=1,6 do
        local pkR=baseR*0.040*(7-pk); local pkH=peakH*0.038
        local pkY=peakH+W.BASE_Y-pkH*pk*0.28
        mw({n="MPk",sz=Vector3.new(pkR*1.8,pkH*1.3,pkR*1.72),
            cf=CFrame.new(tipX,pkY,tipZ)*CFrame.Angles(math.rad(rng(-4,4)),math.rad(rng(0,360)),0),
            col=W.C.M_SNOW,mat=Enum.Material.Glacier,cc=false,cs=false,par=MF2})
    end
end

local function buildMountains(MF2)
    local D=1350
    local groups={
        {x=0,      z=-(D+30),  h=rng(105,148),b=rng(40,58)},
        {x=-155,   z=-(D+72),  h=rng(88,130), b=rng(34,52)},
        {x=155,    z=-(D+65),  h=rng(92,138), b=rng(36,54)},
        {x=-340,   z=-(D+45),  h=rng(70,110), b=rng(28,44)},
        {x=340,    z=-(D+52),  h=rng(74,118), b=rng(30,48)},
        {x=-525,   z=-(D+22),  h=rng(60,95),  b=rng(24,40)},
        {x=525,    z=-(D+28),  h=rng(62,98),  b=rng(25,41)},
        {x=0,      z= (D+30),  h=rng(102,145),b=rng(40,57)},
        {x=-155,   z= (D+68),  h=rng(82,125), b=rng(33,50)},
        {x=155,    z= (D+60),  h=rng(85,130), b=rng(34,52)},
        {x=-342,   z= (D+45),  h=rng(68,108), b=rng(28,43)},
        {x=342,    z= (D+48),  h=rng(72,115), b=rng(29,45)},
        {x=-(D+32),z=0,        h=rng(100,142),b=rng(40,56)},
        {x=-(D+65),z=-148,     h=rng(78,120), b=rng(31,48)},
        {x=-(D+58),z=148,      h=rng(80,125), b=rng(32,50)},
        {x= (D+32),z=0,        h=rng(98,140), b=rng(38,55)},
        {x= (D+65),z=-142,     h=rng(76,118), b=rng(30,46)},
        {x= (D+56),z=142,      h=rng(78,122), b=rng(31,48)},
        {x=-(D+40),z=-(D+40),  h=rng(92,138), b=rng(37,54)},
        {x= (D+40),z=-(D+40),  h=rng(95,142), b=rng(38,56)},
        {x=-(D+40),z= (D+40),  h=rng(88,132), b=rng(35,52)},
        {x= (D+40),z= (D+40),  h=rng(90,136), b=rng(36,53)},
    }
    for i,g in ipairs(groups) do
        print(string.format("   Montañas Escocesas: %d/%d  h=%.0f",i,#groups,g.h))
        buildOnePeak(g.x,g.z,g.h,g.b,math.random()*200,MF2)
        for e=1,rngi(1,3) do
            local ea=rng(0,math.pi*2); local ed=rng(g.b*1.1,g.b*2.2)
            buildOnePeak(g.x+math.cos(ea)*ed,g.z+math.sin(ea)*ed,
                g.h*rng(0.30,0.65),g.b*rng(0.35,0.62),math.random()*200,MF2)
        end
        task.wait(0.08)
    end
    print("✅ Montañas Escocesas listas ("..#groups.." grupos)")
end

-- ═══════════════════════════════════════════════════════════════════
-- 11. NUBES (soleado) — Sobre Escocia
-- ═══════════════════════════════════════════════════════════════════
local function buildClouds(CF2)
    local hX=W.SIZE_X*0.5; local hZ=W.SIZE_Z*0.5
    local cloudCount=55
    for i=1,cloudCount do
        local cx=rng(-hX*0.8,hX*0.8); local cz=rng(-hZ*0.8,hZ*0.8)
        local cy=W.BASE_Y+rng(295,445)
        local cW=rng(175,365); local cD=rng(95,235); local cH=rng(30,58)
        mp({n="Cloud",sz=Vector3.new(cW,cH,cD),pos=Vector3.new(cx,cy,cz),
            col=W.C.CLOUD_W,mat=Enum.Material.SmoothPlastic,tr=rng(0.06,0.22),
            cc=false,cs=false,par=CF2})
        for b=1,rngi(4,8) do
            local ba=rng(0,math.pi*2); local bd=rng(cW*0.15,cW*0.38)
            mp({n="CloudB",sz=Vector3.new(cW*rng(0.22,0.55),cH*rng(0.55,1.10),cD*rng(0.22,0.50)),
                pos=Vector3.new(cx+math.cos(ba)*bd,cy+rng(-cH*0.2,cH*0.35),cz+math.sin(ba)*bd),
                col=lc(W.C.CLOUD_W,W.C.CLOUD_D,rng(0,0.3)),
                mat=Enum.Material.SmoothPlastic,tr=rng(0.10,0.30),cc=false,cs=false,par=CF2})
        end
    end
    -- Animación de nubes
    task.spawn(function()
        local t=0
        while true do
            t=t+0.01
            for _,cloud in ipairs(CF2:GetChildren()) do
                if cloud:IsA("BasePart") and cloud.Name=="Cloud" then
                    local pos=cloud.Position
                    cloud.Position=Vector3.new(
                        pos.X+math.sin(t*0.06)*0.012,
                        pos.Y+math.sin(t*0.12)*0.010,
                        pos.Z+0.015)
                    if cloud.Position.Z>W.SIZE_Z*0.5+55 then
                        cloud.Position=Vector3.new(pos.X,pos.Y,-W.SIZE_Z*0.5-55)
                    end
                end
            end
            task.wait(0.1)
        end
    end)
    print("✅ Nubes escocesas listas ("..cloudCount..")")
end

-- ═══════════════════════════════════════════════════════════════════
-- 12. ÁRBOLES COMUNES (Zona fuera del Bosque)
-- ═══════════════════════════════════════════════════════════════════
local function buildOneScotishTree(tx2, tz2, TrF2)
    local gy=groundH(tx2,tz2)
    local scale=rng(0.80,1.30)
    local trH=14*scale; local trW=2.2*scale; local cpR=10*scale
    local yRot=rng(0,math.pi*2)
    -- Base de tierra
    mp({n="TrBase",sz=Vector3.new(trW*5.0,0.6,trW*4.8),
        cf=CFrame.new(tx2,gy+0.2,tz2)*CFrame.Angles(0,yRot,0),
        col=lc(W.C.DIRT_D,W.C.G_MOSS,0.3),mat=Enum.Material.Ground,par=TrF2})
    -- Raíces
    for ri=1,rngi(4,6) do
        local ra=yRot+(ri/5)*math.pi*2+rng(-0.2,0.2)
        local rLen=trW*rng(2.5,4.0)
        mp({n="Root",sz=Vector3.new(trW*rng(0.5,0.8),trW*rng(0.3,0.5),rLen),
            cf=CFrame.new(tx2+math.cos(ra)*rLen*0.5,gy+trW*0.18,tz2+math.sin(ra)*rLen*0.5)
            *CFrame.Angles(math.rad(-6),ra,math.rad(rng(-8,8))),
            col=lc(W.C.F_BARK3,W.C.F_BARK,rng(0,0.4)),mat=Enum.Material.Wood,par=TrF2})
    end
    -- Tronco
    for s=1,5 do
        local st=(s-1)/4; local segH=(trH/5)*1.10; local segW=lerp(trW,trW*0.35,st)
        mp({n="Trk",sz=Vector3.new(segW*2,segH,segW*1.85),
            cf=CFrame.new(tx2,gy+st*trH+segH*0.5,tz2)*CFrame.Angles(0,yRot+s*0.18,0),
            col=lc(W.C.F_BARK,W.C.F_BARK2,rng(0,0.4)),mat=Enum.Material.Wood,par=TrF2})
    end
    -- Copa (estilo árbol escocés: más estrecha y oscura)
    local canopyBaseY=gy+trH*0.62
    local function addLump(fx2,fy,fz2,fW,fH,fD,cb)
        local col=cb>0.6 and W.C.G_MID or (cb>0.3 and W.C.G_DARK or W.C.F_LEAF_D)
        local lump=mp({n="Can",sz=Vector3.new(fW,fH,fD),
            cf=CFrame.new(fx2,fy,fz2)*CFrame.Angles(math.rad(rng(-7,7)),rng(0,math.pi*2),math.rad(rng(-7,7))),
            col=col,mat=Enum.Material.LeafyGrass,cc=false,par=TrF2})
        WeatherState.leafRefs[#WeatherState.leafRefs+1]=lump
    end
    for i=1,8 do
        local ang=(i/8)*math.pi*2+yRot
        local dist=cpR*rng(0.45,0.75)
        addLump(tx2+math.cos(ang)*dist,canopyBaseY+rng(cpR*0.05,cpR*0.28),
            tz2+math.sin(ang)*dist,cpR*rng(0.50,0.82),cpR*rng(0.40,0.60),cpR*rng(0.48,0.78),rng(0.1,0.4))
    end
    local core=mp({n="CanCore",sz=Vector3.new(cpR*1.45,cpR*0.88,cpR*1.38),
        cf=CFrame.new(tx2,canopyBaseY+cpR*0.42,tz2),
        col=W.C.G_DARK,mat=Enum.Material.LeafyGrass,cc=false,par=TrF2})
    WeatherState.leafRefs[#WeatherState.leafRefs+1]=core
    for i=1,5 do
        local ang=(i/5)*math.pi*2+yRot+0.42
        local dist=cpR*rng(0.22,0.50)
        addLump(tx2+math.cos(ang)*dist,canopyBaseY+cpR*rng(0.50,0.85),
            tz2+math.sin(ang)*dist,cpR*rng(0.38,0.62),cpR*rng(0.35,0.52),cpR*rng(0.36,0.60),rng(0.4,0.85))
    end
    local tip=mp({n="CanTop",sz=Vector3.new(cpR*0.62,cpR*0.42,cpR*0.58),
        cf=CFrame.new(tx2,canopyBaseY+cpR*0.95,tz2),
        col=W.C.G_BRIGHT,mat=Enum.Material.LeafyGrass,cc=false,cs=false,par=TrF2})
    WeatherState.leafRefs[#WeatherState.leafRefs+1]=tip
end

local function buildTrees(TrF2)
    local hX=W.SIZE_X*0.5-35; local hZ=W.SIZE_Z*0.5-35
    -- Excluir zona del Bosque Prohibido y del castillo
    local COUNT=420; local done=0; local tries=0
    while done<COUNT and tries<COUNT*12 do
        tries=tries+1
        local tx2=rng(-hX,hX); local tz2=rng(-hZ,hZ)
        -- Evitar zona del bosque prohibido
        local dForest=math.sqrt((tx2-W.FOREST_X)^2+(tz2-W.FOREST_Z)^2)
        -- Evitar zona del castillo y lago
        local dHog=math.sqrt((tx2-W.HOGWARTS_X)^2+(tz2-W.HOGWARTS_Z)^2)
        local dLake=math.sqrt((tx2-W.LAKE_X)^2+(tz2-W.LAKE_Z)^2)
        local dVill=math.sqrt((tx2-W.HOGSMEADE_X)^2+(tz2-W.HOGSMEADE_Z)^2)
        if dForest>680 and dHog>250 and dLake>220 and dVill>120 then
            local fn3=fnoise(tx2*0.020,tz2*0.020,3,0.5,2,1,W.SEED+99)
            if fn3>=0.02 and not isOcc(tx2,tz2,10) then
                markOcc(tx2,tz2,9)
                buildOneScotishTree(tx2,tz2,TrF2)
                done=done+1
            end
        end
        if tries%35==0 then task.wait()
            print(string.format("   Árboles escoceses %d/%d",done,COUNT)) end
    end
    print("✅ Árboles escoceses listos ("..done..")")
end

-- ═══════════════════════════════════════════════════════════════════
-- 13. HIERBAS Y BREZOS (Páramo escocés)
-- ═══════════════════════════════════════════════════════════════════
local function buildGrass(GF2)
    local hX=W.SIZE_X*0.5-10; local hZ=W.SIZE_Z*0.5-10
    local step=14; local painted=0
    for x=-hX,hX,step do
        for z=-hZ,hZ,step do
            local gy=groundH(x,z)
            local n1=fnoise(x*0.022,z*0.022,3,0.5,2,1,W.SEED+141)
            local n2=fnoise(x*0.048,z*0.048,2,0.5,2,1,W.SEED+211)
            local moorN=math.noise(x*0.015+15, z*0.015+15)
            local mat
            if moorN>0.22 then mat=Enum.Material.Ground
            elseif n1>0.08 or n2>0.18 then mat=Enum.Material.LeafyGrass
            else mat=Enum.Material.Grass end
            Terrain:FillBlock(CFrame.new(x,gy-0.2,z),
                Vector3.new(step+1.2,1.0+math.max(0,n2)*0.8,step+1.2),mat)
            painted=painted+1
        end
        task.wait()
    end
    -- Mechones de hierba alta / brezos
    local tallCount=1400; local done=0
    for i=1,tallCount do
        local gx=rng(-hX+12,hX-12); local gz=rng(-hZ+12,hZ-12)
        local gy=groundH(gx,gz)
        local fn=fnoise(gx*0.015,gz*0.015,3,0.5,2,1,W.SEED+333)
        if fn>0.04 and not isOcc(gx,gz,2.2) then
            markOcc(gx,gz,1.8)
            local bladeCount=rngi(3,6)
            for b=1,bladeCount do
                local bH=rng(1.5,3.2); local bW2=rng(0.18,0.35)
                local isHeather = math.noise(gx*0.035, gz*0.035)>0.15
                local bCol=isHeather and lc(W.C.G_HEATHER, W.C.G_MOOR, rng(0,0.4))
                    or (rngi(1,3)==1 and W.C.G_DARK or W.C.G_MID)
                local blade=mw({n="Grass",sz=Vector3.new(bW2,bH,bW2*0.5),
                    cf=CFrame.new(gx+rng(-1.2,1.2),gy+bH*0.5,gz+rng(-1,1))
                    *CFrame.Angles(math.rad(rng(-18,18)),rng(0,math.pi*2),math.rad(rng(-8,8))),
                    col=bCol,mat=Enum.Material.LeafyGrass,cc=false,cs=false,par=GF2})
                regWind(blade,rng(5,10),rng(0.5,1.0),rng(0,math.pi*2),0.5)
                WeatherState.leafRefs[#WeatherState.leafRefs+1]=blade
            end
            done=done+1
        end
        if i%200==0 then task.wait() end
    end
    -- Manchas de terreno irregular
    for i=1,450 do
        local gx=rng(-hX,hX); local gz=rng(-hZ,hZ); local gy=groundH(gx,gz)
        Terrain:FillBlock(CFrame.new(gx,gy-0.08,gz)*CFrame.Angles(0,rng(0,math.pi*2),0),
            Vector3.new(rng(8,22),rng(0.8,1.6),rng(8,22)),Enum.Material.LeafyGrass)
    end
    print("✅ Hierba/brezo escocés listo ("..painted.." celdas, "..done.." mechones)")
end

-- ═══════════════════════════════════════════════════════════════════
-- 14. CAMINOS ADOQUINADOS (estilo medieval)
-- ═══════════════════════════════════════════════════════════════════
local function buildPath(PF2)
    local hZ2=W.SIZE_Z*0.5; local hX2=W.SIZE_X*0.5
    local pathW=8.0; local edgeW=0.8

    local function pathSeg(px,pz,nx2,nz,wOvr)
        local w=wOvr or pathW
        local dir=Vector3.new(nx2-px,0,nz-pz)
        local segLen=math.max(8,dir.Magnitude+2.5)
        local py=surfaceH(px,pz)+0.10
        local pcf=CFrame.lookAt(Vector3.new(px,py,pz),Vector3.new(px,py,pz)+dir)
        local cn=math.noise(px*0.025+11,pz*0.025+11)
        local col=lc(W.C.PATH_COBBLE, W.C.PATH_EDGE, (cn*0.5+0.5)*0.5)
        -- Base de tierra
        mp({n="PtBase",sz=Vector3.new(w+1.8,0.38,segLen),
            cf=pcf*CFrame.new(0,-0.14,0),col=W.C.DIRT_D,mat=Enum.Material.Ground,par=PF2})
        -- Adoquines
        mp({n="Pt",sz=Vector3.new(w,0.42,segLen),cf=pcf,col=col,
            mat=cn>0.15 and Enum.Material.Concrete or Enum.Material.SmoothPlastic,par=PF2})
        -- Línea central desgastada
        if w>=7.5 then
            mp({n="PtMid",sz=Vector3.new(0.55,0.06,segLen),
                cf=pcf*CFrame.new(0,0.24,0),col=lc(W.C.PATH_EDGE,W.C.S_DARK,0.3),
                mat=Enum.Material.Concrete,cc=false,cs=false,par=PF2})
        end
        -- Bordes de piedra
        for side=-1,1,2 do
            mp({n="PtEdge",sz=Vector3.new(edgeW,0.58,segLen),
                cf=pcf*CFrame.new(side*(w*0.5+edgeW*0.5),0.08,0),
                col=W.C.S_DARK,mat=Enum.Material.Rock,par=PF2})
        end
        -- Piedras ocasionales al borde del camino
        if math.random()<0.18 then
            for side=-1,1,2 do
                local stX=px+rng(-1,1); local stZ=pz+rng(-1,1)
                local stY=surfaceH(stX,stZ); local ss=rng(0.4,0.9)
                mp({n="PtSt",sz=Vector3.new(ss,ss*0.6,ss*0.85),
                    cf=CFrame.new(stX,stY+ss*0.22,stZ)*CFrame.Angles(0,rng(0,math.pi*2),0),
                    col=W.C.S_AGED,mat=Enum.Material.Rock,cc=false,cs=false,par=PF2})
            end
        end
    end

    -- Camino principal Norte-Sur
    local segsNS=55
    for s=1,segsNS do
        local t=(s-1)/(segsNS-1); local t2=math.min(1,s/(segsNS-1))
        local pz=-hZ2*0.88+t*W.SIZE_Z*0.88
        local px=math.sin(t*math.pi*1.6)*18+math.sin(t*math.pi*4.0)*6
        local nz=-hZ2*0.88+t2*W.SIZE_Z*0.88
        local nx2=math.sin(t2*math.pi*1.6)*18+math.sin(t2*math.pi*4.0)*6
        pathSeg(px,pz,nx2,nz)
    end
    -- Camino Este-Oeste
    local segsEW=55
    for s=1,segsEW do
        local t=(s-1)/(segsEW-1); local t2=math.min(1,s/(segsEW-1))
        local px=-hX2*0.88+t*W.SIZE_X*0.88
        local pz=math.sin(t*math.pi*1.5)*18+math.sin(t*math.pi*3.5)*7
        local nx2=-hX2*0.88+t2*W.SIZE_X*0.88
        local nz=math.sin(t2*math.pi*1.5)*18+math.sin(t2*math.pi*3.5)*7
        pathSeg(px,pz,nx2,nz)
    end
    -- Camino de Hogwarts al lago
    local hogToLake=32
    for s=1,hogToLake do
        local t=(s-1)/31; local t2=math.min(1,s/31)
        local px=lerp(W.HOGWARTS_X, W.LAKE_X, t)+math.sin(t*math.pi*2)*12
        local pz=lerp(W.HOGWARTS_Z, W.LAKE_Z, t)
        local nx2=lerp(W.HOGWARTS_X, W.LAKE_X, t2)+math.sin(t2*math.pi*2)*12
        local nz=lerp(W.HOGWARTS_Z, W.LAKE_Z, t2)
        pathSeg(px,pz,nx2,nz,6.0)
    end
    -- Camino a Hogsmeade
    local hogToVill=28
    for s=1,hogToVill do
        local t=(s-1)/27; local t2=math.min(1,s/27)
        local px=lerp(W.HOGWARTS_X, W.HOGSMEADE_X, t)+math.sin(t*math.pi*1.8)*10
        local pz=lerp(W.HOGWARTS_Z, W.HOGSMEADE_Z, t)
        local nx2=lerp(W.HOGWARTS_X, W.HOGSMEADE_X, t2)+math.sin(t2*math.pi*1.8)*10
        local nz=lerp(W.HOGWARTS_Z, W.HOGSMEADE_Z, t2)
        pathSeg(px,pz,nx2,nz,6.5)
    end

    -- Intersección central (cruce)
    local iY=surfaceH(0,0)+0.12; local iSz=18
    mp({n="PtInter",sz=Vector3.new(iSz,0.45,iSz),pos=Vector3.new(0,iY,0),
        col=lc(W.C.PATH_COBBLE,W.C.PATH_EDGE,0.55),mat=Enum.Material.Concrete,par=PF2})
    mp({n="PtILineH",sz=Vector3.new(iSz,0.08,0.6),pos=Vector3.new(0,iY+0.22,0),
        col=W.C.S_DARK,mat=Enum.Material.Concrete,cc=false,cs=false,par=PF2})
    mp({n="PtILineV",sz=Vector3.new(0.6,0.08,iSz),pos=Vector3.new(0,iY+0.22,0),
        col=W.C.S_DARK,mat=Enum.Material.Concrete,cc=false,cs=false,par=PF2})

    -- Postes con farolas en las intersecciones principales
    local lampPosts={{0,0},{W.HOGWARTS_X,W.HOGWARTS_Z+115},
        {W.HOGSMEADE_X,W.HOGSMEADE_Z},{W.LAKE_X+5,W.LAKE_Z+190}}
    for _,lp2 in ipairs(lampPosts) do
        local lpY=surfaceH(lp2[1],lp2[2])
        mp({n="PathLamp",sz=Vector3.new(0.5,10,0.5),
            pos=Vector3.new(lp2[1],lpY+5,lp2[2]),
            col=Color3.fromRGB(28,28,28),mat=Enum.Material.Metal,par=PF2})
        mp({n="LampGlow",sz=Vector3.new(1.6,1.6,1.6),
            pos=Vector3.new(lp2[1],lpY+10.5,lp2[2]),
            col=W.C.CANDLE_F,mat=Enum.Material.Neon,tr=0.18,cc=false,par=PF2})
        local lpLight=Instance.new("PointLight")
        lpLight.Brightness=1.6; lpLight.Range=25; lpLight.Color=W.C.CANDLE_F
        lpLight.Parent=mp({n="LampL",sz=Vector3.new(0.3,0.3,0.3),
            pos=Vector3.new(lp2[1],lpY+10.5,lp2[2]),
            col=W.C.CANDLE_F,mat=Enum.Material.Neon,tr=0.92,cc=false,par=PF2})
    end
    print("✅ Caminos adoquinados medievales listos")
end

-- ═══════════════════════════════════════════════════════════════════
-- 15. SPAWN (Entrada Hogwarts)
-- ═══════════════════════════════════════════════════════════════════
local function setupSpawn()
    local sp=Workspace:FindFirstChild("SpawnLocation")
    if not sp then sp=Instance.new("SpawnLocation"); sp.Parent=Workspace end
    local spZ = W.HOGWARTS_Z + 140
    local spY = surfaceH(W.HOGWARTS_X, spZ) + 2
    sp.Position=Vector3.new(W.HOGWARTS_X, spY, spZ)
    sp.Size=Vector3.new(10,1,10)
    sp.BrickColor=BrickColor.new("Bright yellow"); sp.Material=Enum.Material.SmoothPlastic
    sp.Anchored=true; sp.Neutral=true
    -- Plataforma de llegada con estilo Hogwarts
    mp({n="SpawnPlatform", sz=Vector3.new(22, 1.5, 22),
        pos=Vector3.new(W.HOGWARTS_X, spY-0.5, spZ),
        col=W.C.S_MID, mat=Enum.Material.SmoothPlastic, par=FW})
    -- Antorcha de bienvenida
    for side=-1,1,2 do
        mp({n="SpawnTorch_Post", sz=Vector3.new(0.45,5,0.45),
            pos=Vector3.new(W.HOGWARTS_X+side*12, spY+2.5, spZ-11),
            col=W.C.H_CHIMNEY, mat=Enum.Material.Metal, par=FW})
        mp({n="SpawnTorch_Fire", sz=Vector3.new(1.2,1.5,1.2),
            pos=Vector3.new(W.HOGWARTS_X+side*12, spY+6, spZ-11),
            col=W.C.CANDLE_F, mat=Enum.Material.Neon, tr=0.1, cc=false, par=FW})
        local tLight=Instance.new("PointLight")
        tLight.Brightness=2.0; tLight.Range=22; tLight.Color=W.C.CANDLE_F
        tLight.Parent=mp({n="SpawnTorch_L", sz=Vector3.new(0.3,0.3,0.3),
            pos=Vector3.new(W.HOGWARTS_X+side*12, spY+6, spZ-11),
            col=W.C.CANDLE_F, mat=Enum.Material.Neon, tr=0.9, cc=false, par=FW})
    end
    print("✅ Spawn en entrada de Hogwarts listo")
end

-- ═══════════════════════════════════════════════════════════════════
-- MAIN BUILD — WIZARDING WORLD
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════════════════════════════════════════════════════════
-- MAIN BUILD — PARTE 2
-- ═══════════════════════════════════════════════════════════════════
local function buildWorld_Part2()
    print("════════════════════════════════════════════════════════════")
    print("⚡ WIZARDING WORLD — PARTE 2/2 — Iniciando…")
    print("════════════════════════════════════════════════════════════")
    local t0 = tick()

    local BFF  = mkFolder("ForbiddenForest",   FW)
    local VMF  = mkFolder("Hogsmeade",         FW)
    local MPlF = mkFolder("MagicPlants",       FW)
    local MF2  = mkFolder("ScottishMountains", FW)
    local TrF2 = mkFolder("Trees",             FW)
    local PF2  = mkFolder("Paths",             FW)
    local CF2  = mkFolder("Clouds",            FW)

    print("🌲 [1/6] Bosque Prohibido…");      buildForbiddenForest(BFF)
    print("🏘️  [2/6] Hogsmeade…");             buildHogsmeade(VMF)
    print("🌱 [3/6] Plantas Mágicas…");        buildMagicPlants(MPlF)
    print("⛰️  [4/6] Montañas Escocesas…");    buildMountains(MF2)
    startWind2()
    print("🌳 [5/6] Árboles Escoceses…");      buildTrees(TrF2)
    print("🛤️  [6/6] Caminos + Spawn…");       buildPath(PF2); setupSpawn()
    buildClouds(CF2)

    print("════════════════════════════════════════════════════════════")
    print(string.format("✅ PARTE 2 lista en %.1f s — ¡Mundo completo!", tick()-t0))
    print("🌲 Bosque Prohibido: ACTIVO")
    print("🏘️  Hogsmeade: ACTIVO (12 edificios)")
    print("🌱 Plantas Mágicas: ACTIVAS (Whomping Willow, Mandrágoras, Tentacula)")
    print("⛰️  Montañas Escocesas: ACTIVAS")
    print("🌳 Árboles escoceses: ACTIVOS")
    print("🛤️  Caminos adoquinados: ACTIVOS")
    print("════════════════════════════════════════════════════════════")
    print("💡 PRÓXIMOS PASOS:")
    print("   • Sistema de hechizos (varitas como herramientas)")
    print("   • Casas + puntos (Gryffindor, Slytherin, Ravenclaw, Hufflepuff)")
    print("   • Escobas voladoras + Quidditch")
    print("   • NPCs (Dumbledore, Hagrid, Snape)")
    print("════════════════════════════════════════════════════════════")
end

buildWorld_Part2()
