---------------------------------------------
-- Hane Fubuki
-- Description: Additional effect: Poison. Chance of effect varies with TP.
-- Type: Physical (Piercing)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 3
    local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_DMG_VARIES,1,2,3)
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.PHYSICAL,dsp.damageType.PIERCING,info.hitslanded)

    local typeEffect = dsp.effect.POISON

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, mob:getMainLvl()/7, 3, 120)

<<<<<<< HEAD
    target:delHP(dmg)
=======
    target:takeDamage(dmg, mob, dsp.attackType.PHYSICAL, dsp.damageType.PIERCING)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end
