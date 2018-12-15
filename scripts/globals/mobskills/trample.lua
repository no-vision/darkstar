---------------------------------------------------
--  Trample
--  Family: Bahamut
--  Description: Deals physical damage to enemies in an area of effect. Additional effect: Knockback + Bind
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range:
--  Notes:
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = dsp.effect.BIND
    local duration = 30
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, duration)

    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_NO_EFFECT)
<<<<<<< HEAD
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_PHYSICAL,MOBPARAM_SLASH,MOBPARAM_3_SHADOW)
    target:delHP(dmg)
=======
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.PHYSICAL,dsp.damageType.SLASHING,MOBPARAM_3_SHADOW)
    target:takeDamage(dmg, mob, dsp.attackType.PHYSICAL, dsp.damageType.SLASHING)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end
