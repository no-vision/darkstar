---------------------------------------------
--  Malevolent Blessing
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local typeEffect = dsp.effect.CURSE_I

    MobStatusEffectMove(mob, target, typeEffect, 35, 0, 45)

    local dmgmod = 1.25
    local info = MobMagicalMove(mob,target,skill,mob:getWeaponDmg() * 3,dsp.magic.ele.DARK,dmgmod,TP_MAB_BONUS,1)
<<<<<<< HEAD
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_MAGICAL,MOBPARAM_DARK,MOBPARAM_2_SHADOW)
    target:delHP(dmg)
=======
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.MAGICAL,dsp.damageType.DARK,MOBPARAM_2_SHADOW)
    target:takeDamage(dmg, mob, dsp.attackType.MAGICAL, dsp.damageType.DARK)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end
