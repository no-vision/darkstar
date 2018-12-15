---------------------------------------------
--  Shield Strike
--
--  Description: Attempts to Shield Bash players.  Additional effect: Stun
--  Type: Physical
--  1 shadow?
--  Range: Melee front arc
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

   -- TODO: Knockback

    local numhits = 1
    local accmod = 1
    local dmgmod = 0.5
    local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.PHYSICAL,dsp.damageType.BLUNT,MOBPARAM_1_SHADOW)

   MobPhysicalStatusEffectMove(mob, target, skill, dsp.effect.STUN, 1, 0, 4)

    -- <100 damage to pretty much anything, except on rare occasions.
<<<<<<< HEAD
   target:delHP(dmg)
=======
   target:takeDamage(dmg, mob, dsp.attackType.PHYSICAL, dsp.damageType.BLUNT)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end
