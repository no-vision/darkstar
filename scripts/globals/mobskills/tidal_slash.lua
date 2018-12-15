---------------------------------------------
-- Tidal Slash
-- Deals water damage conal
-- Type: Magical
-- Only used when wielding a spear
-- Utsusemi/Blink absorb: 2-3 shadow
---------------------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    if mob:AnimationSub() == 0 and mob:getMainJob() == dsp.job.SAM then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
<<<<<<< HEAD
    local dmgmod = 3
    local info = MobMagicalMove(mob,target,skill,mob:getWeaponDmg()*3.5,dsp.magic.ele.WATER,dmgmod,TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_MAGICAL,MOBPARAM_WATER,MOBPARAM_3_SHADOW)
    target:delHP(dmg)
=======
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.PHYSICAL,dsp.damageType.SLASHING,info.hitslanded)
    target:takeDamage(dmg, mob, dsp.attackType.PHYSICAL, dsp.damageType.SLASHING)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end
