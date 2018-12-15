---------------------------------------------
-- Empty Salvation
-- Damages all targets in range with the salvation of emptiness. Additional effect: Dispels 3 effects
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    target:dispelStatusEffect(dsp.effectFlag.DISPELABLE)
    target:dispelStatusEffect(dsp.effectFlag.DISPELABLE)
    target:dispelStatusEffect(dsp.effectFlag.DISPELABLE)

    local dmgmod = 1
    local info = MobMagicalMove(mob,target,skill,mob:getWeaponDmg() * 2,dsp.magic.ele.DARK,dmgmod,TP_MAB_BONUS,1)
<<<<<<< HEAD
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_MAGICAL,MOBPARAM_DARK,MOBPARAM_3_SHADOW)
    target:delHP(dmg)
=======
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.MAGICAL,dsp.damageType.DARK,MOBPARAM_3_SHADOW)
    target:takeDamage(dmg, mob, dsp.attackType.MAGICAL, dsp.damageType.DARK)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end
