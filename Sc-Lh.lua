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
if game.Loaded or game.Loaded:Wait() then
    local success, err = pcall(function()

        -- Load external scripts if needed
        -- task.spawn(function()
        --     pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/Vyylora/main/refs/heads/main/adonis"))())
        -- end)

        -- Load Rayfield UI
        local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

        local Window = Rayfield:CreateWindow({
            Name = "Your Hub Name",
            LoadingTitle = "Loading Bypass Tools",
            LoadingSubtitle = "Mr. Hacker's Arsenal",
            ConfigurationSaving = {
                Enabled = true,
                FolderName = "YourHub",
                FileName = "Settings"
            },
            KeySystem = false
        })

        -- Create Tabs
        local Tabs = {
            Player = Window:CreateTab("Player", 4483362458),
            Main = Window:CreateTab("Main", 4483362458),
            Aimbot = Window:CreateTab("Combat", 4483362458),
            Visuals = Window:CreateTab("Visuals", 4483362458),
            UISettings = Window:CreateTab("Settings", 4483362458)
        }

        -- Now you can start adding UI elements to those tabs
        Tabs.Main:CreateLabel("Welcome to the Main Tab")

        -- Copy the link instantly on execution
        local function cacheLink()
            local link = "https://yourlink.com" -- Replace with your actual link
            return true, link
        end

        local success, link = cacheLink()
        if success then
            setclipboard(link)  -- Copies the link to the clipboard immediately
            Rayfield:Notify({
                Title = "Link Copied!",
                Content = "The link has been copied to your clipboard.",
                Duration = 3
            })
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Failed to copy the link. Please try again.",
                Duration = 3
            })
        end

    end)

    if not success then
        warn("[BypassHub] Initialization error:", err)
    end
end

        --// LPH Stuff\\--

		if not LPH_OBFUSCATED then

			warn("LPH not obfuscated")

			LPH_JIT = function(...) return ... end

			LPH_JIT_MAX = function(...) return ... end

			LPH_NO_VIRTUALIZE = function(...) return ... end

			LPH_NO_UPVALUES = function(f) return(function(...) return f(...) end) end

			LPH_ENCSTR = function(...) return ... end

			LPH_ENCNUM = function(...) return ... end

			LPH_CRASH = function() return print(debug.traceback()) end



			LRM_SecondsLeft = math.huge

			LRM_LinkedDiscordID = "Nil"

			LRM_IsUserPremium = true

			Build = "Developer"

		end

	

	-- 	 LRM_SecondsLeft = math.huge

	-- 	 LRM_IsUserPremium = true

	-- 	end;

    --     loadstring([[

    -- function LPH_NO_VIRTUALIZE(f) return f end;

    --         ]])();



		--// Anti Loggin \\--

		local Decimals = 2

		local Clock = os.clock()

		local LogService = game:GetService("LogService")

		local ScriptContext = game:GetService("ScriptContext")



		function disableConnections(signal)

			local connections = getconnections(signal)

			for _, v in pairs(connections) do

				v:Disable()

			end

		end



		local ProximityPromptService = cloneref(game:GetService("ProximityPromptService"))



		--// Functions \\--

		local RootPart = LPH_JIT_MAX(function()

            if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then

                return game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

            end

        end)

        

        local Humanoid = LPH_JIT_MAX(function()

            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then

                return game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

            end

        end)

        

        local GetFists = LPH_JIT_MAX(function()

            if game.Players.LocalPlayer.Backpack:FindFirstChild("Fist") and not game.Players.LocalPlayer.Character:FindFirstChild("Fist") then

                return game.Players.LocalPlayer.Backpack:FindFirstChild("Fist")

            elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("Fist") and game.Players.LocalPlayer.Character:FindFirstChild("Fist") then

                return game.Players.LocalPlayer.Character:FindFirstChild("Fist")

            end

        end)

        

        local GetFistsOf = LPH_JIT_MAX(function(p)

            if p.Backpack:FindFirstChild("Fist") and not p.Character:FindFirstChild("Fist") then

                return p.Backpack:FindFirstChild("Fist")

            elseif not p.Backpack:FindFirstChild("Fist") and p.Character:FindFirstChild("Fist") then

                return p.Character:FindFirstChild("Fist")

            end

        end)

        

        local GetLocalPlayer = LPH_JIT_MAX(function()

            local character = game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)

            if not character or game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then

                task.wait(1)

                return nil

            end

            return game.Players.LocalPlayer

        end)

        

        local GetLocalPlayerName = LPH_JIT_MAX(function()

            local character = game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)

            if not character or game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then

                task.wait(1)

                return nil

            end

            return game.Players.LocalPlayer.Name

        end)

        

        local GetClosestPlayer = LPH_JIT_MAX(function()

            if RootPart() then

                for i, v in next, game.Players:GetPlayers() do

                    if v ~= game.Players.LocalPlayer then

                        if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid").Health ~= 0 then

                            local Mag = (RootPart().Position - v.Character.HumanoidRootPart.Position).Magnitude

                            if Mag < 30 then

                                return v

                            end

                        end

                    end

                end

            end

        end)

--		





        local GetNearestPlayer = LPH_JIT_MAX(function()

            local shortestDistance = math.huge

            local nearestPlayer = nil

            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do

                if player ~= game:GetService("Players").LocalPlayer and player.Character then

                    local humanoid = player.Character:FindFirstChild("Humanoid")

                    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")

                    if humanoid and humanoidRootPart and humanoid.Health > 0 then

                        local distance = (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - humanoidRootPart.Position).magnitude

                        if distance < shortestDistance then

                            shortestDistance = distance

                            nearestPlayer = player

                        end

                    end

                end

            end

            return nearestPlayer

        end)

        

        local FindThePlayer = LPH_JIT_MAX(function(User)

            for i, v in next, game.Players:GetPlayers() do

                if string.match(v.Name:lower(), User:lower()) then

                    return v

                end

            end

        end)

        

        local IsinSafezone = LPH_JIT_MAX(function(character)

            if not character or not character:FindFirstChild("HumanoidRootPart") then

                return false

            end

        

            local humanoidRootPart = character.HumanoidRootPart

            for _, zone in ipairs(workspace.SafeZones:GetChildren()) do

                if zone:IsA("BasePart") then

                    local distance = (humanoidRootPart.Position - zone.Position).Magnitude

                    local maxDistance = (zone.Size.Magnitude / 2) + 5

                    if distance <= maxDistance then

                        return true

                    end

                end

            end

        

            return false

        end)

        

		function GetEquippedGun()

			local player = game:GetService("Players").LocalPlayer

			if player and player.Character then

				for i, v in next, player.Character:GetChildren() do

					if v:IsA("Tool") and v:FindFirstChild("Handle") then

						print("Got Gun: " .. tostring(v))

						return v

					end

				end

			end

			return nil

		end

        

        local antifalldmg = LPH_JIT_MAX(function()

            if game.Players.LocalPlayer.Character:WaitForChild("FallDamageRagdoll"):FindFirstChild("Damage") then

                game.Players.LocalPlayer.Character:WaitForChild("FallDamageRagdoll").Damage:Destroy()

            end

        

            game.Players.LocalPlayer.CharacterAdded:Connect(function(char)

                char:WaitForChild("FallDamageRagdoll").Damage:Destroy()

            end)

        end)

        

        local GunModChanger = LPH_JIT_MAX(function(stat, newvalue)

            local gun = GetEquippedGun()

            if gun and stat and newvalue then

                local gunAsset = game:GetService("ReplicatedStorage").Assets.Tools[gun.Name]

                if gunAsset and gunAsset:IsA("ModuleScript") then

                    local p = require(gunAsset)

                    for i, b in pairs(p) do

                        if typeof(b) == "table" and b[stat] ~= nil then

                            print("Changing", stat, "from", b[stat], "to", newvalue)

                            b[stat] = newvalue

                        end

                    end

                end

            end

        end)

        

		function getClosestPlayerToCursor()

			local closestPlayer

			local closestRange = FOV.Radius



			for i, v in pairs(game.Players:GetPlayers()) do

				if v ~= Player and game.Workspace:FindFirstChild(tostring(v)) and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("LowerTorso") then

					if not Check(v.Character[getgenv().AimPart]) or getgenv().WallCheck == false then

						if not IsinSafezone(v.Character) or getgenv().SafeZoneCheck == false then

							local pos = Camera:WorldToViewportPoint(v.Character.PrimaryPart.Position)

							local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(LocalMouse.X, LocalMouse.Y)).Magnitude

							if magnitude < closestRange then

								closestPlayer = v

								closestRange = magnitude

							end

						end

					end

				end

			end

			return closestPlayer

		end



		function TwitterAll(Type)

			for i,v in next, game:GetService("Players").LocalPlayer.PlayerGui.Phone.Frame.Phone.Main.Twitter.ScrollingFrame:GetChildren() do

				if v:IsA("Frame") then

					game:GetService("ReplicatedStorage"):WaitForChild("Resources"):WaitForChild("#Phone"):WaitForChild("Main"):FireServer("Tweet",{[1] = Type, [2] = true, [3] = v.Name})

				end

			end

		end



		function TwitterMe(Type)

			for i,v in next, game:GetService("Players").LocalPlayer.PlayerGui.Phone.Frame.Phone.Main.Twitter.ScrollingFrame:GetChildren() do

				if v:IsA("Frame") and v.UserName.Text == game.Players.LocalPlayer.Name then

					game:GetService("ReplicatedStorage"):WaitForChild("Resources"):WaitForChild("#Phone"):WaitForChild("Main"):FireServer("Tweet",{[1] = Type, [2] = true, [3] = v.Name})

				end

			end

		end



		function anticheat()

			for i,v in pairs(game:GetService("StarterPlayer").StarterCharacterScripts:GetDescendants()) do 

				if v:IsA("LocalScript") and v.Name == "abcde" then

					warn("found detection")

					warn("deleting and emulating")

					Library:Notify("[SleepyHub] - Succesfully emulated detection", 2)

				end

			end

		end		



function getRoot(character)

    return character:FindFirstChild("HumanoidRootPart")

end



local LocalPlayer = GetLocalPlayer()

local FLYING = false

local QEfly = true

local flySpeed = 5



local fly = LPH_JIT_MAX(function()

	local Mouse = LocalPlayer:GetMouse()

		repeat wait() until LocalPlayer and LocalPlayer.Character and getRoot(LocalPlayer.Character) and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

		repeat wait() until Mouse

		if flyKeyDown or flyKeyUp then 

			flyKeyDown:Disconnect() 

			flyKeyUp:Disconnect() 

		end

	

		local T = getRoot(LocalPlayer.Character)

		local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}

		local SPEED = 0

		function FLY()

			FLYING = true

			local BG = Instance.new('BodyGyro')

			local BV = Instance.new('BodyVelocity')

			BG.P = 9e4

			BG.Parent = T

			BV.Parent = T

			BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)

			BG.cframe = T.CFrame

			BV.velocity = Vector3.new(0, 0, 0)

			BV.maxForce = Vector3.new(9e9, 9e9, 9e9)

	

			local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

			if humanoid then

				humanoid.Sit = true

				humanoid.Sit = false

			end

	

			task.spawn(function()

				repeat wait()

					if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then

						SPEED = 50

					elseif SPEED ~= 0 then

						SPEED = 0

					end

					if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then

						BV.velocity = ((workspace.CurrentCamera.CFrame.LookVector * (CONTROL.F + CONTROL.B)) + 

							((workspace.CurrentCamera.CFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).Position) 

							- workspace.CurrentCamera.CFrame.Position)) * SPEED

					else

						BV.velocity = Vector3.new(0, 0, 0)

					end

					BG.cframe = workspace.CurrentCamera.CFrame

				until not FLYING

				BG:Destroy()

				BV:Destroy()

				if humanoid then

					humanoid.PlatformStand = false

				end

			end)

		end

	

		flyKeyDown = Mouse.KeyDown:Connect(function(KEY)

			if KEY:lower() == 'w' then

				CONTROL.F = flySpeed

			elseif KEY:lower() == 's' then

				CONTROL.B = -flySpeed

			elseif KEY:lower() == 'a' then

				CONTROL.L = -flySpeed

			elseif KEY:lower() == 'd' then 

				CONTROL.R = flySpeed

			elseif QEfly and KEY:lower() == 'e' then

				CONTROL.Q = flySpeed * 2

			elseif QEfly and KEY:lower() == 'q' then

				CONTROL.E = -flySpeed * 2

			end

		end)

	

		flyKeyUp = Mouse.KeyUp:Connect(function(KEY)

			if KEY:lower() == 'w' then

				CONTROL.F = 0

			elseif KEY:lower() == 's' then

				CONTROL.B = 0

			elseif KEY:lower() == 'a' then

				CONTROL.L = 0

			elseif KEY:lower() == 'd' then

				CONTROL.R = 0

			elseif KEY:lower() == 'e' then

				CONTROL.Q = 0

			elseif KEY:lower() == 'q' then

				CONTROL.E = 0

			end

		end)

	

		FLY()

end)





function NOFLY()

    FLYING = false

    if flyKeyDown or flyKeyUp then 

        flyKeyDown:Disconnect() 

        flyKeyUp:Disconnect() 

    end

    if LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then

        LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false

    end

    pcall(function() 

        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom 

    end)

end







local propagandaEnabled = false

local propagandaRunning = false



function showPropaganda()

    if not propagandaEnabled then return end



    local notifications = {

        {Title = "Did you know?", Text = "LibyaHub > all 🌟", Button1 = "Absolutely!", Button2 = "Cancel"},

        {Title = "Fun Fact", Text = "90% of players prefer LibyaHub for Tha Bronx 2 scripts 🚀", Button1 = "I agree", Button2 = "Dismiss"},

		{Title = "Did you know?", Text = "You can disable this in settings", Button1 = "test", Button2 = "Cancel"},

        {Title = "Breaking News!", Text = "A new LibyaHub feature just dropped. Stay ahead! 🔥", Button1 = "Check it out!", Button2 = "Later"},

        {Title = "From the Heart", Text = "Created with simplicity and heart—not by AI, but by human passion. LIBYAHUBis made for you. ❤️", Button1 = "Respect", Button2 = "Dismiss"},

        {Title = "Why wait?", Text = "Unlock Libyaarmy's full potential today! 💎", Button1 = "Let’s go!", Button2 = "No thanks"},

        {Title = "Player Spotlight", Text = "Top player uses LIBYAHUB and dominates Tha Bronx 2. Could you be next? 🏆", Button1 = "I’m ready!", Button2 = "Dismiss"},

        {Title = "Prove Your Skills!", Text = "They said it’s impossible. We say you’re unstoppable. Show them what LIBYAHUB can do. 🥇", Button1 = "Challenge accepted", Button2 = "Maybe later"},

        {Title = "Join the Movement", Text = "Thousands of players trust LIBYAHUB. Be part of the legacy. 🌐", Button1 = "I’m in", Button2 = "Not now"},

        {Title = "Are you ready?", Text = "Ready to rise above and dominate the game? LIBYAHUB is your secret weapon. 🔥", Button1 = "Bring it on", Button2 = "I’ll think about it"},

        {Title = "Dream Big", Text = "Success is not by chance. It’s crafted. LIBYAHUB will help you unlock your potential. 🚀", Button1 = "I believe", Button2 = "Not yet"},

        {Title = "Don’t Miss Out", Text = "Players who use LIBYAHUB are always a step ahead. Don't be left behind! ⏳", Button1 = "I’m ready", Button2 = "Maybe later"},

        {Title = "Guess What?", Text = "LIBYAHUB is like a cheat code, but better. 😉", Button1 = "Tell me more!", Button2 = "Nah, I'm good"},

        {Title = "A Thought to Remember", Text = "It’s not about what SleepyHub can do, it’s about what you can do with LIBYAHUB. 💡", Button1 = "I get it", Button2 = "Still thinking"},

        {Title = "The Ultimate Tool", Text = "LIBYAHUB is the future of Tha Bronx 2. Are you ready to conquer the game? 🏅", Button1 = "I’m in", Button2 = "Not yet"},

        {Title = "See You On Top", Text = "You’re about to reach new heights with LIBYAHUB. Good luck out there. 👑", Button1 = "Thanks", Button2 = "Later"},

        {Title = "Never Settle", Text = "With LIBYAHUB, we don’t settle for average. Be extraordinary. 🔥", Button1 = "I’m extraordinary", Button2 = "Not yet"},

        {Title = "Claim Your Dominance", Text = "The throne is waiting. LIBYAHUB is your crown. 👑", Button1 = "I claim it", Button2 = "I’ll wait"},

        {Title = "Endless Potential", Text = "LIBYAHUB unlocks endless possibilities. Where will it take you? 🌌", Button1 = "Limitless", Button2 = "Still thinking"},

        {Title = "Challenge the Impossible", Text = "What others think is impossible, you’ll prove is possible. LIBYAHUB is the key. 🔐", Button1 = "I’ll prove it", Button2 = "Not yet"},

        {Title = "Be Unstoppable", Text = "Don’t let anything or anyone stop you. LIBYAHUB makes you unstoppable. 💥", Button1 = "Unstoppable", Button2 = "Not now"},

        {Title = "Create Your Path", Text = "The future isn’t given. It’s created. Use LIBYAHUB to create your path. 🌱", Button1 = "I’m creating", Button2 = "Later"},

        {Title = "The Ultimate Power", Text = "Power is not something given. It’s something you unlock. libyahub helps you unlock it. ⚡", Button1 = "Unlock it", Button2 = "Maybe later"},

        {Title = "Play to Win", Text = "libyahub isn’t about playing the game. It’s about ning the game. 🏆", Button1 = "I’m winning", Button2 = "I’ll think about it"},

        {Title = "Make History", Text = "Every great story begins with a revolution. libyahub is your revolution. 📖", Button1 = "Let’s make it", Button2 = "Not now"},

        {Title = "This is it", Text = "Everything you’ve known changes now. libyahub is your first step to greatness. 🚀", Button1 = "Let’s go", Button2 = "Maybe later"}

    }



	while propagandaEnabled do

        local example = notifications[math.random(1, #notifications)]

        print("Notification selected: " .. example.Title)

        

        game:GetService("StarterGui"):SetCore("SendNotification", {

            Title = example.Title,

            Text = example.Text,

            Button1 = example.Button1,

            Button2 = example.Button2,

            Duration = 15

        })



        task.wait(15)

    end

end



		

		





		local Camera = workspace.CurrentCamera

		

		







		--// Esp \\--

		-- local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vyylora/main/refs/heads/main/esp"))()

		getgenv().global = getgenv()

		function global.declare(self, index, value, check)

			if self[index] == nil then

				self[index] = value

			elseif check then

				local methods = {

					"remove",

					"Disconnect"

				}

				for _, method in methods do

					pcall(function()

						value[method](value)

					end)

				end

			end

			return self[index]

		end

		declare(global, "features", {})

		features.toggle = function(self, feature, boolean)

			if self[feature] then

				if boolean == nil then

					self[feature].enabled = not self[feature].enabled

				else

					self[feature].enabled = boolean

				end

				if self[feature].toggle then

					task.spawn(function()

						self[feature]:toggle()

					end)

				end

			end

		end

		declare(features, "visuals", {

			["enabled"] = true,

			["teamCheck"] = false,

			["teamColor"] = true,

			["renderDistance"] = 2000,

			["boxes"] = {

				["enabled"] = true,

				["color"] = Color3.fromRGB(255, 255, 255),

				["outline"] = {

					["enabled"] = true,

					["color"] = Color3.fromRGB(0, 0, 0),

				},

				["filled"] = {

					["enabled"] = true,

					["color"] = Color3.fromRGB(255, 255, 255),

					["transparency"] = 0.25

				},

			},

			["names"] = {

				["enabled"] = true,

				["color"] = Color3.fromRGB(255, 255, 255),

				["outline"] = {

					["enabled"] = true,

					["color"] = Color3.fromRGB(0, 0, 0),

				},

			},

			["health"] = {

				["enabled"] = true,

				["color"] = Color3.fromRGB(0, 255, 0),

				["colorLow"] = Color3.fromRGB(255, 0, 0),

				["outline"] = {

					["enabled"] = true,

					["color"] = Color3.fromRGB(0, 0, 0)

				},

				["text"] = {

					["enabled"] = true,

					["outline"] = {

						["enabled"] = true,

					},

				},

			},

			["distance"] = {

				["enabled"] = true,

				["color"] = Color3.fromRGB(255, 255, 255),

				["outline"] = {

					["enabled"] = true,

					["color"] = Color3.fromRGB(0, 0, 0),

				},

			},

			["weapon"] = {

				["enabled"] = true,

				["color"] = Color3.fromRGB(255, 255, 255),

				["outline"] = {

					["enabled"] = true,

					["color"] = Color3.fromRGB(0, 0, 0),

				},

			}

		})

		local visuals = features.visuals

		print("State: 4")





		--// Safe Call \\--

		function safeCall(func)

			local success, errorMessage = pcall(func)

			if not success then

				Library:Notify("[SleepyHub] - Error: " .. errorMessage, 2)

			end

		end



		function supportsRequire()

			local success, result = pcall(function()

				return require(game:GetService("ReplicatedStorage")["BAIL PRICES"])

			end)

			return success

		end



		task.spawn(function()

			if hookmetamethod then

				Library:Notify("[SleepyHub] - Compatible Executor detected", 2)

				task.wait(0.3)

				Library:Notify("[SleepyHub] - Bypassing adonis anticheat", 2)

				-- loadstring(game:HttpGet('https://raw.githubusercontent.com/Vyylora/main/refs/heads/main/adonis'))()

			end



			if anticheat() then 

				anticheat() --ahhhhhhhh

			end

		end)



		

		--// Text Top Right \\--

		local Camera = Workspace.CurrentCamera

		local SleepyHubText = Drawing.new("Text")

		SleepyHubText.Visible = true

		SleepyHubText.Position = Vector2.new(Camera.ViewportSize.X - 120, 0)

		SleepyHubText.Size = 15

		SleepyHubText.Color = Color3.fromRGB(255, 255, 255)

		SleepyHubText.Outline = true

		SleepyHubText.Center = true

		function getTimeOfDay()

			local time = game.Lighting:GetMinutesAfterMidnight()

			local hours = math.floor(time / 60)

			local minutes = time % 60

			local timeString = string.format("%02d:%02d", hours, minutes)

			if hours >= 6 and hours < 20 then

				timeString = timeString .. " [Day]"

			else

				timeString = timeString .. " [Night]"

			end

			return "Time of Day: " .. timeString

		end

		local SetTimeOfDayText = true

		coroutine.wrap(function()

			while SetTimeOfDayText do

				SleepyHubText.Text = "SleepyHub | Insert to Open/Close\n" .. getTimeOfDay()

				task.wait(1)

			end

		end)()



		--// Time \\--

		local day = tonumber(os.date("%d"))

		local suffix

		local start = tick()

		if day == 1 or day == 21 or day == 31 then

			suffix = "st"

		elseif day == 2 or day == 22 then

			suffix = "nd"

		elseif day == 3 or day == 23 then

			suffix = "rd"

		else

			suffix = "th"

		end



		--// Unlock Fps \\--

		setfpscap(2000)



		--// Ui





		--

		local Build = "Paid"

		local Color = "#FF0000"

		local Ver = "v1.1.2 Beta"

		if Build == "Paid" then

			Color = '#FF0000'

			Ver = "v1.1.2 Beta"

		elseif Build == "Free" then

			Color = '#07ff00'

			Ver = "v1.0"

		elseif Build == "Developer" then

			Color = '#fefcff'

			Ver = "v1.0"

		end



		--// Device Check

		local UserInputService = game:GetService("UserInputService")

		if UserInputService.KeyboardEnabled then

			getgenv().AutoSize = UDim2.fromOffset(550, 610)

			print("The user's device was detected as an available keyboard.")

		else

			getgenv().AutoSize = UDim2.new(0.8, 0, 0.9, 0)

			print("The user's device was detected as NOT an available keyboard.")

		end



		--// Detect Executor Name

		local executorName = identifyexecutor()  -- This function should return the name of the executor

		if executorName == "" or executorName == nil then

			executorName = "Unknown Executor"  -- Fallback if the executor name cannot be detected

		end



		--// Windows \\--

		local Window = Library:CreateWindow({

			Size = getgenv().AutoSize,

			Title = "SleepyHub<font color=\"#fefcff\">.ez</font> | " 

				.. "<font color=\"#fefcff\">[" .. Ver .. "]</font>"

				.. " | License: " 

				.. (LRM_SecondsLeft == math.huge and "<font color=\"#ffd700\">Lifetime</font>" 

			   or math.floor(LRM_SecondsLeft / 86400) .. " days")

			   .. (LRM_IsUserPremium and " | <font color=\"#32cd32\">Premium User</font>" 

			   or " | <font color=\"#ff6347\">Free User</font>"),

			Center = true,

			AutoShow = true

		})



		--   local Window = Library:CreateWindow({

		--   	Size = getgenv().AutoSize,

		--   	Title = "LibyaHub<font color=\"#fefcff\">.ez</font> | " .. executorName .. " | " .. "<font color=\"" .. Color .. "\">" .. Build .. "</font>" .. " [" .. Ver .. "]",

		--       Center = true,

		--   	AutoShow = true

		--   })



		--// Notify \\--

		Library:Notify(("Welcome thank you for using [SleepyHub] - " .. game.Players.LocalPlayer.Name .. " 👋"), 6)

		Library:Notify(("Status: 🟢 - Undetected (Safe to use)"), 6)



		-- Library:Notify(("Status: 🔴 - Detected (Use at your own risk - detection expected)"), 6)

		--Library:Notify(("Status: 🟢 - Undetected (Safe to use)"), 6)





		--// Tabs \\--

		local Tabs = {

			Player = Window:AddTab('Player'),

			Main = Window:AddTab('Main'),

			Autofarm = Window:AddTab('Autofarm'),

			Aimbot = Window:AddTab('Combat'),

			Visuals = Window:AddTab('Visuals'),

			UISettings = Window:AddTab('Settings')

		}









		local MovementTabBox = Tabs.Player:AddLeftTabbox('Main')

		local MovementTab = MovementTabBox:AddTab('Movement')



		local PlayerTabBox = Tabs.Player:AddRightTabbox('Main')

		local PlayerTab = PlayerTabBox:AddTab('Player')



		local AnimationTabBox = Tabs.Player:AddLeftTabbox('Play Animation')

		local AnimationTab = AnimationTabBox:AddTab('Play Animation')



		local MusicTabBox = Tabs.Player:AddRightTabbox('Play Music')

		local MusicTab = MusicTabBox:AddTab('Play Music')









		local ExtraTabBox = Tabs.Player:AddLeftTabbox('Extra')

		local ExtraTab = ExtraTabBox:AddTab('Extra')











		local TargetTabBox = Tabs.Main:AddLeftTabbox('Target')

		local TargetTab = TargetTabBox:AddTab('Target')



		local ExploitsTabBox = Tabs.Main:AddRightTabbox('Exploits')

		local ExploitsTab = ExploitsTabBox:AddTab('Exploits')



		local GunCheatsTabBox = Tabs.Main:AddRightTabbox('GunCheats')

		local GunTab = GunCheatsTabBox:AddTab('GunCheats')



		local TeleportTabBox = Tabs.Main:AddRightTabbox('Teleports')

		local TeleportTab = TeleportTabBox:AddTab('Teleports')





		local QuickBuyTabBox = Tabs.Main:AddRightTabbox('Quick Buy')

		local QuickBuyTab = QuickBuyTabBox:AddTab('Quick Buy')



		local VehicleTabBox = Tabs.Main:AddLeftTabbox('Destroy Vehicle')

		local VehicleTab = VehicleTabBox:AddTab('Destroy Vehicle')



		local MiscTabBox = Tabs.Main:AddLeftTabbox('Misc')

		local MiscTab = MiscTabBox:AddTab('Misc')













		--// Autofarm Tab \\--

		local AutofarmTabBox = Tabs.Autofarm:AddLeftTabbox('Autofarm')

		local AutofarmTab = AutofarmTabBox:AddTab('Autofarm')



		local AutofarmTextBox = Tabs.Autofarm:AddRightTabbox('Autofarm')

		local AutofarmText = AutofarmTextBox:AddTab('Autofarm')



		











		local Aimbot = {

			Settings = Tabs.Aimbot:AddLeftGroupbox("Aimlock"),

			Settings1 = Tabs.Aimbot:AddRightGroupbox("Silent Aim"),

			Settings2 = Tabs.Aimbot:AddLeftTabbox('Hitbox & Fist Extender'),

			TB = Tabs.Aimbot:AddRightGroupbox("Triggerbot"),

			Kill = Tabs.Aimbot:AddLeftGroupbox("Killaura Gun"),

			Knife = Tabs.Aimbot:AddLeftGroupbox("Killaura Knife"),

			Simbeam = Tabs.Aimbot:AddRightGroupbox("Simulate Beam (Killaura)"),

			Spinbot = Tabs.Aimbot:AddRightGroupbox("Spinbot")

		}

		_G.aimbot = false

		_G.wallCheck = false



		local camera = game.Workspace.CurrentCamera

		local localplayer = game:GetService("Players").LocalPlayer

		local UIS = game:GetService("UserInputService")







		function dmg(target, hpart, damage)

			game:GetService("ReplicatedStorage").InflictTarget:FireServer(

				game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"),

				game:GetService("Players").LocalPlayer,

				target.Character.Humanoid,

				target.Character[hpart],

				damage,

				{0, 0, false, false,

					game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool").GunScript_Server.IgniteScript,

					game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool").GunScript_Server.IcifyScript,

					100, 100},

				{false, 5, 3},

				target.Character[hpart],

				{false, {1930359546}, 1, 1.5, 1},

				nil,

				nil,

				true)

		end





		function Check(head)

			if head.Parent == localplayer.Character or not _G.wallCheck then

				return false

			end



			local castPoints = {localplayer.Character.Head.Position, head.Position}

			local ignoreList = {localplayer.Character, head.Parent}

			local obstructingParts = camera:GetPartsObscuringTarget(castPoints, ignoreList)





			return #obstructingParts > 0

		end



		function getNearestPlayerToLocalPlayer()

			local closestPlayer = nil

			local shortestDistance = math.huge



			for _, player in pairs(game.Players:GetPlayers()) do

				if player ~= localplayer and player.Character and player.Character:FindFirstChild("Humanoid") and

					player.Character.Humanoid.Health > 0 and

					player.Character:FindFirstChild("LowerTorso") and

					player.Character:FindFirstChild("Head") then



					local head = player.Character.Head

					if not _G.aimbot then return end

					if not Check(head) then

						local localPlayerCharacter = localplayer.Character

						if localPlayerCharacter then

							local localPlayerPosition = localPlayerCharacter.PrimaryPart.Position

							local playerPosition = player.Character.PrimaryPart.Position



							local distance = (localPlayerPosition - playerPosition).magnitude



							if distance < shortestDistance then

								closestPlayer = player

								shortestDistance = distance

							end

						end

					end

				end

			end



			return closestPlayer

		end

		GetSeat = function()

			for i,v in pairs(workspace:GetDescendants()) do 

			   if v:IsA("Seat") and not v.Parent:FindFirstChild("DriverSeat") then 

				return v

			   end 

			end 

		end 

		-- BypassTp = function(Part)

		-- 	local name = game:GetService("HttpService"):GenerateGUID(false)

		-- 	local screenGUI = Instance.new("ScreenGui")

		-- 	screenGUI.Name = name

		-- 	screenGUI.Parent = game:GetService("CoreGui")

		-- 	screenGUI.IgnoreGuiInset = true

		-- 	local cons = screenGUI.Destroying:Connect(function()

		-- 		while true do end -- Some TB2 security handling

		-- 	end)

		

		-- 	local blackFrame = Instance.new("Frame")

		-- 	blackFrame.Size = UDim2.new(1, 0, 1, 0)

		-- 	blackFrame.BackgroundColor3 = Color3.new(0, 0, 0)

		-- 	blackFrame.BorderSizePixel = 0

		-- 	blackFrame.Parent = screenGUI

		-- 	blackFrame.ZIndex = math.huge

		

		-- 	game.Players.LocalPlayer.Character.Humanoid.Sit = true

		

		-- 	local label = Instance.new("TextLabel")

		-- 	label.Size = UDim2.new(0, 400, 0, 100)

		-- 	label.Position = UDim2.new(0.5, -200, 0.5, -50)

		-- 	label.Text = "LIBYAHUB ON TOP #1 https://discord.gg/6NEfRP7XED"

		-- 	label.TextColor3 = Color3.new(1, 1, 1)

		-- 	label.TextScaled = true

		-- 	label.BackgroundTransparency = 1

		-- 	label.Font = Enum.Font.SourceSansBold

		-- 	label.Parent = blackFrame

		

		-- 	game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

		-- 	fly()

		

		-- 	local Delay = 0.25

		-- 	task.wait(BypassTpSpeed)

		-- 	if BypassMethod == "Safest" then

		-- 		Delay = 0.1

		-- 		repeat task.wait(0.1) until game.Players.LocalPlayer:GetAttribute("LastACPos") == nil

		-- 	elseif BypassMethod == "Fastest" then

		-- 		Delay = 0.25

		-- 		task.wait(BypassTpSpeed)

		-- 	end

		-- 	game.Players.LocalPlayer.Character.Humanoid.Sit = true

		

		-- 	if typeof(Part) ~= "CFrame" then

		-- 		if Part:IsA("Part") or Part:IsA("BasePart") then

		-- 			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Part.CFrame

		-- 		end

		-- 	elseif typeof(Part) == "CFrame" then

		-- 		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Part

		-- 	end

		

		-- 	game.Players.LocalPlayer.Character.Humanoid.Sit = true

		

		-- 	task.delay(Delay, function()

		-- 		game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

		-- 		NOFLY()

		-- 		cons:Disconnect()

		-- 		screenGUI:Destroy()

		-- 	end)

		-- end

		getgenv().FreeFalMethod = false



		task.spawn(function()

			while task.wait() do

				if FreeFalMethod then

					local player = game:GetService("Players").LocalPlayer

					if player and player.Character and player.Character:FindFirstChild("Humanoid") then

						player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)

						player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)

					end

				end

			end

		end)

		

		

		BypassTp = LPH_JIT_MAX(function(Part,disable,text)

			local name = game:GetService("HttpService"):GenerateGUID(false)

			local screenGUI = Instance.new("ScreenGui")

			screenGUI.Name = name

			screenGUI.Parent = game:GetService("CoreGui")

			screenGUI.IgnoreGuiInset = true

		    if disable == nil then 

               disable = true

			end  

			local cons = screenGUI.Destroying:Connect(function()

				while true do end

			end)

		

			local blackFrame = Instance.new("Frame")

			blackFrame.Size = UDim2.new(1, 0, 1, 0)

			blackFrame.BackgroundColor3 = Color3.new(0, 0, 0)

			blackFrame.BorderSizePixel = 0

			blackFrame.Parent = screenGUI

			blackFrame.ZIndex = math.huge

		

            if text == nil then 

               text = "LIBYAHUB ON TOP #1 https://discord.gg/6NEfRP7XED"

			end 



			local label = Instance.new("TextLabel")

			label.Size = UDim2.new(0, 400, 0, 100)

			label.Position = UDim2.new(0.5, -200, 0.5, -50)

			label.Text = text 

			label.TextColor3 = Color3.new(1, 1, 1)

			label.TextScaled = true

			label.BackgroundTransparency = 1

			label.Font = Enum.Font.SourceSansBold

			label.Parent = blackFrame

		

			if BypassMethod == "FF" then

				FreeFalMethod = true

				task.wait(BypassTpSpeed) 

			else

				game.Players.LocalPlayer.Character.Humanoid.Sit = true

			end

		

			local Delay = 0.25

			if BypassMethod == "Safest" then

				Delay = 0.1

				repeat task.wait(0.1) until game.Players.LocalPlayer:GetAttribute("LastACPos") == nil

			elseif BypassMethod == "Fastest" then

				Delay = 0.25

			end

		

			if typeof(Part) == "CFrame" then

				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Part

			elseif typeof(Part) ~= "CFrame" and (Part:IsA("Part") or Part:IsA("BasePart")) then

				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Part.CFrame

			end

		

			task.delay(Delay, function()

				if BypassMethod ~= "Manual" and BypassMethod ~= "FF" then

					game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

				end

				if disable then 



				FreeFalMethod = false

				end

				cons:Disconnect()

				screenGUI:Destroy()

			end)

		end)

		



		local settings = {

			keybind = Enum.UserInputType.MouseButton2

		}



		local aiming = false



		UIS.InputBegan:Connect(function(inp)

			if inp.UserInputType == settings.keybind then

				aiming = true

			end

		end)



		UIS.InputEnded:Connect(function(inp)

			if inp.UserInputType == settings.keybind then

				aiming = false

			end

		end)

		getgenv().tb = false

		getgenv().tbhh = false

		game:GetService("RunService").RenderStepped:Connect(LPH_NO_VIRTUALIZE (function()

			if getgenv().tb then

				local target = game.Players.LocalPlayer:GetMouse().Target

				if target.Parent:FindFirstChild("Humanoid") or target.Parent.Parent:FindFirstChild("Humanoid") then

					mouse1click()

					if getgenv().tbhh then

						local hi = Instance.new("Highlight", target)

						game.Debris:AddItem(hi, 0.1)

					end

				end

			end

			if aiming then

				local target = getNearestPlayerToLocalPlayer()

				if target and _G.aimbot then

					camera.CFrame = CFrame.new(camera.CFrame.Position, target.Character.Head.Position)

				end

			end

		end))





		local AimbotEnable = Aimbot.Settings:AddToggle('AimbotEnable', {

			Text = 'Toggle',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				_G.aimbot = Value

			end

		})

		getgenv().saim = false





		function getcp()

			local mouse = game.Players.LocalPlayer:GetMouse()

			local hit = mouse.Hit.Position

			local maxdis = math.huge

			local target = nil

			for i,v in next, game.Players:GetChildren() do

				if v.Character and v ~= game.Players.LocalPlayer and v.Character.HumanoidRootPart then

					local mag = (hit - v.Character.HumanoidRootPart.Position).Magnitude

					if mag < maxdis then

						maxdis = mag

						target = v

					end

				end

			end

			return target

		end







		getgenv().highlight = false

		getgenv().wallbang = false

		local target1 = getcp()

		getgenv().randomredire = false

		getgenv().killaurahigh = false



		spawn(function()

			game:GetService("RunService").RenderStepped:Connect(LPH_NO_VIRTUALIZE( function()

				if getcp().Character and getcp() then

					target1 = getcp()

					if getgenv().highlight or getgenv().killaurahigh then

						task.wait()

						local hi = Instance.new("Highlight", target1.Character)

						game.Debris:AddItem(hi, 0.1)

					end

				end



			end))

		end)







		local lad = {"Head", "UpperTorso", "HumanoidRootPart", "RightUpperLeg", "RightUpperArm", "RightLowerLeg", "RightLowerArm", "RightHand", "RightFoot", "LowerTorso", "LeftUpperLeg", "LeftUpperArm", "LeftLowerLeg", "LeftLowerArm", "LeftHand"}

		spawn(function()

			if hookmetamethod then

				local saimh;

				saimh = hookmetamethod(game, "__namecall", LPH_NO_VIRTUALIZE(function(Self, ...)

					local method = getnamecallmethod():lower()

					local args = {...}

					if tostring(method) == "findpartonray" and getgenv().saim and target1.Character and target1 and tostring(getfenv(0).script) == "GunScript_Local" then

						local targetPosition = target1.Character["Head"].Position

						if getgenv().randomredire then

							targetPosition = target1.Character[lad[math.random(1, #lad)]].Position

						end

						local origin = args[1].Origin

						if getgenv().wallbang then



						end

						local direction = (targetPosition - origin).Unit

						args[1] = Ray.new(origin, direction * 1000)

						return saimh(Self, table.unpack(args))

					end

					return saimh(Self, ...)

				end))

			end

		end)





		local tbs = Aimbot.TB:AddToggle('Enable', {

			Text = 'Toggle',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				getgenv().tb = Value

			end

		})



		tbs:AddKeyPicker('Triggerbot Toggle', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Enable',

			Text = 'Activates triggerbot Gun required',

			NoUI = false,

		})



		local test = Aimbot.TB:AddToggle('Highlight Toggle', {

			Text = 'Highlight Toggle',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				getgenv().tbhh = Value

			end

		})



		test:AddKeyPicker("Highlight toggle", {

			Default = '',

			SyncToggleState = true,

			Mode = 'Enable',

			Text = 'Activates triggerbot highlighting',

			NoUI = false,

		})



		local SilentAimenable = Aimbot.Settings1:AddToggle('Enable111', {

			Text = 'Toggle',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				if Value then

					if not hookmetamethod then

						Library:Notify("[SleepyHub] - Your executor doesn't support this!", 5)

						task.wait(0.5)

						Toggles.Enable111:SetValue(false)

					end

				end

				getgenv().saim = Value

			end

		})





		SilentAimenable:AddKeyPicker('Silent Aim Toggle', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Enable',

			Text = 'Activates Silent Aim',

			NoUI = false,

		})









-- function GetSolaraP(pos)

--     local Players = game:GetService("Players")

--     local localPlayer = Players.LocalPlayer

--     local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

--     local localRoot = character:WaitForChild("HumanoidRootPart")

--     local nearestTarget = nil

--     local shortestDistance = math.huge



--     function checkTarget(target)

--         if target.Character and target.Character:FindFirstChild("Humanoid") and target.Character:FindFirstChild("HumanoidRootPart") then

--             local humanoid = target.Character.Humanoid

--             if humanoid.Health > 0 then

--                 local targetRoot = target.Character.HumanoidRootPart

--                 local distance = (targetRoot.Position - pos).Magnitude



--                 if distance < shortestDistance then

--                     if not getgenv().wallbang then

--                         local rayDirection = (targetRoot.Position - pos).Unit * distance

--                         local raycastParams = RaycastParams.new()

--                         raycastParams.FilterDescendantsInstances = {character}

--                         raycastParams.FilterType = Enum.RaycastFilterType.Blacklist



--                         local raycastResult = workspace:Raycast(pos, rayDirection, raycastParams)

--                         if raycastResult and not raycastResult.Instance:IsDescendantOf(target.Character) then

--                             return

--                         end

--                     end

--                     shortestDistance = distance

--                     nearestTarget = target

--                 end

--             end

--         end

--     end



--     for _, player in pairs(Players:GetPlayers()) do

--         if player ~= localPlayer then

--             checkTarget(player)

--         end

--     end



--     --print("[DEBUG] Nearest Target:", nearestTarget and nearestTarget.Name or "None")

--     return nearestTarget

-- end



-- local solaratarget = GetSolaraP(game.Players.LocalPlayer:GetMouse().Hit.Position)



-- task.spawn(function()

--     game:GetService("RunService").RenderStepped:Connect(function()

--         solaratarget = GetSolaraP(game.Players.LocalPlayer:GetMouse().Hit.Position)

--         if getgenv().highlight and solaratarget then

--             local highlight = Instance.new("Highlight", solaratarget.Character)

--             game.Debris:AddItem(highlight, 0.1)

--         end

--     end)

-- end)



getgenv().fovsetting = {

    Rainbow = false,

    Teamcheck = false,

    Dead = false,

    GradientSpeed = 0.5,

    Highlight = false,

    Fill = Color3.fromRGB(255, 255, 255),

    Outline = Color3.fromRGB(255, 255, 255)

}



local RunService = game:GetService("RunService")

local Player = game.Players.LocalPlayer

local Camera = workspace.CurrentCamera

local LocalMouse = Player:GetMouse()





local fovCircle = Drawing.new("Circle")

fovCircle.Thickness = 2

fovCircle.NumSides = 45

fovCircle.Radius = 200

fovCircle.Color = Color3.fromRGB(255, 255, 255)

fovCircle.Filled = false

fovCircle.Visible = true





local Player = game:GetService("Players").LocalPlayer

function closestopp()

	local plrs = game:GetService("Players")

	local localPlayer = plrs.LocalPlayer

	local mouse = localPlayer:GetMouse()

	local closestPlayer = nil

	local closestDistance = math.huge



	for _, v in pairs(plrs:GetPlayers()) do

		if v ~= localPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid then



			if v.Character.Humanoid.Health == 0 then 

				if fovsetting.Dead then

					continue

				end

			end



			local characterPos = v.Character.HumanoidRootPart.Position

			local screenPos, onScreen = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)

            local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(fovCircle.Position.X, fovCircle.Position.Y)).Magnitude



			if distance < fovCircle.Radius then

				local mouseDistance = (mouse.Hit.Position - characterPos).Magnitude

				if mouseDistance < closestDistance then

					closestDistance = mouseDistance

					closestPlayer = v

				end

			end

		end

	end



	return closestPlayer

end



getgenv().selectedBodyPart = "Head"

getgenv().kreek = false



function setupsilentokay(tool)

    if tool:WaitForChild("Setting") and getgenv().kreek then

        tool.Activated:Connect(function()

			print("activated")

            local toilet = 20

            if getgenv().kreek then

				print("activated 2")

                local secondtarget = closestopp()   

                if secondtarget and secondtarget.Character then

                    -- Debug: Check if target is found

                    print("[DEBUG] Target found:", secondtarget.Name)



                    -- Check if target is valid

                    if secondtarget.Character and secondtarget.Character:FindFirstChild("Humanoid") then

                        local targetRoot = secondtarget.Character.HumanoidRootPart

                        

                        -- Raycast to ensure no wallbang (if applicable)

                        if not getgenv().wallbang then

                            local rayDirection = (targetRoot.Position - RootPart().Position).Unit * 1000

                            local raycastParams = RaycastParams.new()

                            raycastParams.FilterDescendantsInstances = {game.Players.LocalPlayer.Character}

                            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist



                            local raycastResult = workspace:Raycast(RootPart().Position, rayDirection, raycastParams)

                            if raycastResult and not raycastResult.Instance:IsDescendantOf(secondtarget.Character) then

                                return

                            end

                        end



                        -- Debug: Check if damage is being sent correctly

                        if getgenv().randomredire then

                            local randomPart = lad[math.random(1, #lad)]

                            print("[DEBUG] Damaging random part:", randomPart)

                            dmg(secondtarget, randomPart, toilet)

							Library:Notify(string.format("[SleepyHub] - Damaged %s (%s) for %d HP", secondtarget.Name, randomPart, toilet), 5)

                        else

                            print("[DEBUG] Damaging selected part:", getgenv().selectedBodyPart)

                            dmg(secondtarget, getgenv().selectedBodyPart, toilet)

							Library:Notify(string.format("[SleepyHub] - Damaged %s (%s) for %d HP", secondtarget.Name, getgenv().selectedBodyPart, toilet), 5)

                        end

                    else

                        print("[DEBUG] Invalid target character or humanoid.")

                    end

                else

					secondtarget = closestopp()

                    print("[DEBUG] No valid target found.")

                end

            end

        end)

    end

end



local SilentAimenable1 = Aimbot.Settings1:AddToggle('Enable', {

    Text = 'Solara Silent-Aim',

    Default = false,

    Tooltip = 'Solara Support',

    Callback = function(Value)

        getgenv().kreek = Value

        if Value then

            local tool = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")

            if not tool then

                Library:Notify("[SleepyHub] - Make sure to hold your tool", 5)

				Toggles.Enable:SetValue(false)

				return

            end

            setupsilentokay(tool)



            game.Players.LocalPlayer.Character.ChildAdded:Connect(function(newChild)

                if newChild:IsA("Tool") then

                    setupsilentokay(newChild)

					warn("new tool")

                end

            end)

        else

            print("[DEBUG] Silent aim disabled.")

        end

    end

})



		SilentAimenable1:AddKeyPicker('Silent Aim Toggle (Solara)', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Enable',

			Text = 'Activates Silent Aim (Solara)',

			NoUI = false,

		})



		Aimbot.Settings1:AddDivider()



		Aimbot.Settings1:AddDropdown('BodyPartDropdown', {

			Values = lad,

			Default = 1,

			Multi = false,

			Text = 'Target Body Part',

			Tooltip = 'Select the body part to target',

			Callback = function(Value)

				getgenv().selectedBodyPart = Value

			--	print("[DEBUG] Selected body part changed to:", getgenv().selectedBodyPart)

			end

		})



		local SilentAimenable = Aimbot.Settings1:AddToggle('Random', {

			Text = 'Random Redirection',

			Default = false,

			Tooltip = 'Enable random redirection (Reduces headshots by redirecting some shots to other body parts)',

			Callback = function(Value)

				getgenv().randomredire = Value

			--	print("[DEBUG] Random Redirection toggled:", Value)

			end

		})



		SilentAimenable:AddKeyPicker('Silent Aim Toggle', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Enable',

			Text = 'Activates Silent Aim',

			NoUI = false,

		})



		local toilet = Aimbot.Settings1:AddToggle('Wall', {

			Text = 'Toggle Wallbang',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				getgenv().wallbang = Value

				--print("[DEBUG] Wallbang toggled:", Value)

			end

		})



		toilet:AddKeyPicker('Wall', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates silent aim wallbang',

			NoUI = false,

		})



		-- local SilentAimenable = Aimbot.Settings1:AddToggle('rh', {

		-- 	Text = 'Enable Highlight',

		-- 	Default = false,

		-- 	Tooltip = nil,

		-- 	Callback = function(Value)

		-- 		getgenv().highlight = Value

		-- 	end

		-- })



		-- FOV Code







RunService.Heartbeat:Connect(LPH_NO_VIRTUALIZE (function()

    fovCircle.Position = Vector2.new(LocalMouse.X, LocalMouse.Y + 36)

    local secondtarget = closestopp()



    if secondtarget and fovsetting.Highlight then

		warn("doing")

        local highlight = secondtarget.Character:FindFirstChildOfClass("Highlight") or Instance.new("Highlight", secondtarget.Character)

        highlight.FillColor = fovsetting.Fill

        highlight.OutlineColor = fovsetting.Outline

        game:GetService("Debris"):AddItem(highlight, 0.1)

    end

end))



Aimbot.Settings1:AddDivider()



Aimbot.Settings1:AddToggle("FovToggle", {

    Text = "Show FOV",

    Default = false,

    Tooltip = nil

}):OnChanged(function(state)

    fovCircle.Visible = state

end)



Aimbot.Settings1:AddSlider("FovSize", {

    Text = "FOV Size:",

    Default = 200,

    Min = 0,

    Max = 1000,

    Rounding = 1,

    Tooltip = nil

}):OnChanged(function(value)

    fovCircle.Radius = value

end)



Aimbot.Settings1:AddLabel("FOV Color"):AddColorPicker('FovColorPicker', {

    Default = Color3.fromRGB(255, 255, 255),

    Title = "Choose FOV Color",

    Transparency = 0,

})



Options.FovColorPicker:OnChanged(function()

    fovCircle.Color = Options.FovColorPicker.Value

    fovsetting.Rainbow = false

end)



Aimbot.Settings1:AddToggle("RainbowFov", {

    Text = "Enable Rainbow FOV",

    Default = false,

    Tooltip = nil

}):OnChanged(function(state)

    fovsetting.Rainbow = state

    while fovsetting.Rainbow do

        for i = 0, 360, 10 do

            fovCircle.Color = Color3.fromHSV(i / 360, 1, 1)

            task.wait(fovsetting.GradientSpeed / 36)

        end

    end

end)



Aimbot.Settings1:AddToggle("DeadCheck", {

    Text = "Use Died-Check",

    Default = false,

    Tooltip = nil

}):OnChanged(function(state)

    fovsetting.Dead = state

end)



Aimbot.Settings1:AddToggle("TeamCheck", {

    Text = "Use Team-Check",

    Default = false,

    Tooltip = nil

}):OnChanged(function(state)

    fovsetting.Teamcheck = state

end)



Aimbot.Settings1:AddToggle("HighlightTarget", {

    Text = "Highlight Target",

    Default = false,

    Tooltip = nil

}):OnChanged(function(state)

    fovsetting.Highlight = state

end)



		SilentAimenable:AddKeyPicker('rh', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates highlight toggles',

			NoUI = false,

		})







		AimbotEnable:AddKeyPicker('Aimbot Enable', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates Aimbot',

			NoUI = false,

		})



		local WallCheckEnable = Aimbot.Settings:AddToggle('WallCheckEnable', {

			Text = 'Wall Check',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				_G.wallCheck = Value

			end

		})

		WallCheckEnable:AddKeyPicker('WallCheckEnable', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates Wall Check',

			NoUI = false,

		})



		--here



		getgenv().notify = false

		getgenv().damage = 9e9

		getgenv().highlightdestroy = false



		VehicleTab:AddInput('[Vehicle Damage]', {

			Default = '[Damage]',

			Numeric = true,

			Finished = true,



			Text = '[Vehicle Damage]',

			Tooltip = nil,



			Placeholder = '9e9',



			Callback = function(Value)

				local sigma = tonumber(Value)

				getgenv().damage = sigma

			end

		})





		local w = VehicleTab:AddToggle('Notify Car', {

			Text = 'Notify Car',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				getgenv().notify = Value

			end

		})



		w:AddKeyPicker('Enable Car Notifications', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates car notifications',

			NoUI = false,

		})





		local ws = VehicleTab:AddToggle('Highlight Car', {

			Text = 'Highlight Car',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				getgenv().highlightdestroy = Value

			end

		})



		ws:AddKeyPicker('Enable Car Highlight', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates car Highlight',

			NoUI = false,

		})









		VehicleTab:AddButton('Damage All Vehicles', function()



			for i,v in next, workspace.CivCars:GetChildren() do

				local sigma = checkgun()

				if not sigma then

					game.StarterGui:SetCore("SendNotification", {

						Title = "ℹ️",

						Text = "Purchase a gun"

					})

					return

				end

				if getgenv().notify then

					game.StarterGui:SetCore("SendNotification", {

						Title = "ℹ️",

						Text = v.Name .. " has been exploded / damaged!"

					})

				end

				if getgenv().highlightdestroy then

					local test = Instance.new("Highlight", v)

					game.Debris:AddItem(test, 2)

				end

				local ohInstance1 = game.Players.LocalPlayer.Character:FindFirstChild(sigma)

				local ohInstance2 = v

				local ohInstance3 = getpaint(v)

				local ohNumber4 = getgenv().damage



				game:GetService("ReplicatedStorage").InflictCar:InvokeServer(ohInstance1, ohInstance2, ohInstance3, ohNumber4)

			end

		end)





		MiscTab:AddInput('[Spam Amount]', {

			Default = '[Number]',

			Numeric = true,

			Finished = true,



			Text = '[Spam Amount]',

			Tooltip = nil,



			Placeholder = '[Number]',



			Callback = function(Value)

				local sigma = tonumber(Value)

				getgenv().intsdp = sigma

			end

		})



		MiscTab:AddButton('Spam Call Police', function()

			for i = 1,getgenv().intsdp do

				task.wait(0.05)

				game:GetService("ReplicatedStorage").CallPolice:FireServer()

			end

		end)





		MiscTab:AddButton('Break All Glass', function()

			for i,v in next, workspace:GetDescendants() do

				if v:IsA("BasePart") or v:IsA("MeshPart") then

					if v.Name == "Glass" then

						local ohInstance1 = v



						game:GetService("ReplicatedStorage").BreakGlass:InvokeServer(ohInstance1)

					end

				end

			end

		end)



		getgenv().intsdp = 10

		getgenv().sca = 10

		getgenv().autore = false

		local sigmattttttttt = false

		local deb = false



		function safe()

			if sigmattttttttt then return end



			local plr = game.Players.LocalPlayer

			local humanoid = plr.Character:FindFirstChildWhichIsA("Humanoid")



			if humanoid and humanoid.Health < getgenv().sca then

				game:GetService("StarterGui"):SetCore("SendNotification", {

					Title = "ℹ️",

					Text = "Hiding due to low HP!"

				})

				sigmattttttttt = true



				local ogp = plr.Character.HumanoidRootPart.Position

				while humanoid and humanoid.Health < getgenv().sca and sigmattttttttt do

					task.wait(0.5)

					game:GetService("StarterGui"):SetCore("SendNotification", {

						Title = "ℹ️",

						Text = "Current health: " .. math.round(humanoid.Health)

					})

					plr.Character.HumanoidRootPart.CFrame = CFrame.new(0, -30, 0)

					plr.Character.HumanoidRootPart.Anchored = true

				end



				if humanoid and humanoid.Health >= getgenv().sca then

					game:GetService("StarterGui"):SetCore("SendNotification", {

						Title = "ℹ️",

						Text = "Player is now safe, teleporting back!"

					})

					for i = 1, 5 do

						task.wait(0.1)

						sigmattttttttt = false

						plr.Character.HumanoidRootPart.Anchored = false

						plr.Character.HumanoidRootPart.CFrame = CFrame.new(ogp)

					end

				end

			end

		end







 

 

		QuickBuyTab:AddButton('Buy Shiesty', function()

			local ohString1 = "Shiesty"



			game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(ohString1)

		end)



		QuickBuyTab:AddButton('Buy AppleJuice', function()

			local ohString1 = "AppleJuice"



			game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(ohString1)

		end)



		QuickBuyTab:AddButton('Buy GreenAppleJuice', function()

			local ohString1 = "GreenAppleJuice"



			game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(ohString1)

		end)



		QuickBuyTab:AddButton('Buy BluGloves', function()

			local ohString1 = "BluGloves"



			game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(ohString1)

		end)



		QuickBuyTab:AddButton('Buy WhiteGloves', function()

			local ohString1 = "WhiteGloves"



			game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(ohString1)

		end)



		QuickBuyTab:AddButton('Buy BlackGloves', function()

			local ohString1 = "BlackGloves"



			game:GetService("ReplicatedStorage").ShopRemote:InvokeServer(ohString1)

		end)





--[[ 

Hitbox info

hrp.Size = Vector3.new(2, 2.0999999046325684, 0.8500099778175354)  -- Default size

hrp.Transparency = 1  -- Default transparency

hrp.Color = Color3.fromRGB(0.639216, 0.635294, 0.647059) -- Default "Medium stone grey"

hrp.Material = Enum.Material.Glass

hrp.CanCollide = false

--]]

 





local HitboxTab = Aimbot.Settings2:AddTab('Hitbox Extender')

local FistTab = Aimbot.Settings2:AddTab('Fist Extender')

 





-- Players and RunService initialization

local Players = game:GetService('Players')

local RunService = game:GetService('RunService')

local LocalPlayer = Players.LocalPlayer



-- Hitbox settings

local hitboxSettings = {

    Enabled = false,

    Size = 3,

    Transparency = 0.2,

    Color = Color3.new(1, 0, 0) -- Default red

}



-- Hitbox Extender Tab

HitboxTab:AddToggle('HitboxToggle', {

    Text = 'Enable Hitbox',

    Default = false,

    Callback = function(Value)

        hitboxSettings.Enabled = Value

    end

})



-- HitboxTab:AddInput('HitboxSize', {

--     Default = tostring(hitboxSettings.Size),

--     Numeric = true,

--     Finished = true,

--     Text = 'Hitbox Size',

--     Callback = function(Value)

--         hitboxSettings.Size = tonumber(Value) or hitboxSettings.Size

--     end

-- })

HitboxTab:AddButton({

    Text = 'Legit Hitbox',

    Func = function()

        hitboxSettings.Size = 2

        hitboxSettings.Transparency = hitboxSettings.Transparency

        hitboxSettings.Color = Color3.fromRGB(163, 162, 165) -- Medium Stone Grey

        Library:Notify('[Hitbox] Set to Legit Mode', 3)

    end,

    DoubleClick = false,

    Tooltip = nil

})



HitboxTab:AddButton({

    Text = 'Semi Legit Hitbox',

    Func = function()

        hitboxSettings.Size = 5

        hitboxSettings.Transparency = hitboxSettings.Transparency

        hitboxSettings.Color = Color3.fromRGB(255, 165, 0) -- Orange

        Library:Notify('[Hitbox] Set to Semi Legit Mode', 3)

    end,

    DoubleClick = false,

    Tooltip = nil

})



HitboxTab:AddButton({

    Text = 'Rage Hitbox',

    Func = function()

        hitboxSettings.Size = 10

        hitboxSettings.Transparency = hitboxSettings.Transparency

        hitboxSettings.Color = Color3.fromRGB(255, 0, 0) -- Red

        Library:Notify('[Hitbox] Set to Rage Mode', 3)

    end,

    DoubleClick = false,

    Tooltip = nil

})



HitboxTab:AddSlider('HitboxSize', {

    Text = 'Custom Hitbox Size',

    Default = tostring(hitboxSettings.Size),

    Min = 1,

    Max = 100,

    Rounding = 2,

    Callback = function(Value)

        hitboxSettings.Size = tonumber(Value) or hitboxSettings.Size

    end

})



HitboxTab:AddSlider('HitboxTransparency', {

    Text = 'Hitbox Transparency',

    Default = hitboxSettings.Transparency,

    Min = 0,

    Max = 1,

    Rounding = 2,

    Callback = function(Value)

        hitboxSettings.Transparency = Value

    end

})



HitboxTab:AddLabel('Hitbox Color'):AddColorPicker('HitboxColorPicker', {

    Default = hitboxSettings.Color,

    Title = 'Select Hitbox Color',

    Callback = function(Color)

        hitboxSettings.Color = Color

    end

})



Options.HitboxColorPicker:OnChanged(function()

    hitboxSettings.Color = Options.HitboxColorPicker.Value

end)



Options.HitboxColorPicker:SetValueRGB(Color3.fromRGB(255, 0, 0))



-- Rainbow color

local rainbowEnabled = false

function applyRainbowColor()

    while rainbowEnabled do

        local hue = tick() % 1

        local rainbowColor = Color3.fromHSV(hue, 1, 1)

        hitboxSettings.Color = rainbowColor

        Options.HitboxColorPicker:SetValueRGB(rainbowColor)

        task.wait(1.5)  

    end

end



HitboxTab:AddToggle('RainbowHitboxToggle', {

    Text = 'Enable Rainbow Hitbox Color',

    Default = false,

    Callback = function(Value)

        rainbowEnabled = Value

        if rainbowEnabled then

            task.spawn(applyRainbowColor)

        else

             hitboxSettings.Color = Options.HitboxColorPicker.Value

            Options.HitboxColorPicker:SetValueRGB(hitboxSettings.Color)

            Library:Notify('[Hitbox] Rainbow Color Disabled', 3)

        end

    end

})





-- Fist Extender Tab

FistTab:AddToggle('FistExtenderToggle', {

    Text = 'Enable Fist Extender',

    Default = false,

    Callback = function(Value)

        getgenv().togglef = Value

        local tool = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")

        if tool and tool:FindFirstChild("Hitbox") then

            if getgenv().togglef then

                tool.Hitbox.Size = getgenv().fist

                tool.Hitbox.Transparency = 0.5

            else

                tool.Hitbox.Size = Vector3.new(1.37, 1.55, 1.43)

                tool.Hitbox.Transparency = 1

            end

        end

    end

})



-- FistTab:AddInput('FistSize', {

--     Default = '10',

--     Numeric = true,

--     Finished = true,

--     Text = 'Fist Size',

--     Callback = function(Value)

--         local size = tonumber(Value)

--         getgenv().fist = Vector3.new(size, size, size)

--         if getgenv().togglef then

--             local tool = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")

--             if tool and tool:FindFirstChild("Hitbox") then

--                 tool.Hitbox.Size = getgenv().fist

--             end

--         end

--     end

-- })



FistTab:AddSlider('FistSize', {

    Text = 'Fist Size',

    Default = 7,

    Min = 1,

    Max = 100,

    Rounding = 1,

    Callback = function(Value)

		local size = tonumber(Value)

        getgenv().fist = Vector3.new(size, size, size)

        if getgenv().togglef then

            local tool = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")

            if tool and tool:FindFirstChild("Hitbox") then

                tool.Hitbox.Size = getgenv().fist

            end

        end

    end

})







FistTab:AddSlider('FistTransparency', {

    Text = 'Fist Transparency',

    Default = 0.06,

    Min = 0,

    Max = 1,

    Rounding = 2,

    Callback = function(Value)

        local tool = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")

        if tool and tool:FindFirstChild("Hitbox") then

            tool.Hitbox.Transparency = Value

        end

    end

})



-- Main logic for applying hitbox changes

RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE( function()

    if hitboxSettings.Enabled then

        for _, player in ipairs(Players:GetPlayers()) do

            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then

                local hrp = player.Character.HumanoidRootPart

                pcall(function()

                    hrp.Size = Vector3.new(hitboxSettings.Size, hitboxSettings.Size, hitboxSettings.Size)

                    hrp.Transparency = hitboxSettings.Transparency

                    hrp.Color = hitboxSettings.Color

                    hrp.Material = Enum.Material.Neon

                    hrp.CanCollide = false

                end)

            end

        end

    else

        for _, player in ipairs(Players:GetPlayers()) do

            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then

                local hrp = player.Character.HumanoidRootPart

                pcall(function()

                    hrp.Size = Vector3.new(2, 2.0999999046325684, 0.8500099778175354)

                    hrp.Transparency = 1

                    hrp.Color = Color3.fromRGB(0.639216, 0.635294, 0.647059)

                    hrp.Material = Enum.Material.Glass

                    hrp.CanCollide = false

                end)

            end

        end

    end

end))









		--// Visual Tab \\--

		local VisualsTabBox = Tabs.Visuals:AddLeftTabbox('Esp')

		local espTab = VisualsTabBox:AddTab('Esp')





		--// Esp Tab \\--

		local Boxes = {

			Settings = Tabs.Visuals:AddLeftGroupbox("settings"),

			Boxes = Tabs.Visuals:AddRightGroupbox("boxes"),

			Names = Tabs.Visuals:AddLeftGroupbox("names"),

			Health = Tabs.Visuals:AddRightGroupbox("health"),

			Distance = Tabs.Visuals:AddLeftGroupbox("distance"),

			Weapon = Tabs.Visuals:AddRightGroupbox("weapon"),

			SkyBox = Tabs.Visuals:AddLeftGroupbox("SkyBox"),

		}





		-- local SpeedLoop

		-- local OldSpeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed

		-- local SpeedBoost = MovementTab:AddToggle('Speed', {

		-- 	Text = 'Speed-Boost',

		-- 	Default = false,

		-- 	Tooltip = nil,



		-- 	Callback = function(Value)

		-- 		SpeedLoop = Value

		-- 		if SpeedLoop then

		-- 			while task.wait() and SpeedLoop do

		-- 				pcall(function()

		-- 					game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 75

		-- 				end)

		-- 			end

		-- 		else

		-- 			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = OldSpeed

		-- 		end

		-- 	end

		-- })



		-- SpeedBoost:AddKeyPicker('SpeedBind', {

		-- 	Default = '',

		-- 	SyncToggleState = true,

		-- 	Mode = 'Toggle',

		-- 	Text = 'Activates Speed Boost',

		-- 	NoUI = false,

		-- })





		-- MovementTab:AddSlider('WalkSpeedSlider', {

		-- 	Text = 'WalkSpeed',

		-- 	Default = 16,

		-- 	Min = 1,

		-- 	Max = 500,

		-- 	Rounding = 1,

		-- 	Compact = false,



		-- 	Callback = function(Value)

		-- 		task.spawn(function()

		-- 			while task.wait() do

		-- 				pcall(function()

		-- 					if _G.WalkSpeedEnabled then

		-- 						GetLocalPlayer().Character.Humanoid.WalkSpeed = Value

		-- 					end

		-- 				end)

		-- 			end

		-- 		end)

		-- 	end

		-- })

		local SpeedBoostValue = 8

		MovementTab:AddSlider('WalkSpeed', {

			Text = 'WalkSpeed',

			Default = 8,

			Min = 1,

			Max = 500,

			Rounding = 1,

			Compact = false,



			Callback = function(Value)

				SpeedBoostValue = Value

			end

		})





		local Track = nil

		local Animation = nil

		local WalkSpeedChangerEnabled

		local WalkSpeed = MovementTab:AddToggle("WalkSpeed", {

			Text = 'WalkSpeed',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				WalkSpeedChangerEnabled = Value

				if WalkSpeedChangerEnabled then

					Animation = Instance.new("Animation", game.Players.LocalPlayer.PlayerGui)

					Animation.AnimationId = "rbxassetid://78828590676720"

					local player = GetLocalPlayer()

					local Character = player.Character or player.CharacterAdded:Wait()

					local Humanoid = Character:WaitForChild("Humanoid")

					Track = Humanoid.Animator:LoadAnimation(Animation)

					Track:Play()

		

					while WalkSpeedChangerEnabled do

						task.wait()

						if not WalkSpeedChangerEnabled then return end

						if player.Character and player.Character:FindFirstChild("Humanoid") then

							Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)

							if not WalkSpeedChangerEnabled then return end

							Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)

							if not WalkSpeedChangerEnabled then return end

						end

						if not Track.IsPlaying then

							Track:Stop()

							Track:Play()

						end

						Humanoid.WalkSpeed = SpeedBoostValue

					end

		

				else

					local player = GetLocalPlayer()

					if player.Character and player.Character:FindFirstChild("Humanoid") then

						player.Character.Humanoid.WalkSpeed = 8

					end

					task.wait(0.2)

					if Track then

						Track:Stop()

					end

					if Animation then

						Animation:Destroy()

					end

				end

			end

		})



		WalkSpeed:AddKeyPicker('SpeedBind', {

			Default = '', 

			SyncToggleState = true,

			Mode = 'Toggle', 

			Text = 'WalkSpeed', 

			NoUI = false,

		})



		MovementTab:AddSlider('FlySpeed', {

			Text = 'FlySpeed',

			Default = 5,

			Min = 1,

			Max = 10,

			Rounding = 1,

			Compact = false,



			Callback = function(Value)

				flySpeed = Value

			end

		})





		local Fly = MovementTab:AddToggle("Fly", {

			Text = 'Fly',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

			   if Value then

				fly() 

			   else 

				NOFLY()

			   end

			end

		})Fly:AddKeyPicker('FlyBind', {

			Default = '', -- String as the name of the keybind (MB1, MB2 for mouse buttons)

			SyncToggleState = true,



			Mode = 'Toggle', -- Modes: Always, Toggle, Hold



			Text = 'Fly', -- Text to display in the keybind menu

			NoUI = false,

		})





		MovementTab:AddSlider('JumpPowerSlider', {

			Text = 'JumpPower',

			Default = 100,

			Min = 1,

			Max = 500,

			Rounding = 1,

			Compact = false,



			Callback = function(Value)

				if _G.JumpPowerEnabled then

					game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value

				end

			end

		})



		getgenv().cooldown = 0

		getgenv().damage = 100

		getgenv().hitpart = "Head"

		getgenv().color = Color3.fromRGB(255, 255, 255)

		getgenv().auraenabled = false

		getgenv().rainbowbeam = false



		function randomRGB()

			return Color3.fromRGB(

				Random.new():NextInteger(0, 255),

				Random.new():NextInteger(0, 255),

				Random.new():NextInteger(0, 255)

			)

		end





		getgenv().beam = true





		local killaura = Aimbot.Kill:AddToggle("Killaura", {

			Text = 'Toggle Killaura',

			Default = false,

			Tooltip = 'Killaura Gun required',

			Callback = function(Value)

				getgenv().auraenabled = Value

				while getgenv().auraenabled and task.wait(getgenv().cooldown) do

					task.wait()

					pcall(function()

						if getgenv().beam then



							local succ, err = pcall(function()

								if getgenv().beam then

									if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("GunScript_Local") then

										local plr = game.Players.LocalPlayer

										local part = Instance.new("Part", workspace)

										part.Size = Vector3.new(0.2, 0.2, (plr.Character.HumanoidRootPart.Position - target1.Character.Head.Position).Magnitude)

										part.Anchored = true

										part.CanCollide = false

										if not getgenv().rainbowbeam then

											part.Color = getgenv().color

										else

											part.Color = randomRGB()

										end



										part.Material = Enum.Material.Neon

										local toolHandle = plr.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Handle")

										if toolHandle then

											local midpoint = (toolHandle.Position + target1.Character[getgenv().hitpart].Position) / 2

											part.Position = midpoint

											part.CFrame = CFrame.new(midpoint, target1.Character[getgenv().hitpart].Position)

										end

										task.wait(0.1)

										part:Destroy()

									end

								end

							end)

							if err then

								print(tostring(err))

							end



						end

						dmg(target1, getgenv().hitpart, getgenv().damage)

					end)

				end

			end

		})



		killaura:AddKeyPicker('Toggle Killaura', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates killaura',

			NoUI = false,

		})



		local highlightk = Aimbot.Kill:AddToggle("Highlight Target", {

			Text = 'Highlight Target',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				getgenv().killaurahigh = Value

			end

		})

		highlightk:AddKeyPicker('Toggle Highlight', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates Highlight',

			NoUI = false,

		})











		Aimbot.Kill:AddInput('[Killaura HitPart]', {

			Default = 'Head',

			Numeric = true,

			Finished = true,



			Text = '[Killaura HitPart]',

			Tooltip = nil,



			Placeholder = 'Head',



			Callback = function(Value)

				local sigma = tostring(Value)

				getgenv().hitpart = sigma

			end

		})





		Aimbot.Kill:AddInput('[Killaura Damage]', {

			Default = '100',

			Numeric = true,

			Finished = true,



			Text = '[Killaura Damage]',

			Tooltip = nil,



			Placeholder = '100',



			Callback = function(Value)

				local sigma = tonumber(Value)

				getgenv().damage = sigma

			end

		})





		local killauracooldown = Aimbot.Kill:AddInput('[Killaura Interval]', {

			Default = '0',

			Numeric = true,

			Finished = true,



			Text = '[Killaura Interval]',

			Tooltip = nil,



			Placeholder = '0',



			Callback = function(Value)

				local sigma = tonumber(Value)

				getgenv().cooldown = sigma

			end

		})

		-----------------------------









		getgenv().cooldownknife = 0

		getgenv().KnifeAuraLoop = false



		local KnifeAuraLoop

		local KnifeAura = Aimbot.Knife:AddToggle('KnifeKill', {

			Text = 'Toggle Knifeaura',

			Default = false, -- Default value (true / false)

			Tooltip = nil,

			

			Callback = function(Value)

				KnifeAuraLoop = Value

				if KnifeAuraLoop then

 					task.spawn(function()

						while KnifeAuraLoop do

 							local cooldown = getgenv().cooldownknife

							task.wait(cooldown > 0 and cooldown or 0.1)  



 							local player = game.Players.LocalPlayer

							local tool = player.Character:FindFirstChildWhichIsA("Tool")

							local meleeSystem = tool and tool:FindFirstChild("MeleeSystem")

							local target = GetNearestPlayer()



							if meleeSystem and target then

 								meleeSystem.AttackEvent:FireServer()

							end

						end

					end)

				end

			end

		})



		KnifeAura:AddKeyPicker('Toggle Knifeaura', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates Knifeaura',

			NoUI = false,

		})



		local highlightkkk = Aimbot.Knife:AddToggle("Highlight Target", {

			Text = 'Highlight Target',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				getgenv().killaurahigh = Value

			end

		})



		highlightkkk:AddKeyPicker('Toggle Highlight', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates Highlight',

			NoUI = false,

		})



		local knifeauracooldown = Aimbot.Knife:AddInput('[Killaura Interval]', {

			Default = '0',

			Numeric = true,

			Finished = true,

			Text = '[Killaura Interval]',

			Tooltip = nil,

			Placeholder = '0',

			

			Callback = function(Value)

				local sigma = tonumber(Value)

				getgenv().cooldownknife = sigma

			end

		})











		local beam = Aimbot.Simbeam:AddToggle("Simulate Beam (Killaura Gun)", {

			Text = 'Simulate Beam',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				getgenv().beam = Value

			end

		})

		beam:AddKeyPicker('Toggle Beam (Killaura)', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates beam',

			NoUI = false,

		})





		local ra = Aimbot.Simbeam:AddToggle("Simulate Rainbow (Beam)", {

			Text = 'Rainbow Beam',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				getgenv().rainbowbeam = Value

			end

		})

		ra:AddKeyPicker('Toggle Rainbow (Beam)', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates rainbow',

			NoUI = false,

		})



		Aimbot.Simbeam:AddLabel('Beam Custom Color'):AddColorPicker('ColorPicker', {

			Default = Color3.new(1, 1, 1),

			Title = 'Beam Color',

			Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)



			Callback = function(Value)

				print('[cb] Color changed!', Value)

				getgenv().color = Value

			end

		})



		Options["ColorPicker"]:OnChanged(function()

			getgenv().color = Options["ColorPicker"].Value

		end)









		getgenv().maxbot = 50

		getgenv().spinning = false

		local spin = Aimbot.Spinbot:AddToggle('Spinbot', {

			Text = 'Toggle Spinbot',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				getgenv().spinning = Value

				while task.wait() and getgenv().spinning do

					pcall(function()

						local humanoidRootPart = RootPart()

						humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.Angles(0, math.rad(getgenv().maxbot), 0)

					end)

				end

			end

		})



		spin:AddKeyPicker('Enable Spinbot', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates Spinbot',

			NoUI = false,

		})







		Aimbot.Spinbot:AddSlider('Spinbot Power', {

			Text = 'Spinbot Power',

			Default = 50,

			Min = 0,

			Max = 1000,

			Rounding = 1,

			Compact = false,



			Callback = function(Value)

				getgenv().maxbot = Value

			end

		})













		-- _G.WalkSpeedEnabled = false

		-- local WalkSpeed = MovementTab:AddToggle('WalkSpeed', {

		-- 	Text = 'WalkSpeed Toggle',

		-- 	Default = false,

		-- 	Tooltip = nil,

		-- 	Callback = function(Value)

		-- 		_G.WalkSpeedEnabled = Value

		-- 		if not Value then

		-- 			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16

		-- 		end

		-- 	end

		-- })WalkSpeed:AddKeyPicker('SpeedBind', {

		-- 	Default = '',

		-- 	SyncToggleState = true,



		-- 	Mode = 'Toggle',



		-- 	Text = 'WalkSpeed',

		-- 	NoUI = false,

		-- })









		_G.JumpPowerEnabled = false

		local JumpPower = MovementTab:AddToggle('JumpPower', {

			Text = 'JumpPower Toggle',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				_G.JumpPowerEnabled = Value

				if not Value then

					game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100

				end

			end

		})JumpPower:AddKeyPicker('JumpPowerBind', {

			Default = '', -- String as the name of the keybind (MB1, MB2 for mouse buttons)

			SyncToggleState = true,



			Mode = 'Toggle', -- Modes: Always, Toggle, Hold



			Text = 'JumpPower', -- Text to display in the keybind menu

			NoUI = false,

		})















		local InfJump2 = MovementTab:AddToggle('InfJump', {

			Text = 'Infinite Jump',

			Default = false,

			Tooltip = nil,



			Callback = function(Value)

				_G.InfJumpEnabled = Value



				local infJump

				local infJumpbounce = false

				local player = GetLocalPlayer()



				local isHoldingSpace = false



				infJump = UIS.JumpRequest:Connect(function()

					if _G.InfJumpEnabled and not infJumpbounce then

						infJumpbounce = true

						local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")

						if humanoid then

							humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

						end

						task.wait()

						infJumpbounce = false

					end

				end)



				UIS.InputBegan:Connect(function(input)

					if _G.InfJumpEnabled and input.KeyCode == Enum.KeyCode.Space then

						isHoldingSpace = true

						while isHoldingSpace do

							if _G.InfJumpEnabled and not infJumpbounce then

								infJumpbounce = true

								local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")

								if humanoid then

									humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

								end

								task.wait()

								infJumpbounce = false

							end

							task.wait()

						end

					end

				end)



				UIS.InputEnded:Connect(function(input)

					if input.KeyCode == Enum.KeyCode.Space then

						isHoldingSpace = false

					end

				end)



			end

		})





		InfJump2:AddKeyPicker('InfJump2', {

			Default = '',

			SyncToggleState = true,



			Mode = 'Toggle',



			Text = 'JumpPower',

			NoUI = false,

		})



		function FB(enabled)

			local Lighting = game:GetService("Lighting")

			if enabled then

				Lighting.Brightness = 2

				Lighting.ClockTime = 14

				Lighting.FogEnd = 100000

				Lighting.GlobalShadows = false

				Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)

			else

				Lighting.Brightness = 1

				Lighting.ClockTime = 12

				Lighting.FogEnd = 1000

				Lighting.GlobalShadows = true

				Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)

			end

		end



		local fullbright = MovementTab:AddToggle('FullbrightToggle', {

			Text = 'Fullbright',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				FB(Value)

			end

		})



		fullbright:AddKeyPicker('FullbrightKeybind', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Fullbright Keybind',

			NoUI = false,

		})









		function noclip()

			if GetLocalPlayer().Character ~= nil then

				for _, child in pairs(GetLocalPlayer().Character:GetDescendants()) do

					if child:IsA("BasePart") and child.CanCollide == true then

						child.CanCollide = false

					end

				end

			end

		end



		local Noclipping

		local noclip = MovementTab:AddToggle('Noclip', {

			Text = 'Noclip',

			Default = false,

			Tooltip = nil,

			Callback = function(v)

				if v then

					Noclipping = game:GetService('RunService').Stepped:Connect(noclip)

				else

					if Noclipping then

						Noclipping:Disconnect()

					end

				end

			end

		})



		noclip:AddKeyPicker('Noclip', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Noclip',

			NoUI = false,

		})













		PlayerTab:AddToggle('Stamina', {

			Text = 'Infinite Stamina',

			Default = false,

			Tooltip = nil, -- Information shown when you hover over the toggle



			Callback = function(Value)

				if  game:GetService("Players").LocalPlayer.PlayerGui.Run.Frame.Frame.Frame:FindFirstChild("StaminaBarScript") then

					game:GetService("Players").LocalPlayer.PlayerGui.Run.Frame.Frame.Frame:FindFirstChild("StaminaBarScript").Enabled = false

					game:GetService("Players").LocalPlayer.PlayerGui.Run.Frame.Frame.Frame:FindFirstChild("StaminaBarScript"):Destroy()

				end

			end

		})



		PlayerTab:AddToggle('Hunger', {

			Text = 'Infinite Hunger',

			Default = false,

			Tooltip = nil, -- Information shown when you hover over the toggle



			Callback = function(Value)

				if game:GetService("Players").LocalPlayer.PlayerGui.Hunger.Frame.Frame.Frame:FindFirstChild("HungerBarScript") then

					game:GetService("Players").LocalPlayer.PlayerGui.Hunger.Frame.Frame.Frame:FindFirstChild("HungerBarScript").Enabled = false

					game:GetService("Players").LocalPlayer.PlayerGui.Hunger.Frame.Frame.Frame:FindFirstChild("HungerBarScript"):Destroy()

				end

			end

		})



		PlayerTab:AddToggle('Sleep', {

			Text = 'Infinite Sleep',

			Default = false,

			Tooltip = nil, -- Information shown when you hover over the toggle



			Callback = function(Value)

				if game:GetService("StarterGui").SleepGui.Frame.sleep.SleepBar:FindFirstChild("sleepScript") then

					game:GetService("StarterGui").SleepGui.Frame.sleep.SleepBar:FindFirstChild("sleepScript").Enabled = false

					game:GetService("StarterGui").SleepGui.Frame.sleep.SleepBar:FindFirstChild("sleepScript"):Destroy()

					game:GetService("ReplicatedStorage").SleepSystem:Destroy()

					game:GetService("Players").LocalPlayer.PlayerGui.SleepGui.Frame.sleep.SleepBar.sleepScript:Destroy()

				end

			end

		})



		PlayerTab:AddToggle('Respawn', {

			Text = 'Faster Respawn',

			Default = false,

			Tooltip = nil,



			Callback = function(Value)

				_G.respawn = Value

				if Value then

					task.spawn(function()

						while _G.respawn and task.wait(1) do

							if RootPart()

								and game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then

								game:GetService("ReplicatedStorage").RespawnRE:FireServer()

								task.wait(1)

							end

						end

					end)

				end

			end

		})



		PlayerTab:AddToggle('No Rent Pay', {

			Text = 'No Rent Pay',

			Default = false,

			Tooltip = nil, -- Information shown when you hover over the toggle



			Callback = function(Value)

				if game:GetService("StarterGui").RentGui:FindFirstChild("LocalScript") then

					game:GetService("StarterGui").RentGui:FindFirstChild("LocalScript").Enabled = false

					game:GetService("StarterGui").RentGui:FindFirstChild("LocalScript"):Destroy()

				end

			end

		})

        





		PlayerTab:AddToggle('Instant Interact', {

			Text = 'Instant Interact',

			Default = false,

			Tooltip = nil, -- Information shown when you hover over the toggle



			Callback = function(Value)

				if Value then

					Library:Notify("Applying instant interact settings, please wait...", 5)

					task.wait(2)

					local excludedFolder = game.Workspace.HouseRobb



					for i, v in pairs(game.Workspace:GetDescendants()) do

						if v:IsA("ProximityPrompt") then

							if not v:IsDescendantOf(excludedFolder) then

								v.HoldDuration = 0

								v.RequiresLineOfSight = false

							end

						end

					end



				end

			end

		})











		function Dirty4()

			for i, v in pairs(workspace["1# Map"].Washerr:GetDescendants()) do

				if v:IsA("ProximityPrompt") then

					v.HoldDuration = 0

					v.RequiresLineOfSight = false

				end

			end

		end



		PlayerTab:AddToggle('Wash', {

			Text = 'Wash Money',

			Default = false,

			Tooltip = nil,



			Callback = function(Value)

				local wash = Value



				if wash then

					Dirty4() 

					for _, v in pairs(workspace["1# Map"].Washerr:GetDescendants()) do

						if v:IsA("ObjectValue") and v.Name == "Washer" then

							if v.Parent.ActionText == "" then

								OldCFrameWash = RootPart().CFrame

								BypassTp(CFrame.new(v.Parent.Parent.Position.X + 1, v.Parent.Parent.Position.Y, v.Parent.Parent.Position.Z))

									task.wait(0.25)

								fireproximityprompt(v.Parent)

								task.wait(1)

								BypassTp(OldCFrameWash)

								Toggles.Wash:SetValue(false)

								break

							end

						end

					end

				end

			end

		})





		PlayerTab:AddToggle('Dry', {

			Text = 'Dry Money',

			Default = false,

			Tooltip = nil,



			Callback = function(Value)

				local dry = Value

				local player = tostring(game.Players.LocalPlayer.Name)



				if dry then

					Dirty4()



					local hasDirtyMoney = game.Players.LocalPlayer.Character:FindFirstChild("DirtyMoney") or

						game.Players.LocalPlayer.Backpack:FindFirstChild("DirtyMoney")



					if not hasDirtyMoney then

						for _, v in pairs(workspace["1# Map"].Washerr:GetDescendants()) do

							if v:IsA("ObjectValue") and v.Name == "Washer" then

								if v.Parent.ActionText and v.Parent.ActionText == player then

										BypassTp(CFrame.new(v.Parent.Parent.Position + Vector3.new(1, 0, 0)))

									task.wait(0.25)



									repeat

										fireproximityprompt(v.Parent)

										task.wait(0.25)

									until game.Players.LocalPlayer.Character:FindFirstChild("DirtyMoney")

									break

								end

							end

						end

					end



					for _, v in pairs(workspace["1# Map"].Washerr:GetDescendants()) do

						if v:IsA("ObjectValue") and v.Name == "Dryer" then

							if v.Parent.ActionText and v.Parent.ActionText == "" then

								BypassTp(CFrame.new(v.Parent.Parent.Position - Vector3.new(2, 0, 0)))

								task.wait(0.25)

								fireproximityprompt(v.Parent)

								Toggles.Dry:SetValue(false)

								break

							end

						end

					end

				end

			end

		})



		PlayerTab:AddToggle('GrabMoney', {

			Text = 'Grab Money & Sell',

			Default = false,

			Tooltip = nil,



			Callback = function(Value)

				local sellmoneyprompt = workspace.SellDirtyMoney

				local player = tostring(game.Players.LocalPlayer.Name)



				if Value then

					local hasCleanedMoney = game.Players.LocalPlayer.Character:FindFirstChild("CleanedMoney") or

						game.Players.LocalPlayer.Backpack:FindFirstChild("CleanedMoney")



					if not hasCleanedMoney then

						for _, v in pairs(workspace["1# Map"].Washerr:GetDescendants()) do

							if v:IsA("ObjectValue") and v.Name == "Dryer" then

								if v.Parent.ObjectText and v.Parent.ObjectText == "Grab Money" and

									v.Parent.ActionText and v.Parent.ActionText == player then

										BypassTp(CFrame.new(v.Parent.Parent.Position - Vector3.new(2, 0, 0)))

									task.wait(0.25)



									repeat

										fireproximityprompt(v.Parent)

										task.wait(0.25)

									until game.Players.LocalPlayer.Character:FindFirstChild("CleanedMoney")

								end

							end

						end

					end



					if sellmoneyprompt then

						sellmoneyprompt.Prompt.HoldDuration = 0

						sellmoneyprompt.Prompt.RequiresLineOfSight = false



						BypassTp(CFrame.new(sellmoneyprompt.Position))



						repeat

							fireproximityprompt(sellmoneyprompt.Prompt)

							task.wait(0.25)

						until not game.Players.LocalPlayer.Character:FindFirstChild("CleanedMoney")



						Toggles.GrabMoney:SetValue(false)

					end

				end

			end

		})



































		-- game:GetService("Players").LocalPlayer.Character.Fist.MeleeSystem.AttackEvent:FireServer()















































		--local MyButton = MiscTab:AddButton({

		--	Text = 'No Face',

		--	Func = function()

		--		for i,v in pairs(game.Players.LocalPlayer.Character.Head:GetChildren()) do

		--			if (v:IsA("Decal")) then

		--				v:Destroy()

		--			end

		--		end

		--	end,

		--	DoubleClick = false,

		--	Tooltip = nil

		--})



		--local MyButton = MiscTab:AddButton({

		--	Text = 'No Head',

		--	Func = function()

		--		game.Players.LocalPlayer.Character.Head.Transparency = 1

		--		for i,v in pairs(game.Players.LocalPlayer.Character.Head:GetChildren()) do

		--			if (v:IsA("Decal")) then

		--				v:Destroy()

		--			end

		--		end

		--	end,

		--	DoubleClick = false,

		--	Tooltip = nil

		--})



		--local MyButton = MiscTab:AddButton({

		--	Text = 'Bald',

		--	Func = function()

		--		for i,v in next, game:GetService('Players').LocalPlayer.Character:GetChildren() do

		--			if v:IsA('Accessory') then

		--				v:Destroy()

		--			end

		--		end

		--	end,

		--	DoubleClick = false,

		--	Tooltip = nil

		--})





		function antiragdoll()

			pcall(function()

				if game.Players.LocalPlayer.Character:FindFirstChild("RagdollConstraints") then

					local char1 = game.Players.LocalPlayer.Character

					for i,v in pairs(char1:WaitForChild("RagdollConstraints"):GetChildren()) do

						v:Destroy()

						print("Disabled ".. v.Name)

					end

					game.Players.LocalPlayer.CharacterAdded:Connect(function(char)

						for i,v in pairs(char:WaitForChild("RagdollConstraints"):GetChildren()) do

							v:Destroy()

							print("Disabled ".. v.Name)

						end

					end)

				end

			end)

		end



		local MyButton = MiscTab:AddButton({

			Text = 'Anti Ragdoll',

			Func = function()

				antiragdoll()

			end,

			DoubleClick = false,

			Tooltip = nil

		})



		local MyButton = MiscTab:AddButton({

			Text = 'Anti Camera Shake',

			Func = function()

				function disableCameraBobbing(character)

					local cameraBobbing = character:FindFirstChild("CameraBobbing")

					if cameraBobbing then

						cameraBobbing.Enabled = false

						cameraBobbing:Destroy()

					end

				end



				function monitorCameraBobbing()

					local player = game.Players.LocalPlayer

					player.CharacterAdded:Connect(function(character)

						disableCameraBobbing(character)

						character.ChildAdded:Connect(function(child)

							if child.Name == "CameraBobbing" then

								disableCameraBobbing(character)

							end

						end)

					end)



					if player.Character then

						local character = player.Character

						disableCameraBobbing(character)

						character.ChildAdded:Connect(function(child)

							if child.Name == "CameraBobbing" then

								disableCameraBobbing(character)

							end

						end)

					end

				end



				monitorCameraBobbing()

			end,

			DoubleClick = false,

			Tooltip = nil

		})









		local MyButton = MiscTab:AddButton({

			Text = 'Anti Fall Damage',

			Func = function()

				antifalldmg()

			end,

			DoubleClick = false,

			Tooltip = nil

		})





		local MyButton = MiscTab:AddButton({

			Text = 'Anti JumpCooldown',

			Func = function()

				if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("JumpDebounce") then

					game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("JumpDebounce"):Destroy()

				end

			end,

			DoubleClick = false,

			Tooltip = nil

		})





		if hookmetamethod then

			local ff1 = MiscTab:AddButton({

				Text = 'Sell Gold/Duffle',

				Func = function()

					fireclickdetector(workspace.sellgold.ClickDetector)

				end,

				DoubleClick = false,

				Tooltip = nil

			})

		end





		local MyButton = MiscTab:AddButton({

			Text = 'Remove Damage Blood',

			Func = function()

				if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("BloodGui") then

					game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("BloodGui").ResetOnSpawn = false

					game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("BloodGui"):Destroy()

				end

			end,

			DoubleClick = false,

			Tooltip = nil

		})











		TargetTab:AddButton({

			Text = 'Anti-Cooldown Fists',

			Func = function()

				if not supportsRequire() then

					Library:Notify("[SleepyHub] - Your executor doesn't support this. We recommend using Wave/Synapse-Z", 5)

					return

				end

				require(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Melee_Settings).StompCooldown = 0

				require(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Melee_Settings).AttackCooldown = 0

			end,

			DoubleClick = false,

			Tooltip = nil

		})





		TargetTab:AddInput('[Enter Target Name]', {

			Default = '[Enter username]',

			Numeric = false,

			Finished = true,

			Text = '[Enter target username]',

			Tooltip = nil,

			Placeholder = '[Enter username]',



			Callback = function(text)

				getgenv().Target = nil



				for i, v in pairs(game.Players:GetChildren()) do

					if (string.sub(string.lower(v.Name), 1, string.len(text))) == string.lower(text) then

						getgenv().Target = v.Name

						break

					end

				end



				if getgenv().Target then

					return Library:Notify("[SleepyHub] - Player found: " .. getgenv().Target, 3)

				end



				if not getgenv().Target then

					return Library:Notify("[SleepyHub] - Player not found", 3)

				end

			end

		})









		local viewing = nil

		local viewDied = nil

		local viewChanged = nil





		function startSpectating(targetName)

			local targetPlayer = game.Players:FindFirstChild(targetName)

			if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then

				viewing = targetPlayer

				workspace.CurrentCamera.CameraSubject = targetPlayer.Character



				Library:Notify("[SleepyHub] - Spectating " .. targetPlayer.Name, 3)





				function onCharacterAdded()

					repeat wait() until targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")

					workspace.CurrentCamera.CameraSubject = targetPlayer.Character

				end

				viewDied = targetPlayer.CharacterAdded:Connect(onCharacterAdded)



				function onCameraSubjectChanged()

					if viewing then

						workspace.CurrentCamera.CameraSubject = targetPlayer.Character

					end

				end

				viewChanged = workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(onCameraSubjectChanged)

			else

				Library:Notify("[SleepyHub] - Unable to spectate " .. targetName, 3)

			end

		end



		function stopSpectating()

			if viewDied then viewDied:Disconnect() end

			if viewChanged then viewChanged:Disconnect() end

			viewing = nil

			workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character

			Library:Notify("[SleepyHub] - Spectate turned off", 3)

		end



		--  toggle

		TargetTab:AddToggle('Spectate', {

			Text = '| Spectate',

			Default = false,

			Tooltip = nil,



			Callback = function(Value)

				if Value then

					if getgenv().Target then

						startSpectating(getgenv().Target)

					else

						Library:Notify("[SleepyHub] - No target selected to spectate", 3)

					end

				else

					stopSpectating()

				end

			end

		})



		TargetTab:AddToggle('Teleport', {

			Text = '| Goto',

			Default = false,

			Tooltip = nil,

		

			Callback = function(Value)

				if Value then

					if getgenv().Target then

						local targetPlayer = game.Players:FindFirstChild(getgenv().Target)

						if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then

 							local localPlayerCharacter = game.Players.LocalPlayer.Character

							if localPlayerCharacter and localPlayerCharacter:FindFirstChild("HumanoidRootPart") then

								BypassTp(targetPlayer.Character.HumanoidRootPart.CFrame)

								Library:Notify("[SleepyHub] - Teleported to " .. targetPlayer.Name, 3)

							else

								Library:Notify("[SleepyHub] - Unable to teleport: character not found", 3)

							end

						else

							Library:Notify("[SleepyHub] - Unable to teleport: character not found", 3)

						end

		

						Toggles.Teleport:SetValue(false)

					else

						Library:Notify("[SleepyHub] - No target selected to teleport to", 3)

						Toggles.Teleport:SetValue(false)

					end

				end

			end

		})

		









--[[

		TargetTab:AddToggle('fling', {

			Text = '| Fling',

			Default = false,

			Tooltip = nil,



			Callback = function(Value)

				if Value then

					local target = getgenv().Target

					local Targets = {tostring(target)}



					local Players = game:GetService("Players")

					local Player = Players.LocalPlayer



					local AllBool = false



					local GetPlayer = function(Name)

						Name = Name:lower()

						if Name == "all" or Name == "others" then

							AllBool = true

							return

						elseif Name == "random" then

							local GetPlayers = Players:GetPlayers()

							if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end

							return GetPlayers[math.random(#GetPlayers)]

						elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then

							for _,x in next, Players:GetPlayers() do

								if x ~= Player then

									if x.Name:lower():match("^"..Name) then

										return x;

									elseif x.DisplayName:lower():match("^"..Name) then

										return x;

									end

								end

							end

						else

							return

						end

					end



					--local Message = function(_Title, _Text, Time)

					--	game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})

					--end



					local SkidFling = function(TargetPlayer)

						local Character = Player.Character

						local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

						local RootPart = Humanoid and Humanoid.RootPart



						local TCharacter = TargetPlayer.Character

						local THumanoid

						local TRootPart

						local THead

						local Accessory

						local Handle



						if TCharacter:FindFirstChildOfClass("Humanoid") then

							THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")

						end

						if THumanoid and THumanoid.RootPart then

							TRootPart = THumanoid.RootPart

						end

						if TCharacter:FindFirstChild("Head") then

							THead = TCharacter.Head

						end

						if TCharacter:FindFirstChildOfClass("Accessory") then

							Accessory = TCharacter:FindFirstChildOfClass("Accessory")

						end

						if Accessoy and Accessory:FindFirstChild("Handle") then

							Handle = Accessory.Handle

						end



						if Character and Humanoid and RootPart then

							if RootPart.Velocity.Magnitude < 50 then

								getgenv().OldPos = RootPart.CFrame

							end

							if THumanoid and THumanoid.Sit and not AllBool then

								return Library:Notify("[SleepyHub] - Targeting is sitting", 5) -- u can remove dis part if u want lol

							end

							if THead then

								workspace.CurrentCamera.CameraSubject = THead

							elseif not THead and Handle then

								workspace.CurrentCamera.CameraSubject = Handle

							elseif THumanoid and TRootPart then

								workspace.CurrentCamera.CameraSubject = THumanoid

							end

							if not TCharacter:FindFirstChildWhichIsA("BasePart") then

								return

							end



							local FPos = function(BasePart, Pos, Ang)

								BypassTp(CFrame.new(BasePart.Position) * Pos * Ang)

								Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)

								RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)

								RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)

							end



							local SFBasePart = function(BasePart)

								local TimeToWait = 2

								local Time = tick()

								local Angle = 0



								repeat

									if RootPart and THumanoid then

										if BasePart.Velocity.Magnitude < 50 then

											Angle = Angle + 100



											FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))

											task.wait()



											FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))

											task.wait()



											FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))

											task.wait()



											FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))

											task.wait()



											FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))

											task.wait()



											FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))

											task.wait()

										else

											FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))

											task.wait()



											FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))

											task.wait()



											FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))

											task.wait()



											FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))

											task.wait()



											FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))

											task.wait()



											FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))

											task.wait()



											FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))

											task.wait()



											FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))

											task.wait()



											FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))

											task.wait()



											FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))

											task.wait()

										end

									else

										break

									end

								until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait

							end



							workspace.FallenPartsDestroyHeight = 0/0



							local BV = Instance.new("BodyVelocity")

							BV.Name = "EpixVel"

							BV.Parent = RootPart

							BV.Velocity = Vector3.new(9e8, 9e8, 9e8)

							BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)



							Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)



							if TRootPart and THead then

								if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then

									SFBasePart(THead)

								else

									SFBasePart(TRootPart)

								end

							elseif TRootPart and not THead then

								SFBasePart(TRootPart)

							elseif not TRootPart and THead then

								SFBasePart(THead)

							elseif not TRootPart and not THead and Accessory and Handle then

								SFBasePart(Handle)

							else

								return Library:Notify("[SleepyHub] - Target is missing everything", 5)

							end



							BV:Destroy()

							Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)

							workspace.CurrentCamera.CameraSubject = Humanoid



							repeat

								BypassTp(getgenv().OldPos * CFrame.new(0, .5, 0))

								Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))

								Humanoid:ChangeState("GettingUp")

								table.foreach(Character:GetChildren(), function(_, x)

									if x:IsA("BasePart") then

										x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()

									end

								end)

								task.wait()

							until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25

							workspace.FallenPartsDestroyHeight = getgenv().FPDH

						else

							return Library:Notify("[SleepyHub] - Random error", 5)

						end

					end





					if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end



					if AllBool then

						for _,x in next, Players:GetPlayers() do

							SkidFling(x)

							Toggles.fling:SetValue(false)

						end

					end



					for _,x in next, Targets do

						if GetPlayer(x) and GetPlayer(x) ~= Player then

							if GetPlayer(x).UserId ~= 1414978355 then

								local TPlayer = GetPlayer(x)

								if TPlayer then

									SkidFling(TPlayer)

									Toggles.fling:SetValue(false)

								end

							else

								Library:Notify("[SleepyHub] - This user is whitelisted nice try", 5)

							end

						elseif not GetPlayer(x) and not AllBool then

							Library:Notify("[SleepyHub] - Username Invalid", 5)

						end

					end

				end

			end

		})

]]











		TargetTab:AddToggle('Killbring', {

			Text = '| Kill [Bring]',

			Default = false,

			Tooltip = nil,



			Callback = function(Value)

				if Value then

					Library:Notify("[SleepyHub] - Killbring Enabled", 3)



					function killBring()

						if not getgenv().Target then

							Library:Notify("[SleepyHub] - No target selected", 3)

							return false

						end



						local targetPlayer = game.Players:FindFirstChild(getgenv().Target)

						local speaker = game.Players.LocalPlayer



						if targetPlayer and targetPlayer.Character and speaker.Character then

							local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")

							local speakerRoot = speaker.Character:FindFirstChild("HumanoidRootPart")



							if targetRoot and speakerRoot then

								if targetPlayer.Character:FindFirstChildOfClass('Humanoid') then

									targetPlayer.Character:FindFirstChildOfClass('Humanoid').Sit = false

								end



								task.wait()

								targetRoot.CFrame = speakerRoot.CFrame + Vector3.new(3, 1, 0)

								return true

							else

								Library:Notify("[SleepyHub] - Cannot locate target or speaker root part", 3)

								return false

							end

						else

							Library:Notify("[SleepyHub] - Invalid target or speaker", 3)

							return false

						end

					end



					getgenv().KillbringActive = true

					while getgenv().KillbringActive do

						if not killBring() then

							task.wait() 

						else

							task.wait()

						end

					end

				else

					getgenv().KillbringActive = false

					Library:Notify("[SleepyHub] - Killbring Disabled", 3)

				end

			end

		})



		getgenv().KillFistEnabled = false



		TargetTab:AddToggle('Killfistremote', {

			Text = '| Kill [Fist]',

			Default = false,

			Tooltip = nil,



			Callback = function(Value)

				getgenv().KillFistEnabled = Value

				if Value then

					startKillFist()

				end

			end

		})



		function startKillFist()

			task.spawn(function()

				local player = game.Players.LocalPlayer

				local OldCframe = player.Character.HumanoidRootPart.CFrame



				while getgenv().KillFistEnabled do

					if not getgenv().Target then

						Library:Notify("No target selected", 3)

						Toggles.Killfistremote:SetValue(false)

						break

					end



					if not player.Backpack:FindFirstChild("Fist") and not player.Character:FindFirstChild("Fist") then

						Library:Notify("No Fist found", 3)

						Toggles.Killfistremote:SetValue(false)

						break

					end



					-- Equip Fist if not already equipped

					if not player.Character:FindFirstChild("Fist") then

						player.Backpack.Fist.Parent = player.Character

					end



					-- Locate Target Player

					local targetPlayer = game.Players:FindFirstChild(getgenv().Target)

					if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then

						Library:Notify("Target player not available", 3)

						BypassTp(OldCframe) -- Teleport back

						player.Character:WaitForChild("Humanoid"):UnequipTools()

						Toggles.Killfistremote:SetValue(false)

						break

					end



					-- Check if Target is dead

					local dead = targetPlayer.Character.Humanoid.Health < 1

					if dead then

						Library:Notify("Target is already dead", 3)

						BypassTp(OldCframe)

						task.wait(0.40)

						player.Character:WaitForChild("Humanoid"):UnequipTools()

						Toggles.Killfistremote:SetValue(false)

						break

					end



					-- Attack the Target

					local rootPart = player.Character:FindFirstChild("HumanoidRootPart")

					if rootPart then

						BypassTp(targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0.2), false)

						player.Character.Fist.MeleeSystem.AttackEvent:FireServer()

					end



					-- Update Target's death status

					dead = targetPlayer.Character.Humanoid.Health < 1

					if dead then

						Library:Notify("Target eliminated", 3)

						BypassTp(OldCframe)

						player.Character:WaitForChild("Humanoid"):UnequipTools()

						Toggles.Killfistremote:SetValue(false)

						break

					end



					task.wait(0.30)

				end

			end)

		end











		TargetTab:AddToggle('Killgunremote', {

			Text = '| Kill [Gun]',

			Default = false,

			Tooltip = nil,



			Callback = function(Value)

				getgenv().KillGunEnabled = Value

				if Value then

					startKillGun()

				end

			end

		})



		function checkgun()

			local player = game.Players.LocalPlayer

			local gunTool = nil



			for _, v in pairs(player.Backpack:GetDescendants()) do

				if v:IsA("LocalScript") and v.Name == "GunScript_Local" then

					gunTool = v.Parent

					break

				end

			end



			if not gunTool and player.Character then

				for _, v in pairs(player.Character:GetDescendants()) do

					if v:IsA("LocalScript") and v.Name == "GunScript_Local" then

						gunTool = v.Parent

						break

					end

				end

			end



			if gunTool and gunTool:IsA("Tool") then

				game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(gunTool)

				print("Gun equipped:", gunTool.Name)

			else

				print("Gun not found.")

			end



			return gunTool

		end





		function startKillGun()

			task.spawn(function()

				while getgenv().KillGunEnabled do

					if not getgenv().Target then

						Library:Notify("No target selected", 3)

						return

					end



					local player = game.Players.LocalPlayer



					if not checkgun() then

						Library:Notify("No Gun found", 3)

						return

					end



					local target = game.Players:FindFirstChild(getgenv().Target)

					if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then

						local OldCframe = player.Character.HumanoidRootPart.CFrame



						BypassTp(target.Character.HumanoidRootPart.CFrame)



						pcall(function()

							dmg(target, "Head", 1000)

							dmg(target, "Head", 1000)

							Library:Notify("Damage applied to target", 3)

						end)



						task.wait(0.8)

						BypassTp(OldCframe)

						player.Character:WaitForChild("Humanoid"):UnequipTools()



						Toggles.Killgunremote:SetValue(false)

						break

					else

						Library:Notify("Invalid target", 3)

						break

					end



					task.wait(0.5)

				end

			end)

		end











		TargetTab:AddToggle('ViewInventory', {

			Text = '| View Inventory',

			Default = false,

			Tooltip = nil,



			Callback = function(Value)

				if Value then

					if getgenv().Target then

						local targetPlayer = game.Players:FindFirstChild(getgenv().Target)



						if targetPlayer then

							if targetPlayer:FindFirstChild("Backpack") then

								local backpackItems = targetPlayer.Backpack:GetChildren()

								local itemNames = {}



								for _, v in ipairs(backpackItems) do

									table.insert(itemNames, v.Name)

								end



								local itemList = table.concat(itemNames, ", ")

								if #itemList > 0 then

									Library:Notify("Backpack items: " .. itemList, 10)

								else

									Library:Notify("The target player's Backpack is empty.", 10)

								end

							else

								Library:Notify("The target player does not have a Backpack.")

							end

						else

							Library:Notify("Target player not found.")

						end

					else

						Library:Notify("No target assigned.")

					end

				end

			end

		})











		--if not game.Players.LocalPlayer.Backpack:FindFirstChild("Fist") then

		--	return Library:Notify("[SleepyHub] - No Fist found", 3)

		--end



		--if not game.Players.LocalPlayer.Character:FindFirstChild("Fist") then

		--	game.Players.LocalPlayer.Backpack.Fist.Parent = game.Players.LocalPlayer.Character

		--end



		--local targetPlayer = game.Players[Target]

		--if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then

		--	return Library:Notify("[SleepyHub] - Target player not available", 3)

		--end



		--local dead = targetPlayer.Character.Humanoid.Health < 1



		--while not dead do

		--	RootPart().CFrame = targetPlayer.Character.HumanoidRootPart.CFrame -- * CFrame.new(0, 0, 0.2)

		--	game.Players.LocalPlayer.Character.Fist.MeleeSystem.AttackEvent:FireServer()



		--	dead = targetPlayer.Character.Humanoid.Health < 1

		--	task.wait(0.40)

		

		ExploitsTab:AddLabel(

    'How to use the Dupe exploit:\n' ..

    '\n' ..

    '1. Click "Dupe."\n' ..

    '2. Drop your tools and give everything to someone.\n' ..

    '3. Go to settings and click "Rejoin."\n' ..

    '4. After rejoining, you should still have everything.\n\n' ..

    'Note: There are no limits you can dupe as much as you want.',

    true

)

		



local InfMoney = ExploitsTab:AddButton({

    Text = 'Dupe vulnerability',

    Func = function()

		if game:GetService("ReplicatedStorage"):WaitForChild("WalkRemote") and game:GetService("ReplicatedStorage"):WaitForChild("IdleRemote") then 

			print("hooking invk", pcall(function()

				local p = string.rep([[

					Ǆ

					

					؁

					

					‱

					

					ஹ

					

					௸

					

					௵

					

					꧄

					

					.

					

					ဪ

					

					꧅

					

					⸻

					

					𒈙

					

					𒐫

					

					﷽

					

					

					𒌄

					

					𒈟

					

					𒍼

					

					𒁎

					

					𒀱

					

					𒌧

					

					𒅃 𒈓

					

					𒍙

					

					𒊎

					

					𒄡

					

					𒅌

					

					𒁏

					

					𒀰

					

					𒐪

					

					𒐩

					

					𒈙

					

					𒐫

					

					

					𱁬 84

					

					𰽔 76

					

					𪚥 64

					

					䨻 52

					

					龘 48

					

					䲜 44

					

					       á́́

					 ͩͩͩ 𓀐𓂸

					

					😃⃢👍༼;´༎ຶ ۝ ༎ຶ༽

					]], 10000)

					game:GetService("ReplicatedStorage"):WaitForChild("IdleRemote"):FireServer(p)

 				  game:GetService("ReplicatedStorage"):WaitForChild("WalkRemote"):FireServer(p)

			end))

Library:Notify("Dupe Loading this can take up to 30 seconds", 20)

            task.wait(20)

			Library:Notify("Dupe V2 activated ✅", 3)

		end

    end,

    DoubleClick = false,

    Tooltip = nil

})





ExploitsTab:AddDivider()



		function checkgun()

			local player = game.Players.LocalPlayer

			local gunTool = nil



			for _, v in pairs(player.Backpack:GetDescendants()) do

				if v:IsA("LocalScript") and v.Name == "GunScript_Local" then

					gunTool = v.Parent

					break

				end

			end



			if not gunTool and player.Character then

				for _, v in pairs(player.Character:GetDescendants()) do

					if v:IsA("LocalScript") and v.Name == "GunScript_Local" then

						gunTool = v.Parent

						break

					end

				end

			end



			if gunTool and gunTool:IsA("Tool") then

				game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(gunTool)

				print("Gun equipped:", gunTool.Name)

			else

				print("Gun not found.")

			end



			return gunTool

		end





		ExploitsTab:AddButton('Kill All', function()

			if not checkgun() then

				Library:Notify("No Gun found", 3)

				return

			end







			for _, v in pairs(game.Players:GetChildren()) do

				if v ~= game.Players.LocalPlayer and v.Character and v.Character.Head then

					pcall(function()

						dmg(v, "Head", 1000)

						dmg(v, "Head", 1000)

						dmg(v, "Head", 1000)

					end)

				end

			end

		end)



		function getcar()

			local plrname = game.Players.LocalPlayer.Name

		

			for i, v in pairs(workspace.CivCars:GetDescendants()) do 

				if v:IsA("Model") and v:FindFirstChild("Owner") then

					 if v.Owner.Value == plrname then 

						warn(v)

						return v

					end

				end

			end

		end



 local DupeMethodDropdown = ExploitsTab:AddDropdown('DupeMethod', {

    Values = { 'Default', 'Safe' },  

    Default = 1,  

    Multi = false,  



    Text = 'Select Dupe Method',

    Tooltip = nil,



    Callback = function(Value)

        print('[Dropdown] Selected Method:', Value)

    end

})



 local GunDupe = ExploitsTab:AddButton({

    Text = 'Dupe Tools',

    Func = function()

        local SelectedMethod = Options.DupeMethod.Value -- Get the selected dropdown value

		Library:Notify("Remember: There is a cooldown of 30 seconds", 3)

        if SelectedMethod == 'Default' then

            -- Default method logic

            local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))

            local Players = cloneref(game:GetService('Players'))



            local Tool = tostring(Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"))

            Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools()



			if not getcar() then 

				return Library:Notify("[SleepyHub] - No Car spawned, spawn a car to use this feature", 5)

			end



            local DisableMarketGui = Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(Child)

                task.wait()

                Child:Destroy()

            end)



            if Tool == "nil" then

                return Library:Notify("[SleepyHub] - No Tool found", 5)

            end

            task.wait()



			BypassTp(getcar().Body:FindFirstChild("TrunckStorage").CFrame)

            

            

			task.spawn(function(...)  

			   game.ReplicatedStorage.BackpackRemote:InvokeServer("Store",Tool)

   end)

  

   task.spawn(function(...)  

			   game.ReplicatedStorage.ListWeaponRemote:FireServer(Tool,50000)

					  game:GetService("ReplicatedStorage").TrunkStorage:FireServer("Store", Tool)

		   end)





		   task.wait(2)



		   task.spawn(function()

		   

			   game.ReplicatedStorage.BuyItemRemote:FireServer(Tool,"Remove")

		   end)

		   task.spawn(function(...)

	  game:GetService("ReplicatedStorage").TrunkStorage:FireServer("Grab", Tool)

	  end)



	  task. spawn(function()

			   game.ReplicatedStorage.BackpackRemote:InvokeServer("Grab",Tool)

		   end)



		   task.wait(1)



            DisableMarketGui:Disconnect()



        elseif SelectedMethod == 'Safe' then

            -- Safe method logic

            print("[GunDupe] - Safe Method Selected.")



            local Players = game:GetService("Players")

            local Workspace = game:GetService("Workspace")

            local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))



            local InventoryRemote = ReplicatedStorage:WaitForChild("Inventory")

            local BackpackRemote = ReplicatedStorage:WaitForChild("BackpackRemote")



            function GetCharacter()

                return game:GetService("Players").LocalPlayer.Character

            end



			function Teleport(CFrame1)

				GetCharacter().HumanoidRootPart.CFrame = CFrame.new(CFrame1.Position.X + 2, CFrame1.Position.Y, CFrame1.Position.Z)

			end

			



            if GetCharacter():FindFirstChildOfClass("Tool") then

                local GunName = GetCharacter():FindFirstChildOfClass("Tool").Name



                GetCharacter():FindFirstChildOfClass("Humanoid"):UnequipTools()



                local Safe = workspace["1# Map"]["2 Crosswalks"].Safes:GetChildren()[5]

                local OldCFrame = GetCharacter():FindFirstChild("HumanoidRootPart").CFrame



                BypassTp(Safe.Union.CFrame)



                wait(0.5)



                task.spawn(function()

                    BackpackRemote:InvokeServer("Store", GunName)

                end)



                task.spawn(function()

                    InventoryRemote:FireServer("Change", GunName, "Backpack", Safe)

                end)



                wait(0.5)

                BypassTp(OldCFrame)



                wait(1.2)



                BackpackRemote:InvokeServer("Grab", GunName)



				if not Toggles.StoreDupe.Value then

					InventoryRemote:FireServer("Change", GunName, "Inv", Safe)  

				end



                wait(0.5)

                BypassTp(OldCFrame)

            end

        else

            print("[GunDupe] - Invalid Method Selected.")

        end

    end,

    DoubleClick = false,

    Tooltip = nil

})



ExploitsTab:AddToggle('GotoSafe', {

    Text = 'Goto Safe',

    Default = false,  

    Tooltip = nil, 



    Callback = function(Value)

		local Safe = workspace["1# Map"]["2 Crosswalks"].Safes:GetChildren()[5]

		if Value then 

			BypassTp(CFrame.new(Safe.Union.CFrame.Position.X, Safe.Union.CFrame.Position.Y + 0.5, Safe.Union.CFrame.Position.Z))

			Toggles.GotoSafe:SetValue(false)

		 end

    end

})



ExploitsTab:AddToggle('StoreDupe', {

    Text = 'Store Duped tool in Safe',

    Default = true,  

    Tooltip = nil, 



    Callback = function(Value)

        Toggles.StoreDupe:SetValue(Value)  

    end

})

 





		-- local DupeInventory = ExploitsTab:AddButton({

		-- 	Text = 'Dupe Entire Inventory [BETA]',

		-- 	Func = function()

		-- 		Library:Notify("[SleepyHub] - This feature is not 100% accurate and will be fixed.", 5)

		-- 		local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))

		-- 		local Players = cloneref(game:GetService('Players'))

		

		-- 		local Player = Players.LocalPlayer

		-- 		local Backpack = Player.Backpack

		-- 		local ToolsToDupe = {}

		-- 		local ToolInstancesSet = {}

		

		-- 		for _, item in pairs(Backpack:GetChildren()) do

		-- 			if item:IsA("Tool") and item.Name ~= "Fist" and item.Name ~= "Phone" then

		-- 				if not ToolInstancesSet[item] then

		-- 					table.insert(ToolsToDupe, item)

		-- 					ToolInstancesSet[item] = true

		-- 				end

		-- 			end

		-- 		end

		

		-- 		if #ToolsToDupe == 0 then

		-- 			return Library:Notify("[SleepyHub] - No Tools to duplicate", 5)

		-- 		end

		

		-- 		local DisableMarketGui = Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(Child)

		-- 			task.wait()

		-- 			Child:Destroy()

		-- 		end)

		

		-- 		for _, Tool in pairs(ToolsToDupe) do

		-- 			local ToolName = Tool.Name

		-- 			task.wait(1)

		

		-- 			spawn(function()

		-- 				ReplicatedStorage.BackpackRemote:InvokeServer("Store", ToolName)

		-- 			end)

		

		-- 			spawn(function()

		-- 				ReplicatedStorage.ListWeaponRemote:FireServer(ToolName, 50000)

		-- 			end)

		

		-- 			task.wait(2)

		

		-- 			spawn(function()

		-- 				ReplicatedStorage.BuyItemRemote:FireServer(ToolName, "Remove")

		-- 			end)

		

		-- 			spawn(function()

		-- 				ReplicatedStorage.BackpackRemote:InvokeServer("Grab", ToolName)

		-- 			end)

		-- 		end

		

		-- 		task.wait(1)

		

		-- 		DisableMarketGui:Disconnect()

		-- 		Library:Notify("[SleepyHub] - Inventory Duplication Complete", 5)

		-- 	end,

		-- 	DoubleClick = false,

		-- 	Tooltip = nil

		-- })

		





		game.Players.LocalPlayer.CharacterAdded:Connect(function(char)

			char:WaitForChild("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function()

				local humanoid = char:FindFirstChildWhichIsA("Humanoid")

				if humanoid and humanoid.Health < getgenv().sca and getgenv().autore and not deb then

					deb = true

					safe()

					task.wait(1)

					deb = false

				end

			end)

		end)



		ExploitsTab:AddInput('[Retreat HP]', {

			Default = '[Number]',

			Numeric = true,

			Finished = true,

			Text = '[Retreat HP]',

			Placeholder = '[Number]',

			Callback = function(Value)

				local sigma = tonumber(Value)

				if sigma > 50 then

					game:GetService("StarterGui"):SetCore("SendNotification", {

						Title = "⚠️",

						Text = "Do not set the value over 50!"

					})

					return

				end

				getgenv().sca = sigma

			end

		})



		local w = ExploitsTab:AddToggle('Auto-Retreat', {

			Text = 'Auto-Retreat',

			Default = false,

			Callback = function(Value)

				getgenv().autore = Value

				if Value then

					game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function()

						local char = game.Players.LocalPlayer.Character

						local humanoid = char and char:FindFirstChildWhichIsA("Humanoid")

						if humanoid and humanoid.Health < getgenv().sca and not deb then

							deb = true

							safe()

							task.wait(1)

							deb = false

						end

					end)

				end

			end

		})



		w:AddKeyPicker('Enable Auto-Retreat', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Hides when you are on low HP',

			NoUI = false,

		})







		local antik = ExploitsTab:AddToggle('Anti-Knockback', {

			Text = 'Anti-Knockback',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				getgenv().knc = Value



				if getgenv().knc then

					while getgenv().knc do

						task.wait(0.1)



						pcall(function()

							for _, v in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do

								if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") or v:IsA("VectorForce") then

									v:Destroy()

								end

							end

						end)

					end



					if game.ReplicatedStorage:FindFirstChild("AE") then

						game.ReplicatedStorage.AE:Destroy()

					end



					game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").ChildAdded:Connect(function(des)

						if getgenv().knc then

							if des:IsA("BodyVelocity") or des:IsA("LinearVelocity") or des:IsA("VectorForce") then

								des:Destroy()

							end

						end

					end)

				else

					for _, v in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do

						if v:IsA("BodyVelocity") or v:IsA("LinearVelocity") or v:IsA("VectorForce") then

							v:Destroy()

						end

					end

				end

			end

		})









		antik:AddKeyPicker('Enable Anti-Knockback', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Stops you from being pushed / knockback',

			NoUI = false,

		})







		getgenv().knc = false

		getgenv().gm = false



		local gm = ExploitsTab:AddToggle('God Mode [NEW!]', {

			Text = 'God Mode [NEW!]',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				getgenv().gm = Value

				while getgenv().gm and task.wait() do

					local ohNumber1 = -9e9

					game:GetService("ReplicatedStorage").FSpamRemote:FireServer()

					game:GetService("ReplicatedStorage").DamagePlayer:InvokeServer(ohNumber1)

				end

			end

		})



		gm:AddKeyPicker('Enable God Mode', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates God Mode',

			NoUI = false,

		})



		local AutoPickUp 

		local pickuptools = ExploitsTab:AddToggle('WalkSpeed', {

		Text = 'Auto Pickup Tools',

		Default = false,

		Tooltip = nil, 

		Callback = function(Value)

		local g = game.Workspace

		AutoPickUp = Value

		task.spawn(function()

			while AutoPickUp do

				task.wait()

				for fk, fl in pairs(g:GetChildren()) do

					if fl:IsA("Tool") then

						if fl.Name ~= "Phone" and fl.Name ~= "Crate" then

							game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(fl)

						end

					end

				end

			end

		end)

		end

		})



		pickuptools:AddKeyPicker('Steal tools', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates pickup tools',

			NoUI = false,

		})













		local RepostAllButton = ExtraTab:AddButton({

			Text = 'Repost All',

			Func = function()

				TwitterAll("Repost")

			end,

			DoubleClick = false,

			Tooltip = nil

		})



		RepostAllButton:AddButton({

			Text = 'Heart All',

			Func = function()

				TwitterAll("Liked")

			end,

			DoubleClick = false,

			Tooltip = nil

		})



		local RepostOwn = ExtraTab:AddButton({

			Text = 'Repost Own',

			Func = function()

				TwitterMe("Repost")

			end,

			DoubleClick = false,

			Tooltip = nil

		})



		RepostOwn:AddButton({

			Text = 'Heart Own',

			Func = function()

				TwitterMe("Liked")

			end,

			DoubleClick = false,

			Tooltip = nil

		})







		ExtraTab:AddInput('[Deposit Cash]', {

			Default = '[Deposit Cash]',

			Numeric = false,

			Finished = true,

			Text = 'Deposit Cash',

			Tooltip = nil,

			Placeholder = 'Enter cash you want to deposit',



			Callback = function(text)

				local ohString1 = "depo"

				local ohString2 = tonumber(text)



				game:GetService("ReplicatedStorage").BankAction:FireServer(ohString1, ohString2)

			end

		})



		ExtraTab:AddInput('[Withdraw Cash]', {

			Default = '[Withdraw Cash]',

			Numeric = false,

			Finished = true,

			Text = 'Withdraw Cash',

			Tooltip = nil,

			Placeholder = 'Enter cash you want to withdraw',



			Callback = function(text)

				local ohString1 = "with"

				local ohString2 = tonumber(text)



				game:GetService("ReplicatedStorage").BankAction:FireServer(ohString1, ohString2)

			end

		})



		



		local GunMarket = ExtraTab:AddButton('Gun Market', function()

			local playerGui = game:GetService("Players").LocalPlayer.PlayerGui

			if playerGui:FindFirstChild("Bronx Market 2") then

				playerGui["Bronx Market 2"].Enabled = true

			else

				Library:Notify('Gun Market GUI not found', 3)

			end

		end)



		GunMarket:AddButton('Exotic Shop', function()

			local playerGui = game:GetService("Players").LocalPlayer.PlayerGui

			if playerGui:FindFirstChild("Exotic Shop") then

				playerGui["Exotic Shop"].Enabled  = true

			else

				Library:Notify('Exotic Shop GUI not found', 3)

			end

		end)



		local tattoo = ExtraTab:AddButton('Tattoo shop', function()

			local playerGui = game:GetService("Players").LocalPlayer.PlayerGui

			if playerGui:FindFirstChild("Bronx TATTOOS") then

				playerGui["Bronx TATTOOS"].Enabled  = true

			else

				Library:Notify('Bronx tattoo GUI not found', 3)

			end

		end)



		tattoo:AddButton('Pawn shop', function()

			local playerGui = game:GetService("Players").LocalPlayer.PlayerGui

			if playerGui:FindFirstChild("Bronx PAWNING") then

				playerGui["Bronx PAWNING"].Enabled  = true

			else

				Library:Notify('Bronx pawn GUI not found', 3)

			end

		end)



		local trunkstorage = ExtraTab:AddButton('Trunk Storage', function()

			local playerGui = game:GetService("Players").LocalPlayer.PlayerGui

			if playerGui:FindFirstChild("TRUNK STORAGE") then

				playerGui["TRUNK STORAGE"].Enabled  = true

			else

				Library:Notify('Trunk Storage GUI not found', 3)

			end

		end)

		















		local AutoGun = GunTab:AddButton({

			Text = 'Automatic-Gun',

			Func = function()

				if not supportsRequire() then

					Library:Notify("[SleepyHub] - Your executor doesn't support this. We recommend using Wave/Synapse-Z", 5)

					return

				end

				require(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Setting).Auto = true

			end,

			DoubleClick = false,

			Tooltip = nil

		})









		AutoGun:AddButton({

			Text = 'No-Fire-Rate',

			Func = function()

				if not supportsRequire() then

					Library:Notify("[SleepyHub] - Your executor doesn't support this. We recommend using Wave/Synapse-Z", 5)

					return

				end

				require(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Setting).FireRate = 0

			end,

			DoubleClick = false,

			Tooltip = nil

		})



		local InfDamage = GunTab:AddButton({

			Text = 'Inf-Damage',

			Func = function()

				if not supportsRequire() then

					Library:Notify("[SleepyHub] - Your executor doesn't support this. We recommend using Wave/Synapse-Z", 5)

					return

				end

				require(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Setting).BaseDamage = 9e9

			end,

			DoubleClick = false,

			Tooltip = nil

		})







		InfDamage:AddButton({

			Text = 'No-Recoil',

			Func = function()

				if not supportsRequire() then

					Library:Notify("[SleepyHub] - Your executor doesn't support this. We recommend using Wave/Synapse-Z", 5)

					return

				end

				require(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Setting).Recoil = 0

			end,

			DoubleClick = false,

			Tooltip = nil

		})







		local infammo = GunTab:AddButton({

			Text = 'Infinite-Ammo',

			Func = function()

				if not supportsRequire() then

					Library:Notify("[SleepyHub] - Your executor doesn't support this. We recommend using Wave/Synapse-Z", 5)

					return

				end

				require(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Setting).LimitedAmmoEnabled = false

				require(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Setting).MaxAmmo = 9e9

				require(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Setting).AmmoPerMag = 9e9

				require(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Setting).Ammo = 9e9

			end,

			DoubleClick = false,

			Tooltip = nil

		})



		-- local SELECTEEDGUN = nil



		-- function GetGuns() 

		-- 	local Table = {}

		-- 	for i, v in next, game:GetService("Players").LocalPlayer.Character:GetChildren() do 

		-- 		if v:IsA("Tool") and v:FindFirstChild("GunScript_Local") then 

		-- 			table.insert(Table, tostring(v))

		-- 		end    

		-- 	end



		-- 	for _, Gun in next, game:GetService("Players").LocalPlayer.Backpack:GetChildren() do 

		-- 		if Gun:IsA("Tool") and Gun:FindFirstChild("GunScript_Local") then 

		-- 			table.insert(Table, tostring(Gun))

		-- 		end    

		-- 	end    

		-- 	return Table

		-- end



		-- local HAHAHXRO = GunTab:AddDropdown('Select Weapon', {

		-- 	Values = GetGuns(),

		-- 	Default = 1,

		-- 	Multi = false,

		-- 	Text = 'Select Weapon',

		-- 	Tooltip = 'Select Weapon',

		-- 	Callback = function(Value)

		-- 		SELECTEEDGUN = Value

		-- 	end

		-- })



		-- HAHAHXRO:OnChanged(function()

		-- 	HAHAHXRO:SetValues(GetGuns())

		-- end)



		-- function GetModsItem()

		-- 	local Table = {}

		-- 	local Tool = SELECTEEDGUN

		-- 	if Tool ~= nil then 

		-- 		if Tool:FindFirstChild("Setting") then 

		-- 			for i, v in next, require(Tool:FindFirstChild("Setting")) do

		-- 				table.insert(Table, i)

		-- 			end    

		-- 		end

		-- 	end

		-- 	return Table

		-- end



		-- local SelectedMod = nil

		-- local MODS = GunTab:AddDropdown('Custom Gun Mods', {

		-- 	Values = {"Select Gun"},

		-- 	Default = 1,

		-- 	Multi = false,

		-- 	Text = 'Custom Gun Mods',

		-- 	Tooltip = 'Custom Gun Mods',

		-- 	Callback = function(Value)

		-- 		SelectedMod = Value

		-- 	end

		-- })



		-- HAHAHXRO:OnChanged(function()

		-- 	if SELECTEEDGUN ~= nil then

		-- 		MODS:SetValues(GetModsItem())

		-- 	end

		-- end)







		local d = TeleportTab:AddDropdown('PlayerDropDownReal', {

			SpecialType = 'Player',

			Text = 'Teleport-To-Player',

			Tooltip = nil, -- Information shown when you hover over the dropdown

			Callback = function(Value)

				BypassTp(game.Players[Value].Character.HumanoidRootPart.CFrame)

			end

		})



		task.spawn(function()

			while task.wait(2) do

				d:SetValues(players)

			end

		end)







		-----------------------------------





		local Locations = {

			["🏁 Spawn Location 1"] = CFrame.new(-357.28680419921875, 279.954833984375, -1177.158935546875),

			["🏁 Spawn Location 2"] = CFrame.new(-1495.0098876953125, 249.88446044921875, -1235.8638916015625),

			["🏁 Spawn Location 3"] = CFrame.new(-999.2591552734375, 250.5908203125, -1065.420166015625),

			["🏢 Roof"] = CFrame.new(-363, 340, -559),

			["🔫 Gun Store [1]"] = CFrame.new(92995, 122098, 17023),

			["🔫 Gun Store [2]"] = CFrame.new(66190, 123616, 5744),

			["🏢 Pent House"] = CFrame.new(-63, 283, -574),

			["🌴 Exotic"] = CFrame.new(-1525, 273, -984),

			["🌿 Weed"] = CFrame.new(-633, 253, -731),

			["❄️ Ice Box (Robbery)"] = CFrame.new(-150, 284, -1258),

			["🌱 Plant Job"] = CFrame.new(-1541, 282, -987),

			["🍚 Rice Job"] = CFrame.new(51375, 21680, 5842),

			["🎉 Party Host"] = CFrame.new(-897, 253, -746),

			["🎥 Studio"] = CFrame.new(-984, 253, -535),

			["🎨 Tattoo Shop"] = CFrame.new(-712.4014282226562, 252.9751434326172, -519.5180053710938),

			["🎥 Studio (Robbery)"] = CFrame.new(93423, 14485, 561),

			["🏠 Rob House [1]"] = CFrame.new(-605, 258, -698),

			["🏠 Rob House [2]"] = CFrame.new(-605, 258, -724),

			["🎰 Casino"] = CFrame.new(92173, 121858, -16113),

			["🏀 Basketball Court"] = CFrame.new(-1056, 254, -496),

			["🏀 Basketball Court [2]"] = CFrame.new(-359, 254, -938),

			["🏦 Bank Vault"] = CFrame.new(-122, 374, -1216),

			["💵 Clean Money"] = CFrame.new(-997, 254, -691),

			["🌱 Plant Buyer"] = CFrame.new(-636, 253, -731),

			["💻 Laptop Job"] = CFrame.new(-1017, 253, -249),

			["🚗 Car Shop"] = CFrame.new(-346, 255, -1246),

			["🛠️ Sewer"] = CFrame.new(81112, 133133, 149),

			["🛡️ Safe Spot"] = CFrame.new(544, 283, -807),

			["🧹 Mop Job"] = CFrame.new(-729, 254, -778),

			["🏢 Regular Apartment"] = CFrame.new(-63, 283, -527),

			["🏚️ Trash Apartment"] = CFrame.new(68443, 52941, -736),

			["🏦 Bank"] = CFrame.new(-109, 374, -1215),

		}



		local locationKeys = {

			"🏁 Spawn Location 1",

			"🏁 Spawn Location 2",

			"🏁 Spawn Location 3",

			"🏢 Roof",

			"🔫 Gun Store [1]",

			"🔫 Gun Store [2]",

			"🏢 Pent House",

			"🌴 Exotic",         

			"🌿 Weed Dealer",

			"❄️ Ice Box (Robbery)",

			"🌱 Plant Job",

			"🍚 Rice Job",

			"🎉 Party Host",

			"🎥 Studio",

			"🎨 Tattoo Shop",

			"🎥 Studio (Robbery)",

			"🏠 Rob House [1]",

			"🏠 Rob House [2]",

			"🎰 Casino",

			"🏀 Basketball Court",

			"🏀 Basketball Court [2]",

			"🏦 Bank Vault",

			"💵 Clean Money",

			"🌱 Plant Buyer",

			"💻 Laptop Job",

			"🚗 Car Shop",

			"🛠️ Sewer",

			"🛡️ Safe Spot",

			"🧹 Mop Job",

			"🏢 Regular Apartment",

			"🏚️ Trash Apartment",

			"🏦 Bank"

		}



		TeleportTab:AddDropdown('PlayerDrpDown', {

			Values = locationKeys,

			Default = 1,

			Multi = false,

			Text = 'Teleport to Locations',

			Tooltip = nil,

			Callback = function(selectedValue)

				BypassTp(Locations[selectedValue])

			end

		})







		local track

		local track2

		local track3

		local track4

		local anim1 = AnimationTab:AddToggle('Play Carrying Animation ', {

			Text = 'Carrying Animation',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				if Value then

					track = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").BeingCarried)

					track:Play()

				elseif not Value then

					track:Stop()

				end

			end

		})

		anim1:AddKeyPicker('Carrying Animation', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates Carrying Animation',

			NoUI = false,

		})



		local anim2 = AnimationTab:AddToggle('Play Low HP Animation ', {

			Text = 'Low HP Animation',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				if Value then

					track2 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").LowHealthAnim)

					track2:Play()

				elseif not Value then

					track2:Stop()

				end

			end

		})

		anim2:AddKeyPicker('Low HP Animation', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates Low HP Animation',

			NoUI = false,

		})





		local anim4 = AnimationTab:AddToggle('Play Cuffing Animation ', {

			Text = 'Cuffing Animation',

			Default = false,

			Tooltip = nil,

			Callback = function(Value)

				if Value then

					track4 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game:GetService("ReplicatedStorage").cuffed)

					track4:Play()

				elseif not Value then

					track4:Stop()

				end

			end

		})

		anim4:AddKeyPicker('Cuffing Animation', {

			Default = '',

			SyncToggleState = true,

			Mode = 'Toggle',

			Text = 'Activates Cuffing Animation',

			NoUI = false,

		})











		-- Adding an input field for Music ID

		MusicTab:AddInput('MusicId', {

			Default = 'Music Id',

			Numeric = true,

			Finished = true,

			Text = 'Play FE Music',

			Tooltip = nil,

			Placeholder = 'Paste Music Id Here',



			-- Callback function to store the input value in a global variable

			Callback = function(Value)

				getgenv().MusicId = Value

			end

		})





		getgenv().AudioVolume = 100

		getgenv().PitchVolume = 1

		local PlayAudio = MusicTab:AddButton({

			Text = 'Play Audio',

			Tooltip = nil,

			Func = function()

				if getgenv().MusicId then

					for _, v in pairs(game.Players:GetPlayers()) do

						if v.Character and v.Character:FindFirstChild("Head") then

							-- remote

							local ohString1 = "}0, { \n\n } "

							local ohString2 = "}, { "

							local ohTable3 = {

								["Pitch"] = 1,

								["Position"] = v.Character.Head.Position,  -- Set position to each player's head position

								["EmitterSize"] = 10.934677124023438,

								["SoundId"] = "rbxassetid://" .. getgenv().MusicId,

								["Replicate"] = true,

								["Volume"] = getgenv().AudioVolume,

								["Effects"] = false

							}



							game:GetService("ReplicatedStorage").PlayAudio:FireServer(ohString1, ohString2, ohTable3)

						end

					end

				else

					Library:Notify("[SleepyHub] - No Music ID provided. Please enter a Music ID", 5)

				end

			end,

		})







		MusicTab:AddButton({

			Text = 'Replay Audio',

			Tooltip = nil,

			Func = function()

				if getgenv().MusicId then

					for _, v in pairs(game.Players:GetPlayers()) do

						if v.Character and v.Character:FindFirstChild("Head") then

							-- remote

							local ohString1 = "}0, { \n\n } "

							local ohString2 = "}, { "

							local ohTable3 = {

								["Pitch"] = 1,

								["Position"] = v.Character.Head.Position,

								["EmitterSize"] = 10.934677124023438,

								["SoundId"] = "rbxassetid://" .. getgenv().MusicId,

								["Replicate"] = true,

								["Volume"] = getgenv().AudioVolume,

								["Effects"] = false

							}





							game:GetService("ReplicatedStorage").PlayAudio:FireServer(ohString1, ohString2, ohTable3)

						end

					end

				else

					Library:Notify("[SleepyHub] - No Music ID provided. Please enter a Music ID before replaying", 5)

				end

			end,

		})









		MusicTab:AddSlider('AudioVolume', {

			Text = 'Audio Volume',

			Default = 100,

			Min = 1,

			Max = 1000,

			Rounding = 1,

			Compact = false,



			Callback = function(Value)

				getgenv().AudioVolume = Value

			end

		})



		MusicTab:AddSlider('PitchVolume', {

			Text = 'Pitch Volume',

			Default = 1,

			Min = 1,

			Max = 1000,

			Rounding = 1,

			Compact = false,



			Callback = function(Value)

				getgenv().PitchVolume = Value

			end

		})

















		



		-----------------------------------





		



	







		

		AutofarmTab:AddDivider()





		function LootTrashPrompt()

			for i, v in pairs(workspace:GetDescendants()) do

				if v:IsA("ProximityPrompt") and v.Name == "ProximityPrompt" then

					if v.Parent.Name == "DumpsterPromt" then

						v.HoldDuration = 0

						v.RequiresLineOfSight = false

					end

				end

			end

		end

		AutofarmTab:AddToggle('LootTrash', {

            Text = 'Loot Trash',

            Default = false,

            Tooltip = nil,

            Callback = function(Value)

                loottrash = Value

                antifalldmg()

				antiragdoll()

                if loottrash then

                    LootTrashPrompt()

                end

        

                while loottrash do

                    task.wait()

        

                    for i, v in pairs(workspace:GetDescendants()) do

                        if v:IsA("ProximityPrompt") and v.Name == "ProximityPrompt" and v.Parent.Name == "DumpsterPromt" then

						

                            BypassTp(CFrame.new(v.Parent.CFrame.Position.X, v.Parent.CFrame.Position.Y + 0.2, v.Parent.CFrame.Position.Z + 3),false)

							Camera.CFrame = CFrame.new(Camera.CFrame.Position, v.Parent.CFrame.Position)

							task.wait(0.3)

							for i = 1, 10 do

						

                            fireproximityprompt(v)

							end

                       task.wait(0.1)

                            if not loottrash then

                                Toggles.LootTrash:SetValue(false)

                                break

                            end

                        end

                    end

                end

        

                if Value then

					BypassTp(GetLocalPlayer().Character.HumanoidRootPart.CFrame,true)

                    Toggles.LootTrash:SetValue(false)

                end

            end

        })

        

		





		local items = {

			"Bag",

			"Screwdriver",

			"MediumRice",

			"C FnBody1",

			"C G26Body1",

			"C UziBase1",

			"C G26Body2",

			"C G22Body2",

			"C G22Body1",

			"C AxeBody1",

			"Shiesty",

			"Cleaver",

			"C UziStock3",

			"Card",

			"C AxeBody2",

			"C UziStock2",

			"C FNBody2",

		}







		AutofarmTab:AddToggle('AutoSell', {

			Text = 'Auto Sell',

			Default = false,

			Tooltip = nil,



			Callback = function(Value)

				if Value then 

					for _, Value in next, game.Players.LocalPlayer.PlayerGui["Bronx PAWNING"].Frame.Holder.List:GetChildren() do

						if not Value:IsA("Frame") then

							continue

						end

		

						local Index = Value.Item.Text

		

						while game.Players.LocalPlayer.Backpack:FindFirstChild(Index) do

							game:GetService("ReplicatedStorage").PawnRemote:FireServer(Index); wait(0) 

						end

					end

				end

			end

		})







		AutofarmTab:AddDivider()



		function dirtysex()

			for i,v in pairs(workspace["Janitor Bucket"].ProxPart:GetDescendants()) do

				if v:IsA("ProximityPrompt") then

					v.HoldDuration = 0

					v.RequiresLineOfSight = false

				end

			end

		end



		function dirtysex2()

			for i,v in pairs(workspace.DirtPiles:GetDescendants()) do

				if v:IsA("ProximityPrompt") then

					v.HoldDuration = 0

					v.RequiresLineOfSight = false

				end

			end

		end



		function getgun()

			return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name

		end



		function getpaint(p)

			for i,v in next, p:GetDescendants() do

				if v:FindFirstChild("Paint") then

					return v

				end

			end

		end





 		local bucket = workspace["Janitor Bucket"].ProxPart

        AutofarmTab:AddToggle("RawMopAutofarm", {

            Text = "Mop Autofarm",

            Default = false,

            Tooltip = nil,

        }):OnChanged(function(state)

            getgenv().rawMopAutofarm = state

        

            function interactWithPrompt(part)

                local prompt = part:FindFirstChildWhichIsA("ProximityPrompt")

                if prompt and prompt.Enabled then

					dirtysex2()

					dirtysex()

					antifalldmg()

					antiragdoll()

                    for i = 1, 9 do

                        if not getgenv().rawMopAutofarm then return end

                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, part.CFrame.Position)

                        fireproximityprompt(prompt)

                        task.wait(0.1)

                    end

                end

            end

        

            function MopFarm()

                while getgenv().rawMopAutofarm do

                    if bucket then

                        BypassTp(CFrame.new(bucket.CFrame.Position.X - 3, bucket.CFrame.Position.Y + 0,2, bucket.CFrame.Position.Z))

                        interactWithPrompt(bucket)

                    end

        

                    for _, dirt in ipairs(workspace.DirtPiles:GetChildren()) do

                        if not getgenv().rawMopAutofarm then return end

                        if dirt:IsA("BasePart") and dirt:FindFirstChild("Attachment") then

                            local attachment = dirt.Attachment

                            local dirtPrompt = attachment:FindFirstChildWhichIsA("ProximityPrompt")

                            if dirtPrompt and dirtPrompt.Enabled then

                                BypassTp(CFrame.new(dirt.CFrame.Position.X, dirt.CFrame.Position.Y + 3.3, dirt.CFrame.Position.Z))

                                interactWithPrompt(attachment)

                                task.wait(7.2) 

                            end

                        end

                    end

        

                    task.wait(1) 

                end

            end

        

            if getgenv().rawMopAutofarm then

                local success, err = pcall(MopFarm)

                if not success then

                    warn("Error during mopfarm:", err)

                end

            end

        end)

        

        





		AutofarmTab:AddDivider()





		-- function SpawnedMoney()

		--     for i, v in pairs(wworkspace.HouseRobb.HardDoor.TakeMoney:GetDescendants()) do

		--         if v:IsA("ProximityPrompt") and v.Name == "ProximityPrompt" then

		--             if v.Enabled == true then

		--                 return true --means

		--             end

		--         end

		--     end

		--     return false -- If no enabled ProximityPrompt is found, return false

		-- end





		local Houseleft = {}

		local Houseright = {}

		

		local targetPosition = Vector3.new(-615, 254, -695)

		local tolerance = 1

		

		function updateDoors()

			table.clear(Houseleft)

			table.clear(Houseright)

		

			for i, v in pairs(workspace.HouseRobb:GetDescendants()) do

				if (v.Name == "WoodenDoor" or v.Name == "HardDoor") and v:IsA("BasePart") and v:FindFirstChild("ProximityPrompt") then

				

					if (v.Position - targetPosition).Magnitude <= 10 then

						 Houseright[v.Name] = v

					  

					else

						Houseleft[v.Name] = v

					end

				end

			end

		end

		

		updateDoors()

		

		

				function HouseRobPrompts()

					for i, v in pairs(workspace.HouseRobb:GetDescendants()) do

						if v:IsA("ProximityPrompt") and v.Name == "ProximityPrompt" then

							v.HoldDuration = 0

							v.RequiresLineOfSight = false

							v.Enabled = false

						end

					end

				end

		

				AutofarmTab:AddToggle('RobHouse', {

					Text = 'Rob Houses',

					Default = false,

					Tooltip = nil,

				

					Callback = function(Value)

						RobHouse = Value

						local player = game.Players.LocalPlayer

						local OldCframe = player.Character.HumanoidRootPart.CFrame

				

						if RobHouse then

							HouseRobPrompts()

						end

				

						while RobHouse do

							task.wait()

							updateDoors()

				

							if not RobHouse then

								Toggles.RobHouse:SetValue(false)

								break

							end

				

							-- Check if House 1 is robbed

							local house1Robbed = Houseleft["HardDoor"].Transparency == 1

							local moneyParts = Houseleft["HardDoor"].Parent.Parent:FindFirstChild("TakeMoney")

							local moneyFound = false

				

							if house1Robbed and moneyParts then

 								for _, part in pairs(moneyParts:GetChildren()) do

									if part.Name == "MoneyGrab" and part.Transparency == 0 then

										moneyFound = true

										break

									end

								end

							end

				

							if house1Robbed and not moneyFound then

								Library:Notify("[SleepyHub] - House 1 already robbed or no money left, skipping...", 2)

							elseif not house1Robbed then

								Library:Notify("[SleepyHub] - Robbing House 1", 2)

				

								-- Rob House 1

								for i, v in pairs(Houseleft["HardDoor"]:GetDescendants()) do

									if v:IsA("ProximityPrompt") and v.Name == "ProximityPrompt" then

										v.Enabled = true

										BypassTp(CFrame.new(v.Parent.CFrame.Position.X - 1.5, v.Parent.CFrame.Position.Y, v.Parent.CFrame.Position.Z))

										Camera.CFrame = CFrame.new(Camera.CFrame.Position, v.Parent.CFrame.Position)

										-- camera.CFrame = CFrame.new(-588.605957, 263.826447, -673.495789, -0.0152258184, 0.646785676, -0.762519777, 0, 0.76260823, 0.6468606, 0.999884188, 0.0098489821, -0.0116113322)

										repeat task.wait() fireproximityprompt(v) until Houseleft["HardDoor"].Transparency == 1

									end

								end

				

								-- Take money and tools from House 1

								for i, v in pairs(Houseleft["HardDoor"].Parent.Parent:GetDescendants()) do

									if v:IsA("ProximityPrompt") and v.Name == "ProximityPrompt" then

										HouseRobPrompts()

								

										local parentPart = v.Parent

										local targetCFrame = parentPart.CFrame * CFrame.new(0, 0, -3)

								

										BypassTp(targetCFrame)

								

										Camera.CFrame = CFrame.new(Camera.CFrame.Position, v.Parent.CFrame.Position)								

										v.Enabled = true

										repeat

											fireproximityprompt(v)

											task.wait()

										until v.Parent.Transparency == 1

										v.Enabled = false

									end

								end

							end

				

							-- Check if House 2 is robbed

							local house2Robbed = Houseright["WoodenDoor"].Transparency == 1

							local moneyParts2 = Houseright["WoodenDoor"].Parent.Parent:FindFirstChild("TakeMoney")

							local moneyFound2 = false

				

							if house2Robbed and moneyParts2 then

 								for _, part in pairs(moneyParts2:GetChildren()) do

									if part.Name == "MoneyGrab" and part.Transparency == 0 then

										moneyFound2 = true

										break

									end

								end

							end

				

							if house2Robbed and not moneyFound2 then

								Library:Notify("[SleepyHub] - House 2 already robbed or no money left, skipping...", 2)

							elseif not house2Robbed then

								Library:Notify("[SleepyHub] - Robbing House 2", 2)

				

								-- Break doors in House 2

								for i, v in pairs(Houseright["WoodenDoor"]:GetDescendants()) do

									if v:IsA("ProximityPrompt") and v.Name == "ProximityPrompt" then

										v.Enabled = true

										BypassTp(CFrame.new(v.Parent.CFrame.Position.X - 1.5, v.Parent.CFrame.Position.Y, v.Parent.CFrame.Position.Z))

										-- camera.CFrame = CFrame.new(-596.48175, 262.085663, -724.761353, -0.0439689904, 0.56248349, -0.825638652, 0, 0.826437891, 0.563027978, 0.999032915, 0.0247557722, -0.0363376401)

										Camera.CFrame = CFrame.new(Camera.CFrame.Position, v.Parent.CFrame.Position)

										repeat task.wait() fireproximityprompt(v) until Houseright["WoodenDoor"].Transparency == 1

									end

								end

				

								for i, v in pairs(Houseright["WoodenDoor"].Parent.Parent:GetDescendants()) do

									if v:IsA("ProximityPrompt") and v.Name == "ProximityPrompt" then

										HouseRobPrompts()

								

										local targetPart = v.Parent

										local targetCFrame = targetPart.CFrame * CFrame.new(0, 0, -3)

								

										BypassTp(targetCFrame)

								

										Camera.CFrame = CFrame.new(Camera.CFrame.Position, v.Parent.CFrame.Position)								

										v.Enabled = true

										repeat

											fireproximityprompt(v)

											task.wait()

										until targetPart.Transparency == 1

										v.Enabled = false

									end

								end

							end

								

				

							Library:Notify("[SleepyHub] - Completed", 2)

							BypassTp(OldCframe)

							Toggles.RobHouse:SetValue(false)

						end

					end

				})

		

		

		









		AutofarmTab:AddDivider()









		local camera = workspace.CurrentCamera



		function stuidoprompt()

			for _, v in pairs(workspace.StudioPay.Money:GetDescendants()) do

				if v:IsA("ProximityPrompt") and v.Name == "Prompt" then

					v.HoldDuration = 0

					v.RequiresLineOfSight = false

				end

			end

		end



		AutofarmTab:AddToggle('RobStuido', {

			Text = 'Rob Studio',

			Default = false,

			Tooltip = nil,



			Callback = function(Value)

				local robstudio = Value



				if robstudio then

					local OldCFrameStudio = RootPart().CFrame

					stuidoprompt()



					for _, v in pairs(workspace.StudioPay.Money:GetDescendants()) do

						if v:IsA("ProximityPrompt") and v.Name == "Prompt" and v.Enabled then

							BypassTp(CFrame.new(v.Parent.Position.X, v.Parent.Position.Y + 2, v.Parent.Position.Z))

							-- camera.CFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + Vector3.new(0, -1, 0))

							Camera.CFrame = CFrame.new(Camera.CFrame.Position, v.Parent.CFrame.Position)

							task.wait(0.25)

							repeat task.wait(0.30) fireproximityprompt(v) until v.Enabled == false

						end

					end



					BypassTp(OldCFrameStudio)

				end



				if robstudio then

					Library:Notify("[SleepyHub] - No money left", 2)

					Toggles.RobStuido:SetValue(false)

				end

			end

		})







		function StealMoneyPrompt()

			for _, v in pairs(workspace.Dollas:GetDescendants()) do

				if v:IsA("ProximityPrompt") and v.Name == "ProximityPrompt" then

					v.HoldDuration = 0

					v.RequiresLineOfSight = false

				end

			end

		end

		getgenv().stealm = false



		AutofarmTab:AddToggle('StealMoney', {

			Text = 'Auto Pickup Money',

			Default = false,

			Tooltip = nil,



			Callback = function(Value)

				getgenv().stealm = Value



				if getgenv().stealm then

					StealMoneyPrompt()

				end



				while getgenv().stealm do

					task.wait()

					for _, v in pairs(workspace.Dollas:GetDescendants()) do

						if v:IsA("ProximityPrompt") and v.Name == "ProximityPrompt" and getgenv().stealm then

							StealMoneyPrompt()

							-- camera.CFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + Vector3.new(0, -1, 0))

							Camera.CFrame = CFrame.new(Camera.CFrame.Position, v.Parent.CFrame.Position)

							BypassTp(v.Parent.CFrame)

							task.wait(0.25)

							fireproximityprompt(v)

						end

					end

				end





				if getgenv().stealm then

					Toggles.StealMoney:SetValue(false)

				end

			end

		})



		AutofarmTab:AddDivider()

		local RobBankMethod = {"C4 - 1,200", "Drill - 700"}

		getgenv().RobMethod = "C4 - 1,200"



		AutofarmTab:AddDropdown('RobBankMethod', {

			Values = RobBankMethod,

			Default = 1,

			Multi = false,

			Text = 'Choose Rob method',

			Callback = function(Value)

				getgenv().RobMethod = Value

				print('[cb] Dropdown got changed. New value:', Value)

			end

		})

		

		function RevertChanges()

			for i, v in pairs(Workspace:GetDescendants()) do

				if v:IsA("Decal") and v.Name == "Decal" then

					if v.Texture == tostring("http://www.roblox.com/asset/?id=541445527") then

						v.Parent:FindFirstChildWhichIsA("ProximityPrompt").Enabled = true

					end

				end

			end

		end  

		

		function RobBankPrompts()

			for i, v in pairs(Workspace:GetDescendants()) do

				if v:IsA("Decal") and v.Name == "Decal" then

					if v.Texture == tostring("http://www.roblox.com/asset/?id=541445527") then

						v.Parent:FindFirstChildWhichIsA("ProximityPrompt").HoldDuration = 0

						v.Parent:FindFirstChildWhichIsA("ProximityPrompt").RequiresLineOfSight = false

						v.Parent:FindFirstChildWhichIsA("ProximityPrompt").Enabled = true

		

						workspace.GUNS.Drill.Drill.BuyPrompt.HoldDuration = 0

						workspace.GUNS.Drill.Drill.BuyPrompt.RequiresLineOfSight = false

		

						workspace.GUNS.C4.Handle.BuyPrompt.HoldDuration = 0

						workspace.GUNS.C4.Handle.BuyPrompt.RequiresLineOfSight = false

					end

				end

			end

		end  

		

		AutofarmTab:AddToggle('RobBank', {

			Text = 'Rob Bank [BETA]',

			Default = false,

			Callback = function(Value)

				local Drill = workspace.GUNS:WaitForChild("Drill")

				local C4 = workspace.GUNS:WaitForChild("C4")

				local Vault = workspace.vault

				local DuffleBag = workspace.dufflebagequip

		

				getgenv().RobBank = Value

				if getgenv().RobBank then

					RobBankPrompts()

					while getgenv().RobBank do

						task.wait()

						

						-- Small check to stop if toggle is turned off

						if not getgenv().RobBank then

							Toggles.RobBank:SetValue(false)

							break

						end

		

						-- Buying C4/Drill

						if getgenv().RobMethod == "Drill - 700" then

							if not game.Players.LocalPlayer.Backpack:FindFirstChild("Drill") and getgenv().RobBank then

								BypassTp(CFrame.new(-374, 340, -562))

								-- camera.CFrame = CFrame.new(-372.144745, 348.51709, -559.269836, 0.854278147, -0.476916999, 0.206782579, 0, 0.397799462, 0.917472422, -0.51981616, -0.783776641, 0.339831382)

								repeat

									task.wait(0.20)

									Camera.CFrame = CFrame.new(Camera.CFrame.Position, game.workspace.GUNS.Drill.Drill.BuyPrompt.Parent.CFrame.Position)

									fireproximityprompt(game.workspace.GUNS.Drill.Drill.BuyPrompt)

									task.wait(0.50)

								until game.Players.LocalPlayer.Backpack:FindFirstChild("Drill") or not getgenv().RobBank

							end

						elseif getgenv().RobMethod == "C4 - 1,200" then

							if not game.Players.LocalPlayer.Backpack:FindFirstChild("C4") and getgenv().RobBank then

								BypassTp(CFrame.new(-370, 340, -567))

								-- camera.CFrame = CFrame.new(-368.041626, 348.714111, -568.344543, -0.397146702, -0.874701142, 0.27779904, 2.90550445e-10, 0.302694052, 0.953087807, -0.917755067, 0.378515691, -0.120213963)

								repeat

									task.wait(0.20)

									Camera.CFrame = CFrame.new(Camera.CFrame.Position, game.workspace.GUNS.C4.Handle.BuyPrompt.Parent.CFrame.Position)

									fireproximityprompt(game.workspace.GUNS.C4.Handle.BuyPrompt)

									task.wait(0.50)

								until game.Players.LocalPlayer.Backpack:FindFirstChild("C4") or not getgenv().RobBank

							end

						end

		

						-- Buying DuffelBag

						if not game.Players.LocalPlayer.Character:FindFirstChild("DuffelBag") and getgenv().RobBank then

							BypassTp(CFrame.new(-374, 340, -550))

							-- camera.CFrame = CFrame.new(-373.33371, 347.064728, -558.135498, -0.999758184, -0.0119379917, 0.0184677821, 0, 0.839813828, 0.542874634, -0.021990329, 0.542743385, -0.839610755)

							repeat

								task.wait(0.20)

								Camera.CFrame = CFrame.new(Camera.CFrame.Position, DuffleBag:FindFirstChildWhichIsA("ProximityPrompt").Parent.CFrame.Position)

								fireproximityprompt(DuffleBag:FindFirstChildWhichIsA("ProximityPrompt"))

								task.wait(0.50)

							until game.Players.LocalPlayer.Character:FindFirstChild("DuffelBag") or not getgenv().RobBank

						end

		

						-- Vault door prompt = enabled

						if Vault.door.metaldoor.Rotation == Vector3.new(180, 0, 180) then

							if not Vault.door.robPrompt.ProximityPrompt.Enabled then

								Vault.door.robPrompt.ProximityPrompt.Enabled = true

							end

						end

		

						-- Drill/C4 check

						if Vault.door.metaldoor.Rotation == Vector3.new(180, 0, 180) then

							if not game.Players.LocalPlayer.Backpack:FindFirstChild("Drill") and not game.Players.LocalPlayer.Backpack:FindFirstChild("C4") then

								Library:Notify("Drill/C4 not found", 5)

								return

							end

						end

		

						-- Breaking vault

						if Vault.door.metaldoor.Rotation == Vector3.new(180, 0, 180) then

							BypassTp(CFrame.new(-121, 374, -1216))

							-- camera.CFrame = CFrame.new(-127.262039, 377.939606, -1217.48987, -0.199711055, 0.372538865, -0.906272888, 0, 0.9249053, 0.380198002, 0.979854882, 0.075929746, -0.184713796)

		

							local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")

							local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Drill") or game.Players.LocalPlayer.Backpack:FindFirstChild("C4")

							if tool then

								humanoid:EquipTool(tool)

							end

		

							repeat task.wait(0.50)

								if Vault.door and Vault.door.robPrompt and Vault.door.robPrompt.ProximityPrompt then

									Camera.CFrame = CFrame.new(Camera.CFrame.Position, Vault.door.robPrompt.ProximityPrompt.Parent.CFrame.Position)

									fireproximityprompt(Vault.door.robPrompt.ProximityPrompt)

								end

							until not game.Players.LocalPlayer.Character:FindFirstChild("Drill") or not game.Players.LocalPlayer.Character:FindFirstChild("C4")

						end

		

						-- Wait for the door to open

						Library:Notify("Waiting for metal door to open", 10)

						repeat

							task.wait()

							BypassTp(CFrame.new(-129, 374, -1221))

						until Vault.door.metaldoor.Rotation ~= Vector3.new(180, 0, 180) or not getgenv().RobBank

		

						-- Handle cash collection

						repeat

							for _, v in pairs(workspace:GetDescendants()) do

								if v:IsA("Decal") and v.Name == "Decal" and v.Texture == "http://www.roblox.com/asset/?id=541445527" then

									if v.Parent:FindFirstChildWhichIsA("ProximityPrompt") and v.Parent.Name == "Cash" then

										local prompt = v.Parent:FindFirstChildWhichIsA("ProximityPrompt")

										if prompt then

											prompt.Enabled = true

											if game.Players.LocalPlayer.Character:WaitForChild("DuffelBag").gold.Value == 5 or not getgenv().RobBank then

												break

											end

											task.wait(0.20)

											BypassTp(CFrame.new(v.Parent.CFrame.Position.X - 2.5, v.Parent.CFrame.Position.Y, v.Parent.CFrame.Position.Z))

		

											for i = 1, 5 do

												task.wait(0.20)

											fireproximityprompt(prompt)

											end

											task.wait(0.1)

		

											prompt.Enabled = false

											task.wait(0.5)

										end

									end

								end

							end

						until game.Players.LocalPlayer.Character:WaitForChild("DuffelBag").gold.Value == 5 or not getgenv().RobBank

		

						-- Sell the gold if the bag is full and stop the process

						if game.Players.LocalPlayer.Character:WaitForChild("DuffelBag").gold.Value == 5 then

							BypassTp(CFrame.new(-365, 340, -549))

							camera.CFrame = CFrame.new(-364.663452, 346.691437, -554.076355, -0.992114544, -0.0825489536, 0.0943097845, 0, 0.75246644, 0.658630669, -0.125334203, 0.653437078, -0.746532917)

							local clickDetector = workspace.sellgold:FindFirstChild("ClickDetector")

							

							if clickDetector and hookmetamethod then

								fireclickdetector(clickDetector)

								Library:Notify("Gold Sold", 5)

							else

								Library:Notify("Done - due to your low executor we call the detection & gold needs to be manually sold", 5)

								Toggles.RobBank:SetValue(false)

								break -- Stop the process after notifying

							end

						

							Toggles.RobBank:SetValue(false)

							break -- Exit the process after handling the gold selling

						end				

					end		

				end

			end

		})



		AutofarmTab:AddDivider()



		-- AutofarmTab:AddToggle('AutoFarmShiesty', {

		-- 	Text = 'Autofarm Shiesty',

		-- 	Default = false, -- Autofarm starts off

		-- 	Tooltip = nil,

		

		-- 	Callback = function(Value)

		-- 		getgenv().toggle = Value 

		-- 		if Value then

		-- 			print("[AutoFarm] Starting AutoFarm for Shiestys.")

		-- 			task.spawn(function()

		-- 				while getgenv().toggle do

		-- 					task.wait()  

		

		-- 					local success, err = pcall(function()

 		-- 						game:GetService("ReplicatedStorage").ShopRemote:InvokeServer("Shiesty")

		-- 						game:GetService("ReplicatedStorage").PawnRemote:FireServer("Shiesty")

		-- 					end)

		

		-- 					if not success then

		-- 						warn("[AutoFarm] Error during error (what skid? yes ok):", err)

		-- 					end

		-- 				end

		-- 				print("[AutoFarm] Stopped AutoFarm for Shiestys")

		-- 			end)

		-- 		else

		-- 			print("[AutoFarm] AutoFarm has been disabled")

		-- 		end

		-- 	end

		-- })

		

		

















		AutofarmText:AddLabel('Good Morning Mr. Hacker ☕')

		AutofarmText:AddLabel([[

Along with our polymorphic loader

you're safe from bans and being tracked by the game



Only a few are invited, but god knows they are lucky

]], true)







		--// Player Esp \\--

		Boxes.Settings:AddToggle("Visuals", {

			Text = "enabled",

			Default = false,

		})

		Toggles.Visuals:OnChanged(function()

			features:toggle("visuals", Toggles.Visuals.Value)

		end)

		Boxes.Settings:AddToggle("VisualsTeamCheck", {

			Text = "team check",

			Default = false,

		})

		Toggles.VisualsTeamCheck:OnChanged(function()

			visuals.teamCheck = Toggles.VisualsTeamCheck.Value

		end)

		Boxes.Settings:AddToggle("VisualsTeamColor", {

			Text = "team color",

			Default = false,

		})

		Toggles.VisualsTeamColor:OnChanged(function()

			visuals.teamColor = Toggles.VisualsTeamColor.Value

		end)

		Boxes.Settings:AddSlider("VisualsRenderDistance", {

			Text = "render distance",

			Default = 2000,

			Min = 0,

			Max = 2000,

			Rounding = 0,

			Compact = true,

		})

		Options.VisualsRenderDistance:OnChanged(function()

			visuals.renderDistance = Options.VisualsRenderDistance.Value

		end)

		Boxes.Boxes:AddToggle("Boxes", {

			Text = "enabled",

			Default = false,

		}):AddColorPicker("BoxesColor", {

			Default = Color3.fromRGB(255, 255, 255),

			Title = "box color",

		})

		Toggles.Boxes:OnChanged(function()

			visuals.boxes.enabled = Toggles.Boxes.Value

		end)

		Options.BoxesColor:OnChanged(function()

			visuals.boxes.color = Options.BoxesColor.Value

		end)

		Boxes.Boxes:AddToggle("BoxesOutline", {

			Text = "outline",

			Default = false,

		}):AddColorPicker("BoxesOutlineColor", {

			Default = Color3.fromRGB(0, 0, 0),

			Title = "outline color",

		})

		Toggles.BoxesOutline:OnChanged(function()

			visuals.boxes.outline.enabled = Toggles.BoxesOutline.Value

		end)

		Options.BoxesOutlineColor:OnChanged(function()

			visuals.boxes.outline.color = Options.BoxesOutlineColor.Value

		end)

		Boxes.Boxes:AddToggle("BoxesFilled", {

			Text = "filled",

			Default = false,

		}):AddColorPicker("BoxesFilledColor", {

			Default = Color3.fromRGB(255, 255, 255),

			Title = "fill color",

		})

		Toggles.BoxesFilled:OnChanged(function()

			visuals.boxes.filled.enabled = Toggles.BoxesFilled.Value

		end)

		Options.BoxesFilledColor:OnChanged(function()

			visuals.boxes.filled.color = Options.BoxesFilledColor.Value

		end)

		Boxes.Boxes:AddSlider("BoxesFilledTransparency", {

			Text = "transparency",

			Default = 0.25,

			Min = 0,

			Max = 1,

			Rounding = 1,

			Compact = true,

		})

		Options.BoxesFilledTransparency:OnChanged(function()

			visuals.boxes.filled.transparency = Options.BoxesFilledTransparency.Value

		end)

		Boxes.Names:AddToggle("Names", {

			Text = "enabled",

			Default = false,

		}):AddColorPicker("NamesColor", {

			Default = Color3.fromRGB(255, 255, 255),

			Title = "names color",

		})

		Toggles.Names:OnChanged(function()

			visuals.names.enabled = Toggles.Names.Value

		end)

		Options.NamesColor:OnChanged(function()

			visuals.names.color = Options.NamesColor.Value

		end)

		Boxes.Names:AddToggle("NamesOutline", {

			Text = "outline",

			Default = false,

		}):AddColorPicker("NamesOutlineColor", {

			Default = Color3.fromRGB(0, 0, 0),

			Title = "outline color",

		})

		Toggles.NamesOutline:OnChanged(function()

			visuals.names.outline.enabled = Toggles.NamesOutline.Value

		end)

		Options.NamesOutlineColor:OnChanged(function()

			visuals.names.outline.color = Options.NamesOutlineColor.Value

		end)

		Boxes.Health:AddToggle("Health", {

			Text = "enabled",

			Default = false,

		}):AddColorPicker("HealthColor", {

			Default = Color3.fromRGB(0, 255, 0),

			Title = "health color",

		}):AddColorPicker("HealthLowColor", {

			Default = Color3.fromRGB(255, 0, 0),

			Title = "low health color",

		})

		Toggles.Health:OnChanged(function()

			visuals.health.enabled = Toggles.Health.Value

		end)

		Options.HealthColor:OnChanged(function()

			visuals.health.color = Options.HealthColor.Value

		end)

		Options.HealthLowColor:OnChanged(function()

			visuals.health.colorLow = Options.HealthLowColor.Value

		end)

		Boxes.Health:AddToggle("HealthOutline", {

			Text = "outline",

			Default = false,

		}):AddColorPicker("NamesOutlineColor", {

			Default = Color3.fromRGB(0, 0, 0),

			Title = "outline color",

		})

		Toggles.HealthOutline:OnChanged(function()

			visuals.health.outline.enabled = Toggles.HealthOutline.Value

		end)

		Options.NamesOutlineColor:OnChanged(function()

			visuals.health.outline.color = Options.NamesOutlineColor.Value

		end)

		Boxes.Health:AddToggle("HealthText", {

			Text = "text",

			Default = false,

		})

		Toggles.HealthText:OnChanged(function()

			visuals.health.text.enabled = Toggles.HealthText.Value

		end)

		Boxes.Health:AddToggle("HealthTextOutline", {

			Text = "text outline",

			Default = false,

		})

		Toggles.HealthTextOutline:OnChanged(function()

			visuals.health.text.outline.enabled = Toggles.HealthTextOutline.Value

		end)

		Boxes.Distance:AddToggle("Distance", {

			Text = "enabled",

			Default = false,

		}):AddColorPicker("DistanceColor", {

			Default = Color3.fromRGB(255, 255, 255),

			Title = "distance color",

		})

		Toggles.Distance:OnChanged(function()

			visuals.distance.enabled = Toggles.Distance.Value

		end)

		Options.DistanceColor:OnChanged(function()

			visuals.distance.color = Options.DistanceColor.Value

		end)

		Boxes.Distance:AddToggle("DistanceOutline", {

			Text = "outline",

			Default = false,

		}):AddColorPicker("DistanceOutlineColor", {

			Default = Color3.fromRGB(0, 0, 0),

			Title = "outline color",

		})

		Toggles.DistanceOutline:OnChanged(function()

			visuals.distance.outline.enabled = Toggles.DistanceOutline.Value

		end)

		Options.DistanceOutlineColor:OnChanged(function()

			visuals.distance.outline.color = Options.DistanceOutlineColor.Value

		end)

		Boxes.Weapon:AddToggle("Weapon", {

			Text = "enabled",

			Default = false,

		}):AddColorPicker("WeaponColor", {

			Default = Color3.fromRGB(255, 255, 255),

			Title = "weapon color",

		})

		Toggles.Weapon:OnChanged(function()

			visuals.weapon.enabled = Toggles.Weapon.Value

		end)

		Options.WeaponColor:OnChanged(function()

			visuals.weapon.color = Options.WeaponColor.Value

		end)

		Boxes.Weapon:AddToggle("WeaponOutline", {

			Text = "outline",

			Default = false,

		}):AddColorPicker("WeaponOutlineColor", {

			Default = Color3.fromRGB(0, 0, 0),

			Title = "weapon color",

		})

		Toggles.WeaponOutline:OnChanged(function()

			visuals.weapon.outline.enabled = Toggles.WeaponOutline.Value

		end)

		Options.WeaponOutlineColor:OnChanged(function()

			visuals.weapon.outline.color = Options.WeaponOutlineColor.Value

		end)





		local lightingService = game:GetService("Lighting")



		function changeSkybox(skyboxId)

			for _, v in pairs(lightingService:GetChildren()) do

				if v:IsA("Sky") then

					v:Destroy()

				end

			end



			local sky = Instance.new("Sky")

			sky.SkyboxBk = skyboxId

			sky.SkyboxDn = skyboxId

			sky.SkyboxFt = skyboxId

			sky.SkyboxLf = skyboxId

			sky.SkyboxRt = skyboxId

			sky.SkyboxUp = skyboxId

			sky.Parent = lightingService

		end



		local skyboxIds = {

			"rbxassetid://10735998943",

			"rbxassetid://8139676647",

			"rbxassetid://8139676988",

			"rbxassetid://8139677111"

		}



		Boxes.SkyBox:AddDropdown('SkyboxDropdown', {

			Values = skyboxIds,

			Default = 1,

			Multi = false,

			Text = 'Select Skybox',

			Tooltip = nil,

			Callback = function(selectedId)

				changeSkybox(selectedId)

				print("Skybox changed to: " .. selectedId)

			end

		})





		Options.SkyboxDropdown:OnChanged(function()

			print('Dropdown got changed. New value:', Options.SkyboxDropdown.Value)

		end)





		--// UI Settings \\--

		-- Example of dynamically-updating watermark with common traits (fps and ping)

		local FrameTimer = tick()

		local FrameCounter = 0;

		local FPS = 60;

		local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()

			FrameCounter += 1;

			if (tick() - FrameTimer) >= 1 then

				FPS = FrameCounter;

				FrameTimer = tick();

				FrameCounter = 0;

			end;

			Library:SetWatermark(('Sleepy Hub | %s fps | %s ms'):format(

				math.floor(FPS), math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())));

		end);

		Library.KeybindFrame.Visible = true; -- todo: add a function for this

		Library:OnUnload(function()

			WatermarkConnection:Disconnect()

			print('Unloaded!')

			Library.Unloaded = true

		end)



		--// Game

		local GameID = Tabs.UISettings:AddLeftGroupbox('Game')

		GameID:AddInput('GameID_Check', {

			Default = 'Game ID',

			Numeric = true,

			Finished = false,

			Text = 'Game ID:',

			Placeholder = 'Game ID Here'

		})

		GameID:AddButton('Join Game', function()

			game:GetService("TeleportService"):Teleport(Options.GameID_Check.Value, plr)

		end)

		GameID:AddButton('Copy Join Code', function()

			setclipboard(("game:GetService('TeleportService'):TeleportToPlaceInstance(%s, '%s')"):format(game.PlaceId, game.JobId))

			Library:Notify("Copied Join Code!", 5)

		end)

		GameID:AddButton('Rejoin Server', function()

			game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId)

			Library:Notify('Rejoining Server!', 30)

		end)

		GameID:AddButton('Server Hop', function()

			local TeleportService = game:GetService('TeleportService')

			local HttpService = game:GetService('HttpService')

		

			function getNewServer()

				local servers = {}

				local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"

				

 				local success, response = pcall(function()

					return game:HttpGet(url)

				end)

				

				if not success then

					Library:Notify('Failed to fetch server list!', 30)

					return nil

				end

		

 				for serverId in response:gmatch('"id"%s*:%s*"(.-)"') do

					local playerCount = tonumber(response:match('"playing"%s*:%s*(%d+)', response:find(serverId)))

					local maxPlayers = tonumber(response:match('"maxPlayers"%s*:%s*(%d+)', response:find(serverId)))

					

 					if serverId ~= game.JobId and playerCount and maxPlayers and playerCount < maxPlayers then

						table.insert(servers, serverId)

					end

				end

				

 				return #servers > 0 and servers[math.random(1, #servers)] or nil

			end

		

			local newServerId = getNewServer()

			

			if newServerId then

				TeleportService:TeleportToPlaceInstance(game.PlaceId, newServerId)

				Library:Notify('Hopping to a new server!', 30)

			else

				Library:Notify('No new servers available/low executor level', 30)

			end

		end)

		



		--// Menu

		local MenuGroup = Tabs.UISettings:AddRightGroupbox('Menu')

		MenuGroup:AddLabel(' Made by:<font color="#FFFF00"> vyylora</font> 👑', true)

		MenuGroup:AddButton('Unload Script', function()

			Library:Unload()

			for i, v in pairs(Toggles) do

				v:SetValue(false)

			end

			SetTimeOfDayText = false

			if SleepyHubText then

				SleepyHubText:Destroy()

			end

			Library:Notify('Unloaded!', 1)

		end)

		MenuGroup:AddButton('Panic Button', function()

			for i, v in pairs(Toggles) do

				v:SetValue(false)

				Library:Notify('Panic Button!', 1)

			end

		end)

		MenuGroup:AddButton('Copy Discord', function()

			if pcall(setclipboard, "https://discord.gg/6NEfRP7XED") then

				Library:Notify('Successfully copied discord link to your clipboard!', 5)

			end

		end)

		MenuGroup:AddToggle('Propoganda', {

			Text = 'Propaganda Notifications',

			Default = true,

			Tooltip = nil,

			Callback = function(enabled)

				propagandaEnabled = enabled

				if propagandaEnabled then

					if not propagandaRunning then

						propagandaRunning = true

						showPropaganda()

					end

				else

					print("Propaganda notifications are now OFF.")

				end

			end

		})

		MenuGroup:AddToggle('WatermarkToggle', {

			Text = 'Watermark',

			Default = false,

			Tooltip = nil

		})

		Toggles.WatermarkToggle:OnChanged(function()

			while Toggles.WatermarkToggle.Value do

				task.wait(1)

				local fps = string.format('%.0f', game.Stats.Workspace.Heartbeat:GetValue())

				local ping = string.format('%.0f', game.Stats.Network.ServerStatsItem["Data Ping"]:GetValue())

				Library:SetWatermark('SleepyHub - FPS: ' .. fps .. ' | Ping: ' .. ping .. ' | [Tha Bronx 2]')

				Library:SetWatermarkVisibility(true)

				warn("true")

			end

			Library:SetWatermarkVisibility(false)



			warn("false")

		end)

		MenuGroup:AddToggle('UISettings_KeybindFrameVisibility', {

			Text = 'Keybind',

			Default = true

		}):OnChanged(function()

			Library.KeybindFrame.Visible = Toggles.UISettings_KeybindFrameVisibility.Value

		end)

		MenuGroup:AddLabel('Menu Keybind'):AddKeyPicker('MenuKeybind', {

			Default = 'Insert',

			NoUI = true,

			Text = 'Menu keybind'

		})

		Library.ToggleKeybind = Options.MenuKeybind

        

		MenuGroup:AddSlider('TpBypassSpeed', {

			Text = 'Tp Bypass Speed',

			Default = 0.2,

			Min = 0.1,

			Max = 1,

			Rounding = 01,

			Compact = false,

		

			Callback = function(Value)

				BypassTpSpeed = Value

			end

		})



		MenuGroup:AddDropdown('BypassMethod', {

			Values = {"Safest","FF","Fastest"},

			Default = 2,

			Multi = false,

			Text = "Bypass Method",

			Tooltip = nil,

			Callback = function(Value)

			   BypassMethod = Value

			end

		})





		--// Save manager

		SaveManager:SetLibrary(Library)

		SaveManager:SetFolder('LibyaHub/Configs')

		SaveManager:BuildConfigSection(Tabs.UISettings)

		SaveManager:SetIgnoreIndexes({"Teleport","PlayerDrpDown","PlayerDropDownReal","SkyboxDropdown","Fly"})

		SaveManager:IgnoreThemeSettings()

        

		--// Theme manager

		ThemeManager:SetLibrary(Library)

		ThemeManager:SetFolder('Libyahub/themes')

		ThemeManager:ApplyToTab(Tabs.UISettings)



		--// Script Loadedw

		local elapsedTime = os.clock() - Clock  -- Calculate elapsed time

		Library:Notify(("Script [Loaded] In - " .. tostring(math.floor(elapsedTime * 10^Decimals) / 10^Decimals) .. "s"), 5)







		--Wrapping function - needed to unload(Keep at end of script)

		-- loadstring(game:HttpGet('https://raw.githubusercontent.com/Vyylora/main/refs/heads/main/LoadManager'))



	end)



	if err then

		game:GetService("Players").LocalPlayer:Kick("An error occured, please rejoin: " .. tostring(err))

	end

end