mopp.jobs = {}
local indexnum = 1
function mopp.util.addjob(name, job)
	indexnum = indexnum + 1

	team.SetUp( indexnum, name, job.Color )
	job['index'] = indexnum
	job.Name = name or ''
	
	if SERVER then
		util.PrecacheModel(job.WorldModel)
	else
		job.PlayerSpawn = nil
		job.weapons = nil
		-- job.spawn_group = nil
		job.group_id = nil
		job.WorldModel = nil
		job.Color = nil
	end

	table.insert( mopp.jobs, indexnum,  job )

	return indexnum
end

function mopp.FindJob(index)
	return mopp.jobs[index] or false
end

function mopp.FindJobByID(strID)
	for _, job in pairs(mopp.jobs) do
		if job.jobID == strID then
			return job
		end
	end
end