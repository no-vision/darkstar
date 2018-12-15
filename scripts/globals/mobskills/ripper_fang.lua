---------------------------------------------
--  Sprout Smack
--
--  Description: Additional effect: Slow.  Duration of effect varies with TP.
--  Type: Physical (Blunt)
--
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, dsp.attackType.PHYSICAL, dsp.damageType.PIERCING, info.hitslanded)

    local typeEffect = dsp.effect.SLOW

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1250, 0, 120)

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 128, 0, 120)
<<<<<<< HEAD
    target:delHP(dmg)
=======
    target:takeDamage(dmg, mob, dsp.attackType.PHYSICAL, dsp.damageType.PIERCING)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end
