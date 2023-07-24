--
--░░░░██╗░░░░░░░██╗██╗░░██╗░░███╗░░████████╗██████╗░
--░░░░██║░░██╗░░██║██║░░██║░████║░░╚══██╔══╝╚════██╗
--░░░░╚██╗████╗██╔╝███████║██╔██║░░░░░██║░░░░█████╔╝
--░░░░░████╔═████║░██╔══██║╚═╝██║░░░░░██║░░░░╚═══██╗
--██╗░░╚██╔╝░╚██╔╝░██║░░██║███████╗░░░██║░░░██████╔╝
--╚═╝░░░╚═╝░░░╚═╝░░╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═════╝░

---------------------------------------------------------------------------
--Администрация
---------------------------------------------------------------------------
TEAM_CADET = mopp.util.addjob('Контрактник', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsoldoff_g.mdl',
	weapons = {"salute"},
	jobID = 'cadet',
	spawn_group = "cadet",
	PlayerSpawn = function(ply)
		if game.GetMap() == "11" then
			ply:SetPos(spawn_training_e[math.random( 1, 4 )])
		end
	end
})

---------------------------------------------------------------------------
--Администрация
---------------------------------------------------------------------------
TEAM_ADMIN = mopp.util.addjob("Администратор", {
   Color = Color(255, 255, 0),
   WorldModel = 'models/humans/group02/player/tale_07.mdl',
   weapons = {"weapon_physgun","gmod_tool"},
 	jobID = 'admin',
 	group_id = "CT",
 	spawn_group = "Clones",
 	PlayerSpawn = function(ply)
 		ply:SetArmor(100)
 		--
 		if game.GetMap() == "11" then
 			ply:SetPos(spawn_sr_e[math.random( 1, 4 )])
 		end
 	end
 })

---------------------------------------------------------------------------
--ЧВК
---------------------------------------------------------------------------


TEAM_VAGNER1 = mopp.util.addjob('ССО | Стрелок', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/knyaje pack/fsb_rosn/fsb_rosn.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'vagner1',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(100)
		--
		if game.GetMap() == "11" then
			ply:SetPos(spawn_sr_e[math.random( 1, 4 )])
		end
	end
})

TEAM_VAGNER2 = mopp.util.addjob('ССО | Снайпер', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/knyaje pack/fsb_rosn/fsb_rosn.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'vagner2',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(100)
		--
		if game.GetMap() == "11" then
			ply:SetPos(spawn_sr_e[math.random( 1, 4 )])
		end
	end
})

TEAM_VAGNER3 = mopp.util.addjob('ССО | Санинструктор', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/knyaje pack/fsb_rosn/fsb_rosn.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'vagner3',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(100)
		--
		if game.GetMap() == "11" then
			ply:SetPos(spawn_sr_e[math.random( 1, 4 )])
		end
	end
})

TEAM_VAGNER4 = mopp.util.addjob('ССО | Пулеметчик', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/knyaje pack/fsb_rosn/fsb_rosn.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'vagner4',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(100)
		--
		if game.GetMap() == "11" then
			ply:SetPos(spawn_sr_e[math.random( 1, 4 )])
		end
	end
})

TEAM_VAGNER5 = mopp.util.addjob('ССО | Гранатометчик', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/knyaje pack/fsb_rosn/fsb_rosn.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'vagner5',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(100)
		--
		if game.GetMap() == "11" then
			ply:SetPos(spawn_sr_e[math.random( 1, 4 )])
		end
	end
})

TEAM_VAGNER6 = mopp.util.addjob('ССО | Командир Группы', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/knyaje pack/fsb_rosn/fsb_rosn.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'vagner6',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(100)
		--
		if game.GetMap() == "11" then
			ply:SetPos(spawn_sr_e[math.random( 1, 4 )])
		end
	end
})

---------------------------------------------------------------------------
--542-я гв. ОДШР Десантно-Штурмовая Рота
---------------------------------------------------------------------------
TEAM_MOR1 = mopp.util.addjob('542-я гв. ОДШР | Командир', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'mor0',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(75)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
	end
})

TEAM_MOR2 = mopp.util.addjob('542-я гв. ОДШР | Стрелок', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'mor2',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(50)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
	end
})

TEAM_MOR3 = mopp.util.addjob('542-я гв. ОДШР | Санинструктор', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'mor3',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(50)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
	end
})

TEAM_MOR4 = mopp.util.addjob('542-я гв. ОДШР | Снайпер', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'mor4',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(50)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
	end
})

TEAM_MOR5 = mopp.util.addjob('542-я гв. ОДШР | Пулеметчик', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'mor5',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(50)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
	end
})

TEAM_MOR6 = mopp.util.addjob('542-я гв. ОДШР | Гранатометчик', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'mor6',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(50)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
	end
})

TEAM_MOR7 = mopp.util.addjob('542-я гв. ОДШР | Танковый взвод', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'mor7',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(50)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
	end
})

TEAM_MOR8 = mopp.util.addjob('542-я гв. ОДШР | Водитель', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'mor8',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(50)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
	end
})
--120-ая

TEAM_ART1 = mopp.util.addjob('120-я гв. АБр | Наводчик', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'tank1',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(25)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_tank[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_tank_e[math.random( 1, 4 )])
		end
	end
})

TEAM_ART2 = mopp.util.addjob('120-я гв. АБр | Командир', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'tank2',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(50)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_tank[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_tank_e[math.random( 1, 4 )])
		end
	end
})

TEAM_ART3 = mopp.util.addjob('120-я гв. АБр | Инженер', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'tank3',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(50)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_tank[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_tank_e[math.random( 1, 4 )])
		end
	end
})

TEAM_ART4 = mopp.util.addjob('120-я гв. АБр | Заряжающий', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'tank4',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(50)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_tank[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_tank_e[math.random( 1, 4 )])
		end
	end
})


-- ВКС

TEAM_VVS = mopp.util.addjob('ВКС РФ | Летчик', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/knyaje pack/vks_rf/vks_pilot.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'vvs1',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(25)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vvs[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vvs_e[math.random( 1, 4 )])
		end
	end
})
TEAM_VVS1 = mopp.util.addjob('ВКС РФ |  Командир', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/knyaje pack/vks_rf/vks_pilot.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'vvs2',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(25)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vvs[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vvs_e[math.random( 1, 4 )])
		end
	end
})

TEAM_VVS2 = mopp.util.addjob('ВКС РФ |  Авиадиспетчер', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsoldoff_b.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'vvs3',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(25)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vvs[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vvs_e[math.random( 1, 4 )])
		end
	end
})
-- Опер.Штаб ВС РФ

TEAM_SHTAB1 = mopp.util.addjob('Опер.Штаб ВС РФ | Офицер ', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'shtab1',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(75)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_shtab[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_shtab_e[math.random( 1, 4 )])
		end
	end
})

TEAM_SHTAB2 = mopp.util.addjob('Опер.Штаб ВС РФ | Зам.Командира Авиабазы', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'shtab2',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(75)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_shtab[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_shtab_e[math.random( 1, 4 )])
		end
	end
})

TEAM_SHTAB3 = mopp.util.addjob('Опер.Штаб ВС РФ | Командир Авиабазы', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'shtab3',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(75)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_shtab[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_shtab_e[math.random( 1, 4 )])
		end
	end
})

-- ВП

TEAM_VP1 = mopp.util.addjob('Военная полиция | Сотрудник', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "radio", "weapon_cuff_police", "milsim_hands"},
	jobID = 'vp1',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(50)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vp[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vp_e[math.random( 1, 4 )])
		end
	end
})

TEAM_VP2 = mopp.util.addjob('Военная полиция | Саниструктор', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "radio", "weapon_cuff_police", "milsim_hands"},
	jobID = 'vp2',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(50)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vp[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vp_e[math.random( 1, 4 )])
		end
	end
})

TEAM_VP3 = mopp.util.addjob('Военная полиция | Комендант', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "weapon_cuff_police", "milsim_hands", "radio"},
	jobID = 'vp3',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(50)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vp[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vp_e[math.random( 1, 4 )])
		end
	end
})

TEAM_VP4 = mopp.util.addjob('Военная полиция | Инструктор', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "radio", "weapon_cuff_police", "milsim_hands"},
	jobID = 'vp4',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(50)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vp[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vp_e[math.random( 1, 4 )])
		end
	end
})

TEAM_VP5 = mopp.util.addjob('Военная полиция | Пулеметчик', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "radio", "weapon_cuff_police", "milsim_hands"},
	jobID = 'vp5',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(50)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vp[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_vp_e[math.random( 1, 4 )])
		end
	end
})

--ГВП

TEAM_GVP = mopp.util.addjob('Военная Прокуратура', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsoldoff_g.mdl',
	weapons = {"salute", "radio", "tfa_ins2_mp443", "milsim_hands"},
	jobID = 'gvp',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(100)
		--
		if game.GetMap() == "1" then
			ply:SetPos(spawn_sr_e[math.random( 1, 4 )])
		end
	end
})

TEAM_GVP1 = mopp.util.addjob('Военная Прокуратура | Следователь', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_01.mdl',
	weapons = {"salute", "radio", "tfa_ins2_mp443", "milsim_hands"},
	jobID = 'gvp1',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(100)
		--
		if game.GetMap() == "1" then
			ply:SetPos(spawn_sr_e[math.random( 1, 4 )])
		end
	end
})

TEAM_VDV1 = mopp.util.addjob('45 ОБрСпН | Снайпер', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_04.mdl',
	weapons = {"salute", "radio", "milsim_hands"},
	jobID = 'vdv1',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(100)
		--
		if game.GetMap() == "1" then
			ply:SetPos(spawn_sr_e[math.random( 1, 4 )])
		end
	end
})

TEAM_VDV2 = mopp.util.addjob('45 ОБрСпН | Штурмовик', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_04.mdl',
	weapons = {"salute", "radio", "milsim_hands"},
	jobID = 'vdv2',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(100)
		--
		if game.GetMap() == "1" then
			ply:SetPos(spawn_sr_e[math.random( 1, 4 )])
		end
	end
})

TEAM_VDV3 = mopp.util.addjob('45 ОБрСпН | Специалист', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_04.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'vdv3',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(100)
		--
		if game.GetMap() == "1" then
			ply:SetPos(spawn_sr_e[math.random( 1, 4 )])
		end
	end
})

TEAM_VDV4 = mopp.util.addjob('45 ОБрСпН | Пулеметчик', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_04.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'vdv4',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(100)
		--
		if game.GetMap() == "1" then
			ply:SetPos(spawn_sr_e[math.random( 1, 4 )])
		end
	end
})

TEAM_VDV5 = mopp.util.addjob('45 ОБрСпН | Гранатометчик', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_04.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'vdv5',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(100)
		--
		if game.GetMap() == "1" then
			ply:SetPos(spawn_sr_e[math.random( 1, 4 )])
		end
	end
})
--Игил

TEAM_TER1 = mopp.util.addjob('Игил | Глава', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/player/kuma/taliban_rpg.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'ter1',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(75)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
	end
})

TEAM_TER2 = mopp.util.addjob('Игил | Стрелок', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/player/kuma/taliban_bomber.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'ter2',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(75)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
	end
})

TEAM_TER3 = mopp.util.addjob('Игил | Снайпер', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/player/kuma/taliban_grunt.mdl',
	weapons = {"salute", "milsim_hands", "radio"},
	jobID = 'ter3',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(75)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
	end
})

TEAM_TER4 = mopp.util.addjob('Игил | Гранатометчик', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/player/kuma/alqaeda_commando.mdl',
	weapons = {"salute", "milsim_hands"},
	jobID = 'ter4',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(75)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
	end
})

--гражданский

TEAM_CIV = mopp.util.addjob('Гражданский', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/humans/group02/player/tale_04.mdl',
	weapons = {"salute", "weapon_doorlocker", "milsim_hands"},
	jobID = 'civ',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(75)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
	end
})

TEAM_DISB = mopp.util.addjob('ДисБат', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_01.mdl',
	weapons = {"salute", "milsim_hands"},
	jobID = 'disb',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(0)
	end
})

TEAM_313 = mopp.util.addjob('313-й ОМБ | Командир', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "weapon_medkit", "radio"},
	jobID = '313',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(0)
		ply:SetSubMaterial( 22, "models/med")
		ply:SetSubMaterial( 38, "models/med1")
	end
})

TEAM_3131 = mopp.util.addjob('313-й ОМБ | Медик', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/arma/rfsold_06.mdl',
	weapons = {"salute", "milsim_hands", "weapon_medkit", "radio"},
	jobID = '3131',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(0)
		ply:SetSubMaterial( 22, "models/med")
		ply:SetSubMaterial( 38, "models/med1")
	end
})

TEAM_PMC = mopp.util.addjob('PMC "Athlon" | Командир', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/humans/group02/player/tale_04.mdl',
	weapons = {"salute", "radio", "milsim_hands"},
	jobID = 'pmc',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(75)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
	end
})

TEAM_PMC1 = mopp.util.addjob('PMC "Athlon" | Сотрудник', {
	Color = Color(255, 255, 0),
	WorldModel = 'models/humans/group02/player/tale_04.mdl',
	weapons = {"salute", "milsim_hands"},
	jobID = 'pmc',
	group_id = "CT",
	spawn_group = "Clones",
	PlayerSpawn = function(ply)
		ply:SetArmor(75)
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
		if game.GetMap() == "1" then
			ply:SetPos(spawn_mor[math.random( 1, 4 )])
		end
	end
})