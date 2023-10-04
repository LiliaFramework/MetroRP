MODULE.name = "Passports New"
MODULE.author = "Pilot"
MODULE.desc = "Adds passports that contain char information"

lia.util.include("cl_write.lua")

if (SERVER) then
	util.AddNetworkString("nutMetroPassportWrite")
	util.AddNetworkString("nutMetroPassportSend")
	util.AddNetworkString("nutMetroPassportRead")
	util.AddNetworkString("OpenPassport")
end