---------------------------------------------------
-- Moonlit Charge M=4
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0,0
end

function onPetAbility(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 4

    local totaldamage = 0
    local damage = AvatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)
    totaldamage = AvatarFinalAdjustments(damage.dmg,pet,skill,target,dsp.attackType.PHYSICAL,dsp.damageType.BLUNT,numhits)
    target:addStatusEffect(dsp.effect.BLINDNESS, 20, 0, 30)
<<<<<<< HEAD
<<<<<<< HEAD
    target:delHP(totaldamage)
=======
    target:takeDamage(totaldamage, petdsp.attackType.PHYSICAL, dsp.damageType.BLUNT)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
=======
    target:takeDamage(totaldamage, pet, dsp.attackType.PHYSICAL, dsp.damageType.BLUNT)
>>>>>>> Addressing some typos and PR comments
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end