ENT.Type 		= "anim"
ENT.Base 		= "wick_base" 
ENT.Category 		= "STRP" 
 
ENT.PrintName	= "Дверь в бар"
ENT.Author		= "WickedRabbit" 
ENT.Contact		= "" 
 
ENT.Spawnable		= true --Spawnable?
ENT.AdminSpawnable	= false --If spawnable, is it admin only?
   
 
function ENT:Draw() 
	self:DrawModel()  
end
