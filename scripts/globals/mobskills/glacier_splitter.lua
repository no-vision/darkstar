---------------------------------------------
--  Glacier Splitter
--
--  Description: Cleaves into targets in a fan-shaped area. Additional effect: Paralyze
--  Type: Physical
--  Utsusemi/Blink absorb: 1-3 shadows
--  Range: Unknown cone
--  Notes: Only used the Aern wielding a sword (RDM, DRK, and PLD).
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = math.random(1,3)
    local accmod = 1
    local dmgmod = 1
    local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.PHYSICAL,dsp.damageType.SLASHING,info.hitslanded)

    local typeEffect = dsp.effect.PARALYSIS

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 15, 0, 120)

<<<<<<< HEAD
    target:delHP(dmg)
=======
    target:takeDamage(dmg, mob, dsp.attackType.PHYSICAL, dsp.damageType.SLASHING)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end
