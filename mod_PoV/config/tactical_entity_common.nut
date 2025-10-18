::Const.Tactical.Common.onApplyPovMiasma <- function(_tile, _entity)
{
	if (!_entity.getFlags().has("undead") && !_entity.getCurrentProperties().IsImmuneToPoison)
	{
		local damageMult = _entity.getCurrentProperties().IsResistantToMiasma ? 0.5 : 1.0;
		::Tactical.spawnIconEffect("status_effect_00", _tile, ::Const.Tactical.Settings.SkillIconOffsetX, ::Const.Tactical.Settings.SkillIconOffsetY, ::Const.Tactical.Settings.SkillIconScale, ::Const.Tactical.Settings.SkillIconFadeInDuration, ::Const.Tactical.Settings.SkillIconStayDuration, ::Const.Tactical.Settings.SkillIconFadeOutDuration, ::Const.Tactical.Settings.SkillIconMovement);
		local sounds = [];
		if (_entity.getFlags().has("human"))
			sounds = [
				"sounds/humans/human_coughing_01.wav",
				"sounds/humans/human_coughing_02.wav",
				"sounds/humans/human_coughing_03.wav",
				"sounds/humans/human_coughing_04.wav"
			];
		else
			sounds = [
				"sounds/enemies/miasma_appears_01.wav",
				"sounds/enemies/miasma_appears_02.wav",
				"sounds/enemies/miasma_appears_03.wav"
			];	

		_entity.getSkills().add(this.new("scripts/skills/effects/pov_miasma_effect"));

		::Sound.play(sounds[::Math.rand(0, sounds.len() - 1)], ::Const.Sound.Volume.Actor, _entity.getPos());
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = this.Math.rand(4, 8) * damageMult;
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = ::Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;		
		_entity.onDamageReceived(_entity, null, hitInfo);
	}			
};
