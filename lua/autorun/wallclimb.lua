resource.AddFile("sound/ClimbSound1.wav")
resource.AddFile("sound/ClimbSound2.wav")
resource.AddFile("sound/ClimbSound3.wav")
resource.AddFile("sound/wallrun.wav")

if (SERVER) then 
	
	local fueraweaps = {
"weapon_physgun",
"weapon_physcannon",
"weapon_pistol",
"weapon_crowbar",
"weapon_slam",
"weapon_357",
"weapon_smg1",
"weapon_ar2",
"weapon_crossbow",
"weapon_shotgun",
"weapon_frag",
"weapon_stunstick",
"weapon_rpg",
"gmod_camera",
"gmod_toolgun"}

function climbb_Spawn(ply)
ply:GetViewModel():SetNoDraw(false)
ply.Lastclimbb = CurTime()
ply.LastJump = CurTime()
end
hook.Add("PlayerSpawn","climbb_Spawn",climbb_Spawn)

function WallMountSound(ply)
	ply:EmitSound("TraceurMount" .. math.random(1, 3) .. ".wav", math.Rand(30, 35), math.Rand(90, 100))
end

function WallJumpSound(ply)
	ply:EmitSound("player/footsteps/tile" .. math.random(1, 4) .. ".wav", math.Rand(60, 80), math.Rand(70, 90))
end

function WallRunSound(ply)
	ply:EmitSound("wallrun.wav")
end

function climbb()
for id,ply in pairs (player.GetAll()) do


if ply.ArmaEquipar and CurTime() >= ply.ArmaEquipar then
if not ply:Alive() then return end
ply.ArmaEquipar = nil
if ply:GetActiveWeapon():IsValid() then
if table.HasValue(fueraweaps,ply:GetActiveWeapon():GetClass()) then
timer.Simple(0.02,function()
ply:GetActiveWeapon():SendWeaponAnim(ACT_VM_DRAW)
end)
else
timer.Simple(0.02,function()
ply:GetActiveWeapon():SendWeaponAnim(ACT_VM_DRAW)
ply:GetActiveWeapon():Deploy()
end)
end
ply:GetViewModel():SetNoDraw(false)
end
end
--Walljump Left--
	if (ply:KeyDown(IN_MOVELEFT) and ply:KeyDown(IN_JUMP)) and ply.LastJump and CurTime() >= ply.LastJump then
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetRight() * 1)
	tracedata.endpos = ply:EyePos() + (ply:GetRight() * 32)
	tracedata.filter = ply
	local traceWallRight = util.TraceLine(tracedata)
	
	if (traceWallRight.Hit) then
					if ply:OnGround() then
					ply:ViewPunch(Angle(0, 0, -10));
					ply:SetLocalVelocity(((ply:GetRight() * -1) * 175) + (ply:GetUp() * 170));
					WallJumpSound(ply)
					ply.LastJump = CurTime() + 1.0
					end
					if not ply:OnGround() then
					ply:ViewPunch(Angle(0, 0, -10));
					ply:SetLocalVelocity(((ply:GetRight() * -1) * 175) + (ply:GetUp() * 280));
					WallJumpSound(ply)
					ply.LastJump = CurTime() + 1.0
					end
					end
					end
	--Waljump Left end--
	--Walljump Right--
	if (ply:KeyDown(IN_MOVERIGHT) and ply:KeyDown(IN_JUMP)) and ply.LastJump and CurTime() >= ply.LastJump then
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetRight() * -1)
	tracedata.endpos = ply:EyePos() + (ply:GetRight() * -32)
	tracedata.filter = ply
	local traceWallLeft = util.TraceLine(tracedata)
	
	if (traceWallLeft.Hit) then
					if ply:OnGround() then
					ply:ViewPunch(Angle(0, 0, 10));
					ply:SetLocalVelocity(((ply:GetRight() * 1) * 175) + (ply:GetUp() * 170));
					WallJumpSound(ply)
					ply.LastJump = CurTime() + 1.0
					end
					if not ply:OnGround() then
					ply:ViewPunch(Angle(0, 0, 10));
					ply:SetLocalVelocity(((ply:GetRight() * 1) * 175) + (ply:GetUp() * 280));
					WallJumpSound(ply)
					ply.LastJump = CurTime() + 1.0
					end
					end
					end
	--Waljump Right end--

-- auto jump close--
if ply:KeyDown(IN_SPEED) and ply:KeyDown(IN_FORWARD) and ply:OnGround() then
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetUp() * 0) + (ply:GetForward() * -30)
	tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 100) + (ply:GetForward() * 30)
	tracedata.filter = ply
	local traceAutoHigh2 = util.TraceLine(tracedata)

	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetUp() * -1) + (ply:GetForward() * 32)
	tracedata.endpos = ply:EyePos()+ (ply:GetUp() * -110) + (ply:GetForward() * 128)
	tracedata.filter = ply
	local traceAutoLow = util.TraceLine(tracedata)
	
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetForward() * 32)
	tracedata.endpos = ply:EyePos() + (ply:GetForward() * 128)
	tracedata.filter = ply
	local traceAutoHigh = util.TraceLine(tracedata)
	
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetForward() * 129) + (ply:GetUp() * 50)
	tracedata.endpos = ply:EyePos() + (ply:GetForward() * 140) + (ply:GetUp() * -80)
	tracedata.filter = ply
	local traceFloorto = util.TraceLine(tracedata)
	
	if not (traceAutoLow.Hit) and not (traceAutoHigh.Hit) and not (traceAutoHigh2.Hit) and (traceFloorto.Hit) and ply:OnGround() then
	ply:ViewPunch(Angle(-3, 0, 0));
	ply:SetLocalVelocity(Vector(0,0,260) + (ply:EyeAngles():Right()*0 +  ply:GetForward()*200))
	end
	end
	-- auto jump close end--
	
	--high--
	if ply:KeyDown(IN_SPEED) and ply:KeyDown(IN_FORWARD) and ply:OnGround() then
	if not( ply:Crouching() ) then
	tracedata={}
	tracedata.start = ply:EyePos()+(ply:GetForward()*1)+(ply:GetUp() * -10 )
	tracedata.endpos = ply:EyePos()+(ply:GetForward()*128)+(ply:GetUp() * 30)
	tracedata.filter = ply
	local traceAimObj = util.TraceLine(tracedata)
	
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetUp() * 0) + (ply:GetForward() * -30)
	tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 100) + (ply:GetForward() * 30)
	tracedata.filter = ply
	local traceHighHigh2 = util.TraceLine(tracedata)
	
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetUp() * 21) + (ply:GetForward() * 1)
	tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 60) + (ply:GetForward() * 64)
	tracedata.filter = ply
	local traceHighLow = util.TraceLine(tracedata)
	
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetUp() * 61) + (ply:GetForward() * 1)
	tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 98) + (ply:GetForward() * 64)
	tracedata.filter = ply
	local traceHighHigh = util.TraceLine(tracedata)
	if ply:KeyDown(IN_DUCK) then
	return
	end
	if (traceHighLow.Hit) and (traceAimObj.Hit) and not (traceHighHigh.Hit) and not (traceHighHigh2.Hit) and not( ply:Crouching() ) and ply:OnGround() then
	if not ply:OnGround() then
	return
	end
	ply:SetLocalVelocity(Vector(0,0,350) + (ply:EyeAngles():Up()*0 +  ply:GetForward()*200))
	end
	end
	end
	--high end--
if not( ply:Crouching() ) then
if ply:KeyDown(IN_SPEED)and ply:KeyDown(IN_FORWARD) then

	--hip--
	if not( ply:Crouching() ) then
	
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetUp() * 0) + (ply:GetForward() * -30)
	tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 100) + (ply:GetForward() * 30)
	tracedata.filter = ply
	local traceHipHigh2 = util.TraceLine(tracedata)
	
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetUp() * -10) + (ply:GetForward() * 1)
	tracedata.endpos = ply:EyePos()+ (ply:GetUp() * -32) + (ply:GetForward() * 64)
	tracedata.filter = ply
	local traceHipLow = util.TraceLine(tracedata)
	
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetUp() * -11) + (ply:GetForward() * 1)
	tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 63) + (ply:GetForward() * 64)
	tracedata.filter = ply
	local traceHipHigh = util.TraceLine(tracedata)
	if ply:KeyDown(IN_DUCK) then
	return
	end
	if (traceHipLow.Hit) and not (traceHipHigh.Hit) and not (traceHipHigh2.Hit) and not( ply:Crouching() ) then
	ply:ViewPunch(Angle(2, 1, -1));
	WallMountSound(ply)
	ply:SetLocalVelocity(Vector(0,0,300) + (ply:EyeAngles():Up()*0 +  ply:GetForward()*200))
	end
	end
	--hip end--
	
	end
	if ply.Lastclimbb and CurTime() >= ply.Lastclimbb and not( ply:Crouching() ) then
	--normal--
	tracedata={}
	tracedata.start = ply:EyePos()+(ply:GetForward()*1)+(ply:GetUp() * -10 )
	tracedata.endpos = ply:EyePos()+(ply:GetForward()*128)+(ply:GetUp() * 30)
	tracedata.filter = ply
	local traceAimObj = util.TraceLine(tracedata)
	
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetUp() * 0) + (ply:GetForward() * -30)
	tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 100) + (ply:GetForward() * 30)
	tracedata.filter = ply
	local traceNorHigh2 = util.TraceLine(tracedata)
	
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetUp() * -11) + (ply:GetForward() * 32)
	tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 20) + (ply:GetForward() * 64)
	tracedata.filter = ply
	local traceNorLow = util.TraceLine(tracedata)
	
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetUp() * 21) + (ply:GetForward() * 32)
	tracedata.endpos = ply:EyePos()+ (ply:GetUp() * 58) + (ply:GetForward() * 64)
	tracedata.filter = ply
	local traceNorHigh = util.TraceLine(tracedata)
	
	if (traceNorLow.Hit) and (traceAimObj.Hit) and not (traceNorHigh.Hit) and not (traceNorHigh2.Hit)and ply:KeyDown(IN_SPEED)and ply:KeyDown(IN_FORWARD) then
	ply:GetViewModel():SetNoDraw(true)
	ply.Lastclimbb = CurTime() + 1.5
	ply:SetLocalVelocity(Vector(0,0,400) + (ply:EyeAngles():Up()*0 +  ply:GetForward()*100))
	ply.ArmaEquipar = CurTime() + 0.5
	end
	--normal end--

	--WallRunRight--
	if ply:KeyDown(IN_MOVERIGHT) and ply:KeyDown(IN_SPEED)and ply:KeyDown(IN_FORWARD) then
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetUp() * -1) + (ply:GetForward() * 32)
	tracedata.endpos = ply:EyePos()+ (ply:GetUp() * -73) + (ply:GetForward() * 64)
	tracedata.filter = ply
	local traceWalRLow = util.TraceLine(tracedata)
	
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetForward() * 32)
	tracedata.endpos = ply:EyePos() + (ply:GetForward() * 64)
	tracedata.filter = ply
	local traceWalRHigh = util.TraceLine(tracedata)
	
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetRight() * 1)
	tracedata.endpos = ply:EyePos() + (ply:GetRight() * 32)
	tracedata.filter = ply
	local traceWalRRight = util.TraceLine(tracedata)
	
	if not (traceWalRLow.Hit) and not (traceWalRHigh.Hit) and (traceWalRRight.Hit) then
	ply:ViewPunch(Angle(0, 0, -15));
	WallRunSound(ply)
	ply:SetLocalVelocity(Vector(0,0,300) + (ply:EyeAngles():Right()*200 +  ply:GetForward()*450))
	ply.Lastclimbb = CurTime() + 1.5
	end
	end
	--WallRunRight end--
		--WallRunLeft--
	if ply:KeyDown(IN_MOVELEFT) and ply:KeyDown(IN_SPEED)and ply:KeyDown(IN_FORWARD) then
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetUp() * -1) + (ply:GetForward() * 32)
	tracedata.endpos = ply:EyePos()+ (ply:GetUp() * -73) + (ply:GetForward() * 64)
	tracedata.filter = ply
	local traceWalRLow = util.TraceLine(tracedata)
	
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetForward() * 32)
	tracedata.endpos = ply:EyePos() + (ply:GetForward() * 64)
	tracedata.filter = ply
	local traceWalRHigh = util.TraceLine(tracedata)
	
	tracedata={}
	tracedata.start = ply:EyePos() + (ply:GetRight() * -1)
	tracedata.endpos = ply:EyePos() + (ply:GetRight() * -32)
	tracedata.filter = ply
	local traceWalRRight = util.TraceLine(tracedata)
	
	if not (traceWalRLow.Hit) and not (traceWalRHigh.Hit) and (traceWalRRight.Hit) then
	ply:ViewPunch(Angle(0, 0, 15));
	WallRunSound(ply)
	ply:SetLocalVelocity(Vector(0,0,300) + (ply:EyeAngles():Right()*-200 +  ply:GetForward()*450))
	ply.Lastclimbb = CurTime() + 1.5
	end
	end
	--WallRunLeft end--
	
end
end
end
end
hook.Add("Think","climbb",climbb)
	
end
