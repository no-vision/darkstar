---------------------------------------------------
-- Mountain Buster
-- Titan delivers an earth-shattering attack that roots its target in place.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 1
    local accmod = 2
    local dmgmod = 2
    local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_DMG_VARIES,1,2,3)
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.PHYSICAL,dsp.damageType.BLUNT,info.hitslanded)

    local typeEffect = dsp.effect.BIND

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 60)

<<<<<<< HEAD
    target:delHP(dmg)
=======
    target:takeDamage(dmg, mob, dsp.attackType.PHYSICAL, dsp.damageType.BLUNT)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg

end