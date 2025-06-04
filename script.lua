-- Carregar Rayfield
loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Criar Janela
local Window = Rayfield:CreateWindow({
   Name = "NovaHubYT - Shader Hub",
   LoadingTitle = "Carregando Shaders",
   LoadingSubtitle = "by NovaHubYT",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "NovaHubYT",
      FileName = "shader_config"
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false
})

local Lighting = game:GetService("Lighting")

-- Funções
local function CreateEffect(name, props)
   RemoveEffect(name)
   local inst = Instance.new(name)
   for prop, val in pairs(props) do
      inst[prop] = val
   end
   inst.Name = "Shader_" .. name
   inst.Parent = Lighting
end

function RemoveEffect(name)
   local found = Lighting:FindFirstChild("Shader_" .. name)
   if found then found:Destroy() end
end

function RemoveAllEffects()
   for _, v in pairs(Lighting:GetChildren()) do
      if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("BlurEffect") then
         if v.Name:match("^Shader_") then
            v:Destroy()
         end
      end
   end
end

-- Aba de Shaders
local ShaderTab = Window:CreateTab("🎨 Shaders", 4483362458)

ShaderTab:CreateToggle({
   Name = "🌈 Bloom",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         CreateEffect("BloomEffect", {Intensity = 1, Size = 24, Threshold = 1})
      else
         RemoveEffect("BloomEffect")
      end
   end
})

ShaderTab:CreateToggle({
   Name = "🎨 Color Correction",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         CreateEffect("ColorCorrectionEffect", {Brightness = 0.1, Contrast = 0.2, Saturation = 0.25})
      else
         RemoveEffect("ColorCorrectionEffect")
      end
   end
})

ShaderTab:CreateToggle({
   Name = "🌅 Sun Rays",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         CreateEffect("SunRaysEffect", {Intensity = 0.15, Spread = 1})
      else
         RemoveEffect("SunRaysEffect")
      end
   end
})

ShaderTab:CreateToggle({
   Name = "🌫️ Depth Of Field",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         CreateEffect("DepthOfFieldEffect", {
            FarIntensity = 0.3, FocusDistance = 20, InFocusRadius = 50, NearIntensity = 0.1
         })
      else
         RemoveEffect("DepthOfFieldEffect")
      end
   end
})

ShaderTab:CreateToggle({
   Name = "🔲 Blur",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         CreateEffect("BlurEffect", {Size = 6})
      else
         RemoveEffect("BlurEffect")
      end
   end
})

ShaderTab:CreateToggle({
   Name = "🌌 Atmosphere (Visual)",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
         CreateEffect("Atmosphere", {
            Density = 0.4,
            Offset = 0.25,
            Color = Color3.fromRGB(199, 203, 255),
            Decay = Color3.fromRGB(106, 112, 255),
            Glare = 0.4,
            Haze = 1
         })
      else
         RemoveEffect("Atmosphere")
      end
   end
})

-- Aba de Presets
local PresetTab = Window:CreateTab("✨ Presets", 4483362458)

local function ApplyPreset(name)
   RemoveAllEffects()
   if name == "Noite" then
      CreateEffect("ColorCorrectionEffect", {Brightness = -0.2, Contrast = 0.3, Saturation = -0.1})
      CreateEffect("SunRaysEffect", {Intensity = 0.05, Spread = 0.5})
   elseif name == "Vaporwave" then
      CreateEffect("BloomEffect", {Intensity = 1.2, Size = 25, Threshold = 1})
      CreateEffect("ColorCorrectionEffect", {Brightness = 0.05, Contrast = 0.15, Saturation = 0.8})
      CreateEffect("BlurEffect", {Size = 5})
      CreateEffect("Atmosphere", {
         Density = 0.25,
         Color = Color3.fromRGB(255, 160, 230),
         Decay = Color3.fromRGB(130, 0, 255),
         Glare = 0.3,
         Haze = 0.5
      })
   elseif name == "Cinemático" then
      CreateEffect("DepthOfFieldEffect", {
         FarIntensity = 0.3,
         FocusDistance = 15,
         InFocusRadius = 30,
         NearIntensity = 0.1
      })
      CreateEffect("ColorCorrectionEffect", {Brightness = 0, Contrast = 0.4, Saturation = -0.2})
      CreateEffect("SunRaysEffect", {Intensity = 0.1, Spread = 0.7})
   end
end

PresetTab:CreateButton({
   Name = "🌙 Noite",
   Callback = function() ApplyPreset("Noite") end
})

PresetTab:CreateButton({
   Name = "🌈 Vaporwave",
   Callback = function() ApplyPreset("Vaporwave") end
})

PresetTab:CreateButton({
   Name = "🎬 Cinemático",
   Callback = function() ApplyPreset("Cinemático") end
})

PresetTab:CreateButton({
   Name = "❌ Resetar Tudo",
   Callback = function() RemoveAllEffects() end
})

-- Aba de Créditos
local CreditTab = Window:CreateTab("📜 Créditos", 4483362458)
CreditTab:CreateParagraph({
   Title = "NovaHubYT",
   Content = "Feito com Rayfield. Visual shaders para deixar seu Roblox incrível ✨"
})
