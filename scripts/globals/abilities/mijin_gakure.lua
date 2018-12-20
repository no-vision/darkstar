-----------------------------------
-- Ability: Mijin Gakure
-- Sacrifices user's life to deal damage to an enemy.
-- Obtained: Ninja Level 1
-- Recast Time: 1:00:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(player,target,ability)

    local dmg = (player:getHP() * 0.8) + (player:getMainLvl() / 0.5)
    local resist = applyPlayerResistance(player, nil, target, player:getStat(dsp.mod.INT)-target:getStat(dsp.mod.INT), 0, dsp.magic.ele.NONE)

    dmg = dmg * resist

<<<<<<< HEAD
    target:delHP(dmg)
=======
    dmg = utils.stoneskin(target, dmg)
<<<<<<< HEAD
    target:takeDamage(dmg, player, dsp.attackType.SPECIAL, dsp.damageType.NONE)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
=======
    target:takeDamage(dmg, player, dsp.attackType.SPECIAL, dsp.damageType.ELEMENTAL)
>>>>>>> Addressing some typos and PR comments

    player:setLocalVar("MijinGakure", 1)
    player:setHP(0)
    return dmg
end
