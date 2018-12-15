---------------------------------------------------
-- Brain Drain
-- Deals damage to a single target. Additional effect: INT Down
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.MAGICAL,dsp.damageType.DARK,info.hitslanded)

    local typeEffect = dsp.effect.INT_DOWN

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 10, 3, 120)

<<<<<<< HEAD
    target:delHP(dmg)
=======
    target:takeDamage(dmg, mob, dsp.attackType.MAGICAL, dsp.damageType.DARK)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types

    return dmg
end
