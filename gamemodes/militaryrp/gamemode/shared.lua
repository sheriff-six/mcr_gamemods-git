-- Define a global shared table to store gamemode information.
jetplayers = mopp and mopp.jetplayers or jetplayers

mopp = {
	cfg = cfg or {
		data = {}
	}, 
	jobs = {},
	util = util or {}, 
	cmd = cmd or { 
		data = {}
	}
} 

mopp.jetplayers = jetplayers or {}

GM = GM or GAMEMODE
GAMEMODE = GM or GAMEMODE

-- Metatables.
pMeta = FindMetaTable( 'Player' ) 
eMeta = FindMetaTable( 'Entity' )
vMeta = FindMetaTable( 'Vector' )

-- Set up basic gamemode values.
GM.Name 		= 'MilitaryRP' -- Gamemode name.
GM.Author 		= 'Mopple team' -- Author name.
GM.Email 		= '_' -- Author email.
GM.Website 		= 'http://mopple.ru' -- Website.

DeriveGamemode('sandbox')

mopp.util.CurentMap = game.GetMap()

-- TODO: move
