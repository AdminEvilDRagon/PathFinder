local waypoints = {
    Vector3.new(642, 117, 2149), Vector3.new(693, 117, 2124), Vector3.new(727, 120, 2136),
    Vector3.new(754, 123, 2122), Vector3.new(839, 118, 2136), Vector3.new(893, 117, 2120),
    Vector3.new(830, 121, 2190), Vector3.new(822, 120, 2189), Vector3.new(791, 121, 2186),
    Vector3.new(771, 117, 2145), Vector3.new(768, 121, 2193), Vector3.new(713, 117, 2177),
    Vector3.new(721, 117, 2212), Vector3.new(702, 121, 2240),
    Vector3.new(680, 119, 2244), Vector3.new(664, 121, 2248), Vector3.new(653, 124, 2252),
    Vector3.new(643, 121, 2259), Vector3.new(566, 117, 2248), Vector3.new(504, 117, 2284),
    Vector3.new(504, 121, 2314), Vector3.new(494, 118, 2342), Vector3.new(475, 121, 2347),
    Vector3.new(453, 117, 2324), Vector3.new(412, 117, 2331), Vector3.new(399, 117, 2339),
    Vector3.new(397, 117, 2334), Vector3.new(402, 117, 2323), Vector3.new(446, 117, 2330),
    Vector3.new(492, 117, 2293), Vector3.new(474, 117, 2248), Vector3.new(531, 117, 2211),
    Vector3.new(572, 117, 2208), Vector3.new(583, 117, 2185), Vector3.new(615, 117, 2173),
    Vector3.new(579, 117, 2101), Vector3.new(544, 117, 2112)
}

local existingFolder = workspace:FindFirstChild("PathVisualizer")
if existingFolder then
    existingFolder:ClearAllChildren()
end

local folder = existingFolder or Instance.new("Folder")
folder.Name = "PathVisualizer"
folder.Parent = workspace

local lastPart = nil

for i, pos in ipairs(waypoints) do
    local part = Instance.new("Part")
    part.Name = "Waypoint_" .. i
    part.Size = Vector3.new(1, 1, 1)
    part.Position = pos
    part.Anchored = true
    part.CanCollide = false
    part.Material = Enum.Material.Neon
    part.Color = Color3.fromRGB(255, 0, 0)
    part.Shape = Enum.PartType.Ball
    part.Parent = folder

    local att = Instance.new("Attachment")
    att.Name = "Node"
    att.Parent = part

    local bgui = Instance.new("BillboardGui")
    bgui.Size = UDim2.new(0, 200, 0, 50)
    bgui.StudsOffset = Vector3.new(0, 3, 0)
    bgui.AlwaysOnTop = true
    bgui.Parent = part

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeTransparency = 0
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold
    label.Text = string.format("%d: %d, %d, %d", i, pos.X, pos.Y, pos.Z)
    label.Parent = bgui

    if lastPart then
        local beam = Instance.new("Beam")
        beam.Attachment0 = lastPart:FindFirstChild("Node")
        beam.Attachment1 = att
        beam.Width0 = 0.5
        beam.Width1 = 0.5
        beam.FaceCamera = true
        beam.Color = ColorSequence.new(Color3.fromRGB(255, 255, 0))
        beam.Parent = part
    end
    
    lastPart = part
end
