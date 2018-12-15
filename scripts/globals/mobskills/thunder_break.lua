---------------------------------------------------
-- Thunder Break
-- Channels the power of Thunder toward targets in an area of effect. Additional effect: Stun

---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = dsp.effect.STUN

    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 4)

    local dmgmod = 1
    local info = MobMagicalMove(mob,target,skill,mob:getWeaponDmg()*3.2,dsp.magic.ele.THUNDER,dmgmod,TP_MAB_BONUS,1)
<<<<<<< HEAD
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_MAGICAL,MOBPARAM_THUNDER,MOBPARAM_WIPE_SHADOWS)
    target:delHP(dmg)
=======
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.MAGICAL,dsp.damageType.LIGHTNING,MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, dsp.attackType.MAGICAL, dsp.damageType.LIGHTNING)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end
