function pMeta:isNearWhitelist()
	return self:GetUserGroup() == 'founder' or serverguard.player:GetImmunity(self) > 20
end