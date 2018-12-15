---------------------------------------------
-- Fulmination
--
-- Description: Deals heavy magical damage in an area of effect. Additional effect: Paralysis + Stun
-- Type: Magical
-- Utsusemi/Blink absorb: Wipes Shadows
-- Range: 30 yalms
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    if(mob:getFamily() == 316) then
        local mobSkin = mob:getModelId()

        if (mobSkin == 1805) then
            return 0
        else
            return 1
        end
    end
    local family = mob:getFamily()
    local mobhp = mob:getHPP()
    local result = 1

    if (family == 168 and mobhp <= 35) then -- Khimaira < 35%
        result = 0
    elseif (family == 315 and mobhp <= 50) then -- Tyger < 50%
        result = 0
    end

    return result
end

function onMobWeaponSkill(target, mob, skill)

-- TODO: Hits all players near Khimaira, not just alliance.

    local dmgmod = 3
    local info = MobMagicalMove(mob,target,skill,mob:getWeaponDmg() * 4,dsp.magic.ele.THUNDER,dmgmod,TP_MAB_BONUS,1)
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.MAGICAL,dsp.damageType.LIGHTNING,MOBPARAM_WIPE_SHADOWS)
    MobStatusEffectMove(mob,target,dsp.effect.PARALYSIS, 40, 0, 60)
    MobStatusEffectMove(mob,target,dsp.effect.STUN, 1, 0, 4)

<<<<<<< HEAD
    target:delHP(dmg)
=======
    target:takeDamage(dmg, mob, dsp.attackType.MAGICAL, dsp.damageType.LIGHTNING)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end
