---------------------------------------------
-- Zantetsuken
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0,0
end

function onPetAbility(target, pet, skill, master)
    local power = master:getMP() / master:getMaxMP()
    master:setMP(0)

    if (target:isNM()) then
        local dmg = 0.1 * target:getHP() + 0.1 * target:getHP() * power
        if (dmg > 9999) then
            dmg = 9999
        end
        dmg = MobMagicalMove(pet,target,skill,dmg,dsp.magic.ele.DARK,1,TP_NO_EFFECT,0)
        dmg = mobAddBonuses(pet, nil, target, dmg.dmg, dsp.magic.ele.DARK)
<<<<<<< HEAD
        dmg = AvatarFinalAdjustments(dmg,pet,skill,target,MOBSKILL_MAGICAL,MOBPARAM_NONE,1)
        target:delHP(dmg)
=======
        dmg = AvatarFinalAdjustments(dmg,pet,skill,target,dsp.attackType.MAGICAL,dsp.damageType.DARK,1)
        target:takeDamage(damage, pet, dsp.attackType.MAGICAL, dsp.damageType.DARK)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
        target:updateEnmityFromDamage(pet,dmg)
        return dmg
    else
        local chance = (100 * power) / skill:getTotalTargets()
        if math.random(0,99) < chance and target:getAnimation() ~= 33 then
            skill:setMsg(dsp.msg.basic.SKILL_ENFEEB_IS)
<<<<<<< HEAD
            target:delHP(target:getHP())
=======
            target:takeDamage(target:getHP(), pet, dsp.attackType.MAGICAL, dsp.damageType.DARK)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
            return dsp.effect.KO
        else
            skill:setMsg(dsp.msg.basic.EVADES)
            return 0
        end
    end
end
