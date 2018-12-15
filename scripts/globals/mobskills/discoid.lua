---------------------------------------------
-- Discoid
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local needles = 10000 / skill:getTotalTargets()
    local dmg = MobFinalAdjustments(needles, mob, skill, target, dsp.attackType.MAGICAL, dsp.damageType.LIGHT, MOBPARAM_WIPE_SHADOWS)

<<<<<<< HEAD
    target:delHP(dmg)
=======
    target:takeDamage(dmg, mob, dsp.attackType.MAGICAL, dsp.damageType.LIGHT)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types

    return dmg
end