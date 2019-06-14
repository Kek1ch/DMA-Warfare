local V = {
			Name = "BTR70 RMK", 
			Class = "prop_vehicle_jeep_old",
			Category = "STALKER",
			Author = "Kek1ch",
			Information = "",
			Model = "models/kek1ch/btr70/btr70_remake.mdl",
			
			--[[	Btr70Seats	 = { 	
		P1 = { Pos = Vector(-30.0,-30.0,72.0), Ang = Angle(0,90,0) },
		P2 = { Pos = Vector(-30.0,-0.0,72.0), Ang = Angle(0,90,0) },
		
		P3 = { Pos = Vector(-30.0,30.0,72.0), Ang = Angle(0,90,0) },
		P4 = { Pos = Vector(-30.0,60.0,72.0), Ang = Angle(0,90,0) },
		
		P5 = { Pos = Vector(30.0,-30.0,72.0), Ang = Angle(0,-90,0) },
		P6 = { Pos = Vector(30.0,-0.0,72.0), Ang = Angle(0,-90,0) },
		
		P7 = { Pos = Vector(30.0,30.0,72.0), Ang = Angle(0,-90,0) },
		P8 = { Pos = Vector(30.0,60.0,72.0), Ang = Angle(0,-90,0) },
		
	},]]
	
	KeyValues = {
		vehiclescript	=	"scripts/vehicles/stalker/btr70_remake.txt"
	}
}
list.Set("Vehicles", "stalker_btr70", V)

--[[local function MakeEnt(name, ply)
    if !IsValid(ply) then return end
    local ent = ents.Create(name)

    if !IsValid(ent) then return end
    if !ent.CPPISetOwner then return ent end

    ent:CPPISetOwner(ply)
    return ent
end

local function SW_Spawn_Bus(ply, vehicle)

	local localpos = vehicle:GetPos() 
	local localang = vehicle:GetAngles()
	local Forward = localang:Forward()
	local Right = localang:Right()
	local Up = localang:Up()
	local Bus_Color01 = Color(255,255,255,255)
	
	if vehicle.VehicleTable then
		
		if vehicle.VehicleTable.Btr70Seats then	
		
			vehicle.Btr70Seats = {}
			local Seats = vehicle.VehicleTable.Btr70Seats
		
			for k,v in pairs(Seats) do
				local pos = localpos + ( Forward * v.Pos.x) + ( Right * v.Pos.y) + ( Up * v.Pos.z)
				local Seat = MakeEnt( "prop_vehicle_prisoner_pod", ply )
				if !IsValid(Seat) then continue end
			
				Seat:SetModel( "models/nova/jeep_seat.mdl" )
				Seat:SetNoDraw(true)
				Seat:SetKeyValue( "vehiclescript" , "scripts/vehicles/prisoner_pod.txt" )
				Seat:SetKeyValue( "limitview" , "0" )
				Seat:SetAngles( localang + v.Ang )
				Seat:SetPos( pos )
				Seat:DrawShadow( false )
				Seat:Spawn()
				Seat:Activate()
				Seat:SetParent(vehicle)
				Seat:SetCollisionGroup( COLLISION_GROUP_WORLD )
				Seat:SetMoveType( MOVETYPE_NONE )
				Seat.Isbtr70Part = true
				Seat.DoNotDuplicate = true
				vehicle:DeleteOnRemove( Seat )
			
				vehicle.Btr70Seats[k] = Seat
			end
		end
	end
end]]
hook.Add( "PlayerSpawnedVehicle", "Spawnbtr70", SW_Spawn_Bus )