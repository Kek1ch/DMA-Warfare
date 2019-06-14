local V = {
			Name = "Niva Fixed", 
			Class = "prop_vehicle_jeep",
			Category = "DayZ",
			Author = "_TailS_ & Fix 4 SSK Kek1ch",
			Information = "Driveable Niva by _TailS_",
			Model = "models/kek1ch/niva/niva_fixed.mdl",
			VC_Lights = {

                {Pos = Vector(25.677, 74.0, 31.541), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.1, DynLightBrightness = 1, HeadColor = "255 255 255", DynLight = true, DynamicSize = 0.1, HeadLightAngle = "0 90 0"},
				{Pos = Vector(-25.677, 74.0, 31.541), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.1, DynLightBrightness = 1, HeadColor = "255 255 255", DynLight = true, DynamicSize = 0.1, HeadLightAngle = "0 90 0"},

				{Pos = Vector(23.316,74.0, 40.027), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.2, DynLight = true, NormalColor = "245 245 245"},
				{Pos = Vector(-23.316,74.0, 40.027), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.2, DynLight = true, NormalColor = "245 245 245"},
				
				{Pos = Vector(27.401, 74.05, 39.934), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.10, DynLight = true, BlinkersColor = "200 80 0"},
				{Pos = Vector(-27.401, 74.05, 39.934), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.10, DynLight = true, BlinkersColor = "200 80 0"},
				
				{Pos = Vector(-33.933, 65.298, 38.854), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.3, DynLight = true, BlinkersColor = "200 80 0"},
				{Pos = Vector(33.933, 65.298, 38.854), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.3, DynLight = true, BlinkersColor = "200 80 0"},
	
				{Pos = Vector(-25.172, -77.805, 37.14), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.2, DynLight = true, BlinkersColor = "200 80 0"},
				{Pos = Vector(25.172, -77.805, 37.14), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.2, DynLight = true, BlinkersColor = "200 80 0"},
				
				{Pos = Vector(-20.542, -77.805, 38.886), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.4, DynLight = true, NormalColor = "255 0 0"},
				{Pos = Vector(20.542, -77.805, 38.886), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.4, DynLight = true, NormalColor = "255 0 0"},
				
				{Pos = Vector(-20.542, -77.805, 35.199), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.2, DynLight = true, NormalColor = "255 0 0"},
				{Pos = Vector(20.542, -77.805, 35.199), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.2, DynLight = true, NormalColor = "255 0 0"},
				
				{Pos = Vector(-15.719, -77.805, 36.908), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.2, DynLight = true, BrakeColor = "255 0 0"},
				{Pos = Vector(15.719, -77.805, 36.908), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.2, DynLight = true, BrakeColor = "255 0 0"},
				
				{Pos = Vector(-20.542, -77.805, 36.908), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.2, DynLight = false, ReverseColor = "255 255 255"},
				{Pos = Vector(20.542, -77.805, 36.908), Mat = "sprites/blueflare1.vmt", Alpha = 245, Size = 0.2, DynLight = false, ReverseColor = "255 255 255"},
				
				{Pos = Vector(-25.905,88.655, 53.979), Size = 0.3, GlowSize = 0.4, HeadLightAngle = Angle(5, 100, 0)},
				{Pos = Vector(25.905,88.655, 53.979), Size = 0.3, GlowSize = 0.4, HeadLightAngle = Angle(5, 80, 0)}				
						},
			VC_Exhaust_Dissipate = true,
			
			VC_Exhaust = { 
				{Pos = Vector(-26.627, -81.295, 22.413), Ang = Angle(0,0,0), EffectIdle = "Exhaust", EffectStress = "Exhaust"},
						 },
						
			VC_ExtraSeats = { 
				{Pos = Vector(18.7, 4.0, 37.092), Ang = Angle(0, 0, 0), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(0, 0, 0), Hide = true, DoorSounds = true, RadioControl = true},
				{Pos = Vector(-21.7, -30.0, 37.092), Ang = Angle(0, 0, 0), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(0, 0, 0), Hide = true, DoorSounds = true, RadioControl = true},
				{Pos = Vector(0.0, -30.0, 37.092), Ang = Angle(0, 0, 0), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(0, 0, 0), Hide = true, DoorSounds = true, RadioControl = true},
				{Pos = Vector(21.7, -30.0, 37.092), Ang = Angle(0, 0, 0), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(0, 0, 0), Hide = true, DoorSounds = true, RadioControl = true},
				{Pos = Vector(0.0, -60.0, 45.0), Ang = Angle(0, -70, 90), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(0, 0, 0), Hide = true, DoorSounds = true, RadioControl = true},
				{Pos = Vector(0, 55.0, 20.0), Ang = Angle(0, 0, 0), EnterRange = 80, ExitAng = Angle(0, -90, 0), Model = "models/props_phx/carseat2.mdl", ModelOffset = Vector(0, 0, 0), Hide = true, DoorSounds = true, RadioControl = true},
							},
			VC_Horn = {Sound = "vehicles/vc_horn_light.wav", Pitch = 90, Looping = false},
			
			KeyValues = {
vehiclescript	=	"scripts/vehicles/Lada/Vaz/niva_fixed.txt"
						}
			}
list.Set("Vehicles", "dayz_niva", V)