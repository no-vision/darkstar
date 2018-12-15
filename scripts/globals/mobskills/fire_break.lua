---------------------------------------------
-- Fire Break
-- Description: Deals fire damage to enemies within a fan-shaped area originating from the caster.
-- Type: Magical (Fire)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = MobBreathMove(mob, target, 0.5, 1, dsp.magic.ele.FIRE, 700)
    local dmg = MobFinalAdjustments(dmgmod,mob,skill,target,dsp.attackType.BREATH,dsp.damageType.FIRE,MOBPARAM_IGNORE_SHADOWS)

<<<<<<< HEAD
    target:delHP(dmg)
=======
    target:takeDamage(dmg, mob, dsp.attackType.BREATH, dsp.damageType.FIRE)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end
