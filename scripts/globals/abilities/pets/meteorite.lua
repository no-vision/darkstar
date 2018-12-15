---------------------------------------------------
-- Meteorite
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0,0
end

function onPetAbility(target, pet, skill)
    local dint = pet:getStat(dsp.mod.INT) - target:getStat(dsp.mod.INT)
    local dmg = 500 + dint*1.5 + skill:getTP()/20
    target:updateEnmityFromDamage(pet,dmg)
<<<<<<< HEAD
    target:delHP(dmg)
=======
    target:takeDamage(dmg, pet, dsp.attackType.MAGICAL, dsp.damageType.LIGHT)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end