---------------------------------------------
--  Dynamic Implosion
--
--  Description: Deals damage to players within an area of effect. Additional effect: Stun (Status Effect)
--  Type: Physical
--  Utsusemi/Blink absorb: Unknown
--  Range: Unknown radial
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
    local accmod = 1
    local dmgmod = 2.5
    
    local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_DMG_VARIES,1,2,3)
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.PHYSICAL,dsp.damageType.SLASHING,info.hitslanded)

    MobPhysicalStatusEffectMove(mob, target, skill, dsp.effect.STUN, 1, 0, 7)
    
<<<<<<< HEAD
    target:delHP(dmg)
=======
    target:takeDamage(dmg, mob, dsp.attackType.PHYSICAL, dsp.damageType.SLASHING)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
    
end
