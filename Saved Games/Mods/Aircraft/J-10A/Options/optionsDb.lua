local DbOption  = require('Options.DbOption')
local Range 	= DbOption.Range
local i18n	    = require('i18n')
local oms       = require('optionsModsScripts')

local _ = i18n.ptranslate


-- find the relative location of optionsDb.lua
function script_path() 
    -- remember to strip off the starting @ 
	local luafileloc = debug.getinfo(2, "S").source:sub(2)
	local ti, tj = string.find(luafileloc, "Options")
	local temploc = string.sub(luafileloc, 1, ti-1)
    return temploc
end 

-- find module path
local relativeloc = script_path()
modulelocation = lfs.currentdir().."\\"..relativeloc

local tblCPLocalList = oms.getTblCPLocalList(modulelocation)

return {
		J10A_LOAOUT_enabled 	= DbOption.new():setValue(true):checkbox(),
		PL11_enabled 			= DbOption.new():setValue(true):checkbox(),
		PL15_enabled 			= DbOption.new():setValue(true):checkbox(),
		}