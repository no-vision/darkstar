---------------------------------------------
-- Incinerate
-- Description: Deals Fire damage to targets in a fan-shaped area of effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = MobBreathMove(mob, target, 0.25, 0.75, dsp.magic.ele.FIRE)
    local dmg = MobFinalAdjustments(dmgmod,mob,skill,target,dsp.attackType.BREATH,dsp.damageType.FIRE,MOBPARAM_IGNORE_SHADOWS)

<<<<<<< HEAD
    target:delHP(dmg)
=======
    target:takeDamage(dmg, mob, dsp.attackType.BREATH, dsp.damageType.FIRE)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end
