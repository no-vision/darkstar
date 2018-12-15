---------------------------------------------------
-- Homing Missle
--
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local targetcurrentHP = target:getHP()
    local targetmaxHP = target:getMaxHP()
    local hpset=targetmaxHP*0.20
    local typeEffect = dsp.effect.BIND

    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 30)

    if (targetcurrentHP > hpset) then
        dmg= targetcurrentHP - hpset
    else
        dmg=0
    end

<<<<<<< HEAD
    target:delHP(dmg)
=======
    target:takeDamage(dmg, mob, dsp.attackType.MAGICAL, dsp.damageType.NONE)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end