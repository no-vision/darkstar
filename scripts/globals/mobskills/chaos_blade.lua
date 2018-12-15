---------------------------------------------
--  Chaos Blade
--
--  Description: Deals Dark damage to enemies within a fan-shaped area. Additional effect: Curse
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores Shadows
--  Range: Melee
--  Notes:
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 1

    local dmgmod = 2
    local info = MobMagicalMove(mob,target,skill,mob:getWeaponDmg() * 3,dsp.magic.ele.DARK,dmgmod,TP_MAB_BONUS,1)
<<<<<<< HEAD
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_MAGICAL,MOBPARAM_DARK,MOBPARAM_IGNORE_SHADOWS)
    target:delHP(dmg)
=======
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.MAGICAL,dsp.damageType.DARK,MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, dsp.attackType.MAGICAL, dsp.damageType.DARK)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types

    -- curse LAST so you don't die
    local typeEffect = dsp.effect.CURSE_I
    MobStatusEffectMove(mob, target, typeEffect, 25, 0, 420)

    return dmg
end
