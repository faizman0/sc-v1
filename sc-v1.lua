-------------------------------------------------------------------------------
--! json library
--! cryptography library
local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;local e;local l={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local P={["/"]="/"}for Q,R in pairs(l)do P[R]=Q end;local S=function(T)return"\\"..(l[T]or string.format("u%04x",T:byte()))end;local B=function(M)return"null"end;local v=function(M,z)local _={}z=z or{}if z[M]then error("circular reference")end;z[M]=true;if rawget(M,1)~=nil or next(M)==nil then local A=0;for Q in pairs(M)do if type(Q)~="number"then error("invalid table: mixed or invalid key types")end;A=A+1 end;if A~=#M then error("invalid table: sparse array")end;for a0,R in ipairs(M)do table.insert(_,e(R,z))end;z[M]=nil;return"["..table.concat(_,",").."]"else for Q,R in pairs(M)do if type(Q)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(_,e(Q,z)..":"..e(R,z))end;z[M]=nil;return"{"..table.concat(_,",").."}"end end;local g=function(M)return'"'..M:gsub('[%z\1-\31\\"]',S)..'"'end;local a1=function(M)if M~=M or M<=-math.huge or M>=math.huge then error("unexpected number value '"..tostring(M).."'")end;return string.format("%.14g",M)end;local j={["nil"]=B,["table"]=v,["string"]=g,["number"]=a1,["boolean"]=tostring}e=function(M,z)local x=type(M)local a2=j[x]if a2 then return a2(M,z)end;error("unexpected type '"..x.."'")end;local a3=function(M)return e(M)end;local a4;local N=function(...)local _={}for a0=1,select("#",...)do _[select(a0,...)]=true end;return _ end;local L=N(" ","\t","\r","\n")local p=N(" ","\t","\r","\n","]","}",",")local a5=N("\\","/",'"',"b","f","n","r","t","u")local m=N("true","false","null")local a6={["true"]=true,["false"]=false,["null"]=nil}local a7=function(a8,a9,aa,ab)for a0=a9,#a8 do if aa[a8:sub(a0,a0)]~=ab then return a0 end end;return#a8+1 end;local ac=function(a8,a9,J)local ad=1;local ae=1;for a0=1,a9-1 do ae=ae+1;if a8:sub(a0,a0)=="\n"then ad=ad+1;ae=1 end end;error(string.format("%s at line %d col %d",J,ad,ae))end;local af=function(A)local a2=math.floor;if A<=0x7f then return string.char(A)elseif A<=0x7ff then return string.char(a2(A/64)+192,A%64+128)elseif A<=0xffff then return string.char(a2(A/4096)+224,a2(A%4096/64)+128,A%64+128)elseif A<=0x10ffff then return string.char(a2(A/262144)+240,a2(A%262144/4096)+128,a2(A%4096/64)+128,A%64+128)end;error(string.format("invalid unicode codepoint '%x'",A))end;local ag=function(ah)local ai=tonumber(ah:sub(1,4),16)local aj=tonumber(ah:sub(7,10),16)if aj then return af((ai-0xd800)*0x400+aj-0xdc00+0x10000)else return af(ai)end end;local ak=function(a8,a0)local _=""local al=a0+1;local Q=al;while al<=#a8 do local am=a8:byte(al)if am<32 then ac(a8,al,"control character in string")elseif am==92 then _=_..a8:sub(Q,al-1)al=al+1;local T=a8:sub(al,al)if T=="u"then local an=a8:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",al+1)or a8:match("^%x%x%x%x",al+1)or ac(a8,al-1,"invalid unicode escape in string")_=_..ag(an)al=al+#an else if not a5[T]then ac(a8,al-1,"invalid escape char '"..T.."' in string")end;_=_..P[T]end;Q=al+1 elseif am==34 then _=_..a8:sub(Q,al-1)return _,al+1 end;al=al+1 end;ac(a8,a0,"expected closing quote for string")end;local ao=function(a8,a0)local am=a7(a8,a0,p)local ah=a8:sub(a0,am-1)local A=tonumber(ah)if not A then ac(a8,a0,"invalid number '"..ah.."'")end;return A,am end;local ap=function(a8,a0)local am=a7(a8,a0,p)local aq=a8:sub(a0,am-1)if not m[aq]then ac(a8,a0,"invalid literal '"..aq.."'")end;return a6[aq],am end;local ar=function(a8,a0)local _={}local A=1;a0=a0+1;while 1 do local am;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="]"then a0=a0+1;break end;am,a0=a4(a8,a0)_[A]=am;A=A+1;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="]"then break end;if as~=","then ac(a8,a0,"expected ']' or ','")end end;return _,a0 end;local at=function(a8,a0)local _={}a0=a0+1;while 1 do local au,M;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="}"then a0=a0+1;break end;if a8:sub(a0,a0)~='"'then ac(a8,a0,"expected string for key")end;au,a0=a4(a8,a0)a0=a7(a8,a0,L,true)if a8:sub(a0,a0)~=":"then ac(a8,a0,"expected ':' after key")end;a0=a7(a8,a0+1,L,true)M,a0=a4(a8,a0)_[au]=M;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="}"then break end;if as~=","then ac(a8,a0,"expected '}' or ','")end end;return _,a0 end;local av={['"']=ak,["0"]=ao,["1"]=ao,["2"]=ao,["3"]=ao,["4"]=ao,["5"]=ao,["6"]=ao,["7"]=ao,["8"]=ao,["9"]=ao,["-"]=ao,["t"]=ap,["f"]=ap,["n"]=ap,["["]=ar,["{"]=at}a4=function(a8,a9)local as=a8:sub(a9,a9)local a2=av[as]if a2 then return a2(a8,a9)end;ac(a8,a9,"unexpected character '"..as.."'")end;local aw=function(a8)if type(a8)~="string"then error("expected argument of type string, got "..type(a8))end;local _,a9=a4(a8,a7(a8,1,L,true))a9=a7(a8,a9,L,true)if a9<=#a8 then ac(a8,a9,"trailing garbage")end;return _ end;
local lEncode, lDecode, lDigest = a3, aw, Z;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--! platoboost library
--! configuration
local service = 3455;  -- your service id, this is used to identify your service.
local secret = "dd62864b-3b52-43c5-bf65-c9579b568a48";  -- make sure to obfuscate this if you want to ensure security.
local useNonce = true;  -- use a nonce to prevent replay attacks and request tampering.

--! callbacks

local onMessage = function(message) end;
--! wait for game to load
repeat task.wait(1) until game:IsLoaded();
--! functions
local requestSending = false;
local fSetClipboard, fRequest, fStringChar, fToString, fStringSub, fOsTime, fMathRandom, fMathFloor, fGetHwid = setclipboard or toclipboard, request or http_request or syn_request, string.char, tostring, string.sub, os.time, math.random, math.floor, gethwid or function() return game:GetService("Players").LocalPlayer.UserId end
local cachedLink, cachedTime = "", 0;

--! pick host

local host = "https://api.platoboost.com";
local hostResponse = fRequest({
    Url = host .. "/public/connectivity",
    Method = "GET"
});
if hostResponse.StatusCode ~= 200 or hostResponse.StatusCode ~= 429 then
    host = "https://api.platoboost.net";
end
--!optimize 2
function cacheLink()
    if cachedTime + (10*60) < fOsTime() then
        local response = fRequest({
            Url = host .. "/public/start",
            Method = "POST",
            Body = lEncode({
                service = service,
                identifier = lDigest(fGetHwid())
            }),
            Headers = {
                ["Content-Type"] = "application/json"
            }
        });

        if response.StatusCode == 200 then
            local decoded = lDecode(response.Body);
            if decoded.success == true then
                cachedLink = decoded.data.url;
                cachedTime = fOsTime();
                return true, cachedLink;
            else
                onMessage(decoded.message);
                return false, decoded.message;
            end
        elseif response.StatusCode == 429 then
            local msg = "you are being rate limited, please wait 20 seconds and try again.";
            onMessage(msg);
            return false, msg;
        end

        local msg = "Failed to cache link.";
        onMessage(msg);
        return false, msg;
    else
        return true, cachedLink;
    end
end

cacheLink();

--!optimize 2

local generateNonce = function()
    local str = ""
    for _ = 1, 16 do
        str = str .. fStringChar(fMathFloor(fMathRandom() * (122 - 97 + 1)) + 97)
    end
    return str
end

--!optimize 1

for _ = 1, 5 do
    local oNonce = generateNonce();
    task.wait(0.2)
    if generateNonce() == oNonce then
        local msg = "platoboost nonce error.";
        onMessage(msg);
        error(msg);
    end
end

--!optimize 2

local copyLink = function()
    local success, link = cacheLink();
    if success then
        fSetClipboard(link);
    end
end

--!optimize 2

local redeemKey = function(key)
    local nonce = generateNonce();
    local endpoint = host .. "/public/redeem/" .. fToString(service);
    local body = {
        identifier = lDigest(fGetHwid()),
        key = key
    }

    if useNonce then
        body.nonce = nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "POST",
        Body = lEncode(body),
        Headers = {
            ["Content-Type"] = "application/json"
        }
    });

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);
        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true;
                    else
                        onMessage("failed to verify integrity.");
                        return false;
                    end    
                else
                    return true;
                end
            else
                onMessage("key is invalid.");
                return false;
            end
        else
            if fStringSub(decoded.message, 1, 27) == "unique constraint violation" then
                onMessage("you already have an active key, please wait for it to expire before redeeming it.");
                return false;
            else
                onMessage(decoded.message);
                return false;
            end
        end
    elseif response.StatusCode == 429 then
        onMessage("you are being rate limited, please wait 20 seconds and try again.");
        return false;
    else
        onMessage("server returned an invalid status code, please try again later.");
        return false; 
    end
end



--!optimize 2

local verifyKey = function(key)
    if requestSending == true then
        onMessage("a request is already being sent, please slow down.");
        return false;
    else
        requestSending = true;
    end

    local nonce = generateNonce();
    local endpoint = host .. "/public/whitelist/" .. fToString(service) .. "?identifier=" .. lDigest(fGetHwid()) .. "&key=" .. key;

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    });

    requestSending = false;

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true;
                    else
                        onMessage("failed to verify integrity.");
                        return false;
                    end
                else
                    return true;
                end
            else
                if fStringSub(key, 1, 4) == "KEY_" then
                    return redeemKey(key);
                else
                    onMessage("key is invalid.");
                    return false;
                end
            end
        else
            onMessage(decoded.message);
            return false;
        end
    elseif response.StatusCode == 429 then
        onMessage("you are being rate limited, please wait 20 seconds and try again.");
        return false;
    else
        onMessage("server returned an invalid status code, please try again later.");
        return false;
    end
end

--!optimize 2

local getFlag = function(name)
    local nonce = generateNonce();
    local endpoint = host .. "/public/flag/" .. fToString(service) .. "?name=" .. name;

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    });

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if useNonce then
                if decoded.data.hash == lDigest(fToString(decoded.data.value) .. "-" .. nonce .. "-" .. secret) then
                    return decoded.data.value;
                else
                    onMessage("failed to verify integrity.");
                    return nil;
                end
            else
                return decoded.data.value;
            end
        else
            onMessage(decoded.message);
            return nil;
        end
    else
        return nil;
    end
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--! platoboost usage documentation

-- copyLink() -> string

-- verifyKey(key: string) -> boolean

-- getFlag(name: string) -> boolean, string | boolean | number



-- use copyLink() to copy a link to the clipboard, in which the user will paste it into their browser and complete the keysystem.

-- use verifyKey(key) to verify a key, this will return a boolean value, true means the key was valid, false means it is invalid.

-- use getFlag(name) to get a flag from the server, this will return nil if an error occurs, if no error occurs, the value configured in the platoboost dashboard will be returned.



-- IMPORTANT: onMessage is a callback, it will be called upon status update, use it to provide information to user.

-- EXAMPLE: 

--[[

onMessage = function(message)

    game:GetService("StarterGui"):SetCore("SendNotification", {

        Title = "Platoboost status",

        Text = message

    })

end

]]--



-- NOTE: PLACE THIS ENTIRE SCRIPT AT THE TOP OF YOUR SCRIPT, ADD THE LOGIC, THEN OBFUSCATE YOUR SCRIPT.



--! example usage

--[[

copyButton.MouseButton1Click:Connect(function()

    copyLink();

end)



verifyButton.MouseButton1Click:Connect(function()

    local key = keyBox.Text;

    local success = verifyKey(key);



    if success then

        print("key is valid.");

    else

        print("key is invalid.");

    end

end)



local flag = getFlag("example_flag");

if flag ~= nil then

    print("flag value: " .. flag);

else

    print("failed to get flag.");

end

]]--

-------------------------------------------------------------------------------

-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- local Window = Rayfield:CreateWindow({
--    Name = "Streetlife",
--    Icon = 0,
--    LoadingTitle = "LAJ Hub",
--    LoadingSubtitle = "by libyaarmy",
--    Theme = "Default",
--    DisableRayfieldPrompts = false,
--    DisableBuildWarnings = false,
--    ConfigurationSaving = {
--       Enabled = true,
--       FolderName = nil,
--       FileName = "LAJ Hub"
--    },
--    Discord = {
--       Enabled = true,
--       Invite = "3d2UT7BhHE",
--       RememberJoins = true
--    },
--    KeySystem = true,
--    KeySettings = {
--       Title = "LAJ Hub | Key System",
--       Subtitle = "Join our Discord to get a key",
--       Note = "Click below to copy the key link",
--       FileName = "LAJ_Hub_Key",
--       SaveKey = true,
--       GrabKeyFromSite = false,
--       GetKey = function()
--          copyLink()
--       end,
--       CheckKey = function(key)
--          return verifyKey(key)
--       end
--    }
-- })

local Window = Rayfield:CreateWindow({
   Name = "Faiz Ni Boss Senggol Dong",
   Icon = 0,
   LoadingTitle = "Faiz",
   LoadingSubtitle = "by Faiz ni boss",
   Theme = "Default",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "LAJ Hub"
   },
   Discord = {
      Enabled = true,
      Invite = "3d2UT7BhHE",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "Faiz",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"FaizniBoss"}, -- list of keys that will open the script
   }
})

-- Combat Tab
local CombatTab = Window:CreateTab("Combat", 4483362458)

-- Safe Tween-Based Teleports
local TweenService = game:GetService("TweenService")
local function SafeTeleport(position)
   local char = game.Players.LocalPlayer.Character
   local root = char and char:FindFirstChild("HumanoidRootPart")
   if not root then return end
   local tween = TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(position)})
   tween:Play()
end

-- Aimbot Configuration
local aimbotConfig = {
    enabled = false,
    smoothing = 0.1,
    fov = 200,
    targetPart = "Head", -- Head, Torso, HumanoidRootPart
    teamCheck = true,
    visibleCheck = true,
    maxDistance = 1000
}

-- Aimbot Variables
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Aimbot Functions
local function getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = aimbotConfig.fov
    local cameraPosition = Camera.CFrame.Position
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            -- Team check
            if aimbotConfig.teamCheck and player.Team == LocalPlayer.Team then
                continue
            end
            
            local character = player.Character
            local targetPart = character:FindFirstChild(aimbotConfig.targetPart)
            
            if targetPart then
                local distance = (targetPart.Position - cameraPosition).Magnitude
                
                -- Distance check
                if distance <= aimbotConfig.maxDistance then
                    -- Visibility check
                    if aimbotConfig.visibleCheck then
                        local raycastParams = RaycastParams.new()
                        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                        raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
                        
                        local raycastResult = workspace:Raycast(cameraPosition, (targetPart.Position - cameraPosition).Unit * distance, raycastParams)
                        
                        if raycastResult and raycastResult.Instance:IsDescendantOf(character) then
                            -- Calculate FOV
                            local screenPosition, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                            if onScreen then
                                local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                                local distanceFromCenter = (Vector2.new(screenPosition.X, screenPosition.Y) - screenCenter).Magnitude
                                
                                if distanceFromCenter < closestDistance then
                                    closestDistance = distanceFromCenter
                                    closestPlayer = player
                                end
                            end
                        end
                    else
                        -- No visibility check
                        local screenPosition, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                        if onScreen then
                            local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                            local distanceFromCenter = (Vector2.new(screenPosition.X, screenPosition.Y) - screenCenter).Magnitude
                            
                            if distanceFromCenter < closestDistance then
                                closestDistance = distanceFromCenter
                                closestPlayer = player
                            end
                        end
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

local function aimAtTarget(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    
    local targetPart = targetPlayer.Character:FindFirstChild(aimbotConfig.targetPart)
    if not targetPart then return end
    
    local cameraPosition = Camera.CFrame.Position
    local targetPosition = targetPart.Position
    
    -- Calculate the direction to the target
    local direction = (targetPosition - cameraPosition).Unit
    
    -- Apply smoothing
    local currentLookDirection = Camera.CFrame.LookVector
    local smoothedDirection = currentLookDirection:Lerp(direction, aimbotConfig.smoothing)
    
    -- Create new CFrame
    local newCFrame = CFrame.lookAt(cameraPosition, cameraPosition + smoothedDirection)
    
    -- Apply the new camera rotation
    Camera.CFrame = newCFrame
end

-- Aimbot Main Loop
local aimbotConnection
local function startAimbot()
    if aimbotConnection then
        aimbotConnection:Disconnect()
    end
    
    aimbotConnection = RunService.Heartbeat:Connect(function()
        if aimbotConfig.enabled then
            local targetPlayer = getClosestPlayer()
            if targetPlayer then
                aimAtTarget(targetPlayer)
            end
        end
    end)
end

local function stopAimbot()
    if aimbotConnection then
        aimbotConnection:Disconnect()
        aimbotConnection = nil
    end
end

-- Aimbot UI Controls

CombatTab:CreateSlider({
    Name = "Aimbot Smoothing",
    Range = {0.01, 1},
    Increment = 0.01,
    Suffix = "Smooth",
    CurrentValue = 0.1,
    Callback = function(Value)
        aimbotConfig.smoothing = Value
    end,
})

CombatTab:CreateSlider({
    Name = "Aimbot FOV",
    Range = {50, 500},
    Increment = 10,
    Suffix = "FOV",
    CurrentValue = 200,
    Callback = function(Value)
        aimbotConfig.fov = Value
    end,
})

CombatTab:CreateSlider({
    Name = "Max Distance",
    Range = {100, 2000},
    Increment = 50,
    Suffix = "Studs",
    CurrentValue = 1000,
    Callback = function(Value)
        aimbotConfig.maxDistance = Value
    end,
})

CombatTab:CreateDropdown({
    Name = "Target Part",
    Options = {"Head", "Torso", "HumanoidRootPart"},
    CurrentOption = "Head",
    Callback = function(Option)
        aimbotConfig.targetPart = Option
    end,
})

CombatTab:CreateToggle({
    Name = "Team Check",
    CurrentValue = true,
    Callback = function(Value)
        aimbotConfig.teamCheck = Value
    end,
})

CombatTab:CreateToggle({
    Name = "Visibility Check",
    CurrentValue = true,
    Callback = function(Value)
        aimbotConfig.visibleCheck = Value
    end,
})

-- Double Damage Configuration
local doubleDamageConfig = {
    enabled = false,
    multiplier = 2.0
}

-- Double Damage Functions
local function setupDoubleDamage()
    local hookedEvents = {}
    
    -- Hook into RemoteEvents
    local function hookRemoteEvent(event)
        if event and event:IsA("RemoteEvent") and not hookedEvents[event] then
            hookedEvents[event] = true
            local originalFireServer = event.FireServer
            
            event.FireServer = function(self, ...)
                local args = {...}
                
                if doubleDamageConfig.enabled then
                    -- Process all arguments
                    for i, arg in pairs(args) do
                        if type(arg) == "number" and arg > 0 and arg < 10000 then
                            -- Direct damage value
                            args[i] = arg * doubleDamageConfig.multiplier
                        elseif type(arg) == "table" then
                            -- Table with damage data
                            for key, value in pairs(arg) do
                                if type(value) == "number" and value > 0 and value < 10000 then
                                    -- Check if this looks like damage
                                    local keyLower = tostring(key):lower()
                                    if keyLower:find("damage") or keyLower:find("amount") or keyLower:find("dmg") or 
                                       keyLower:find("health") or keyLower:find("hp") or keyLower:find("hit") then
                                        arg[key] = value * doubleDamageConfig.multiplier
                                    end
                                end
                            end
                        end
                    end
                end
                
                return originalFireServer(self, unpack(args))
            end
        end
    end
    
    -- Hook RemoteFunctions
    local function hookRemoteFunction(func)
        if func and func:IsA("RemoteFunction") and not hookedEvents[func] then
            hookedEvents[func] = true
            local originalInvokeServer = func.InvokeServer
            
            func.InvokeServer = function(self, ...)
                local args = {...}
                
                if doubleDamageConfig.enabled then
                    -- Process all arguments
                    for i, arg in pairs(args) do
                        if type(arg) == "number" and arg > 0 and arg < 10000 then
                            args[i] = arg * doubleDamageConfig.multiplier
                        elseif type(arg) == "table" then
                            for key, value in pairs(arg) do
                                if type(value) == "number" and value > 0 and value < 10000 then
                                    local keyLower = tostring(key):lower()
                                    if keyLower:find("damage") or keyLower:find("amount") or keyLower:find("dmg") or 
                                       keyLower:find("health") or keyLower:find("hp") or keyLower:find("hit") then
                                        arg[key] = value * doubleDamageConfig.multiplier
                                    end
                                end
                            end
                        end
                    end
                end
                
                return originalInvokeServer(self, unpack(args))
            end
        end
    end
    
    -- Hook all existing RemoteEvents and RemoteFunctions
    local function hookAllEvents()
        -- Hook ReplicatedStorage
        if game.ReplicatedStorage then
            for _, obj in pairs(game.ReplicatedStorage:GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    hookRemoteEvent(obj)
                elseif obj:IsA("RemoteFunction") then
                    hookRemoteFunction(obj)
                end
            end
        end
        
        -- Hook workspace
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                hookRemoteEvent(obj)
            elseif obj:IsA("RemoteFunction") then
                hookRemoteFunction(obj)
            end
        end
        
        -- Hook Players
        if game.Players then
            for _, obj in pairs(game.Players:GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    hookRemoteEvent(obj)
                elseif obj:IsA("RemoteFunction") then
                    hookRemoteFunction(obj)
                end
            end
        end
    end
    
    -- Initial hook
    hookAllEvents()
    
    -- Hook new events as they're added
    local function onDescendantAdded(obj)
        if obj:IsA("RemoteEvent") then
            hookRemoteEvent(obj)
        elseif obj:IsA("RemoteFunction") then
            hookRemoteFunction(obj)
        end
    end
    
    -- Connect to descendant added events
    if game.ReplicatedStorage then
        game.ReplicatedStorage.DescendantAdded:Connect(onDescendantAdded)
    end
    workspace.DescendantAdded:Connect(onDescendantAdded)
    if game.Players then
        game.Players.DescendantAdded:Connect(onDescendantAdded)
    end
end

-- Setup double damage
pcall(setupDoubleDamage)

-- Double Damage UI Controls
CombatTab:CreateSlider({
    Name = "Damage Multiplier",
    Range = {1, 10},
    Increment = 0.1,
    Suffix = "x",
    CurrentValue = 2.0,
    Callback = function(Value)
        doubleDamageConfig.multiplier = Value
    end,
})

-- Misc Tab
local MiscTab = Window:CreateTab("Misc", 4483362458)
MiscTab:CreateParagraph({Title = "Teleport Locations", Content = "Teleport to important places in StreetLife"})

-- MiscTab:CreateButton({
--    Name = "Teleport to Rap Station",
--    Callback = function()
--       SafeTeleport(Vector3.new(902.2052, 53.62046, -60.20349))
--    end,
-- })

-- MiscTab:CreateButton({
--    Name = "Teleport to Apartment 1",
--    Callback = function()
--       SafeTeleport(Vector3.new(552.0478, -44.42898, -187.2999))
--    end,
-- })

-- MiscTab:CreateButton({
--    Name = "Teleport to Bank",
--    Callback = function()
--       SafeTeleport(Vector3.new(397.2554, 49.25748, 101.6725))
--    end,
-- })

-- MiscTab:CreateButton({
--    Name = "Teleport to The ICE",
--    Callback = function()
--       SafeTeleport(Vector3.new(185.0867, -89.2156, 150.2669))
--    end,
-- })

-- Player Tab
local PlayerTab = Window:CreateTab("Player", 4483362458)
PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {1, 250},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Callback = function(Value)
      local char = game.Players.LocalPlayer.Character
      local hum = char and char:FindFirstChildOfClass("Humanoid")
      if hum then
         hum.WalkSpeed = Value
      end
   end,
})

-- Aimbot Toggle in Player Tab
PlayerTab:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Callback = function(Value)
        aimbotConfig.enabled = Value
        if Value then
            startAimbot()
        else
            stopAimbot()
        end
    end,
})

-- Double Damage Toggle in Player Tab
PlayerTab:CreateToggle({
    Name = "Double Damage",
    CurrentValue = false,
    Callback = function(Value)
        doubleDamageConfig.enabled = Value
    end,
})

-- Max Health Configuration
local maxHealthConfig = {
    enabled = false,
    healthValue = 100
}

-- Max Health Functions
local function setupMaxHealth()
    local function setMaxHealth()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            local humanoid = char.Humanoid
            humanoid.MaxHealth = maxHealthConfig.healthValue
            humanoid.Health = maxHealthConfig.healthValue
        end
    end
    
    -- Set max health when character spawns
    game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
        if maxHealthConfig.enabled then
            wait(1) -- Wait for character to fully load
            setMaxHealth()
        end
    end)
    
    -- Set max health for current character
    if game.Players.LocalPlayer.Character then
        setMaxHealth()
    end
    
    -- Monitor health and restore if damaged
    local healthConnection
    healthConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if maxHealthConfig.enabled then
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                local humanoid = char.Humanoid
                if humanoid.Health < maxHealthConfig.healthValue then
                    humanoid.Health = maxHealthConfig.healthValue
                end
                if humanoid.MaxHealth ~= maxHealthConfig.healthValue then
                    humanoid.MaxHealth = maxHealthConfig.healthValue
                end
            end
        else
            if healthConnection then
                healthConnection:Disconnect()
            end
        end
    end)
end

-- Setup max health
pcall(setupMaxHealth)

-- Max Health Toggle in Player Tab
PlayerTab:CreateToggle({
    Name = "Max Health",
    CurrentValue = false,
    Callback = function(Value)
        maxHealthConfig.enabled = Value
        if Value then
            -- Set health immediately when enabled
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.MaxHealth = maxHealthConfig.healthValue
                char.Humanoid.Health = maxHealthConfig.healthValue
            end
        end
    end,
})

-- Max Health Slider in Player Tab
PlayerTab:CreateSlider({
    Name = "Max Health Value",
    Range = {50, 1000},
    Increment = 10,
    Suffix = "HP",
    CurrentValue = 100,
    Callback = function(Value)
        maxHealthConfig.healthValue = Value
        if maxHealthConfig.enabled then
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.MaxHealth = Value
                char.Humanoid.Health = Value
            end
        end
    end,
})

-- Rob Corpses Configuration (Bypass Payment System)
local robCorpsesConfig = {
    enabled = false,
    robDistance = 50,
    robDelay = 0.5,
    bypassPayment = true
}

-- Rob Corpses Functions (Free Robbing System)
local function setupRobCorpses()
    local lastRobTime = 0
    
    local function findDeadPlayers()
        local corpses = {}
        local playerPos = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if not playerPos then return corpses end
        
        -- Look for dead players in workspace
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj.Name == "Character" then
                local humanoid = obj:FindFirstChild("Humanoid")
                local rootPart = obj:FindFirstChild("HumanoidRootPart")
                
                if humanoid and rootPart and humanoid.Health <= 0 then
                    local distance = (rootPart.Position - playerPos.Position).Magnitude
                    if distance <= robCorpsesConfig.robDistance then
                        table.insert(corpses, obj)
                    end
                end
            end
        end
        
        return corpses
    end
    
    local function bypassRobberyPayment()
        -- Hook into robbery payment systems
        local function hookRobberyEvents()
            -- Look for robbery-related RemoteEvents
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    local name = obj.Name:lower()
                    if name:find("rob") or name:find("loot") or name:find("steal") or name:find("corpse") then
                        local originalFire = obj.FireServer
                        obj.FireServer = function(self, ...)
                            local args = {...}
                            
                            if robCorpsesConfig.bypassPayment then
                                -- Modify arguments to bypass payment
                                for i, arg in pairs(args) do
                                    if type(arg) == "table" then
                                        -- Remove payment requirements
                                        if arg.payment or arg.pay or arg.cost or arg.price then
                                            arg.payment = 0
                                            arg.pay = 0
                                            arg.cost = 0
                                            arg.price = 0
                                        end
                                        -- Set as free robbery
                                        arg.free = true
                                        arg.premium = true
                                        arg.vip = true
                                    end
                                end
                            end
                            
                            return originalFire(self, unpack(args))
                        end
                    end
                end
            end
        end
        
        hookRobberyEvents()
    end
    
    local function robCorpse(corpse)
        if not corpse or not corpse:FindFirstChild("HumanoidRootPart") then return end
        
        local rootPart = corpse.HumanoidRootPart
        local playerPos = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if not playerPos then return end
        
        -- Teleport to corpse for robbery
        local tween = TweenService:Create(playerPos, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {CFrame = rootPart.CFrame})
        tween:Play()
        
        -- Bypass payment system and rob directly
        bypassRobberyPayment()
        
        -- Look for items to rob
        for _, obj in pairs(corpse:GetDescendants()) do
            if obj:IsA("Tool") or obj:IsA("Part") then
                -- Rob weapons/tools
                if obj:IsA("Tool") then
                    obj.Parent = game.Players.LocalPlayer.Backpack
                elseif obj:IsA("Part") and (obj.Name:lower():find("money") or obj.Name:lower():find("cash") or obj.Name:lower():find("coin") or obj.Name:lower():find("wallet")) then
                    -- Rob money/cash directly
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
                end
            end
        end
        
        -- Rob dropped items near corpse
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") or obj:IsA("Part") then
                local distance = (obj.Position - rootPart.Position).Magnitude
                if distance <= 10 then
                    if obj:IsA("Tool") then
                        obj.Parent = game.Players.LocalPlayer.Backpack
                    elseif obj:IsA("Part") and (obj.Name:lower():find("money") or obj.Name:lower():find("cash") or obj.Name:lower():find("coin") or obj.Name:lower():find("wallet")) then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
                    end
                end
            end
        end
        
        -- Try to trigger robbery events with bypassed payment
        local robberyEvents = {"RobCorpse", "LootCorpse", "StealCorpse", "RobPlayer", "LootPlayer"}
        for _, eventName in pairs(robberyEvents) do
            local event = workspace:FindFirstChild(eventName) or game.ReplicatedStorage:FindFirstChild(eventName)
            if event and event:IsA("RemoteEvent") then
                event:FireServer(corpse, {free = true, premium = true, payment = 0})
            end
        end
    end
    
    -- Main robbery loop
    local robConnection
    robConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if robCorpsesConfig.enabled then
            local currentTime = tick()
            if currentTime - lastRobTime >= robCorpsesConfig.robDelay then
                local corpses = findDeadPlayers()
                if #corpses > 0 then
                    robCorpse(corpses[1]) -- Rob the first corpse found
                    lastRobTime = currentTime
                end
            end
        else
            if robConnection then
                robConnection:Disconnect()
            end
        end
    end)
end

-- Setup rob corpses
pcall(setupRobCorpses)

-- Rob Corpses Toggle in Player Tab
PlayerTab:CreateToggle({
    Name = "Free Rob Corpses",
    CurrentValue = false,
    Callback = function(Value)
        robCorpsesConfig.enabled = Value
    end,
})

-- Rob Distance Slider in Player Tab
PlayerTab:CreateSlider({
    Name = "Rob Distance",
    Range = {10, 200},
    Increment = 10,
    Suffix = "Studs",
    CurrentValue = 50,
    Callback = function(Value)
        robCorpsesConfig.robDistance = Value
    end,
})

-- Rob Delay Slider in Player Tab
PlayerTab:CreateSlider({
    Name = "Rob Delay",
    Range = {0.1, 2},
    Increment = 0.1,
    Suffix = "Seconds",
    CurrentValue = 0.5,
    Callback = function(Value)
        robCorpsesConfig.robDelay = Value
    end,
})

-- ESP Tab (still empty)