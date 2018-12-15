---------------------------------------------------
-- Self-Destruct
--
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target,mob,skill)
    if (mob:isMobType(MOBTYPE_NOTORIOUS) or mob:getHPP() > 75) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
        BOMB_TOSS_HPP = skill:getHPP() / 100

    local info = MobMagicalMove(mob,target,skill,mob:getWeaponDmg()*18*BOMB_TOSS_HPP,dsp.magic.ele.FIRE,dmgmod,TP_MAB_BONUS,1)
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.MAGICAL,dsp.damageType.FIRE,MOBPARAM_IGNORE_SHADOWS)
    mob:setHP(0)
<<<<<<< HEAD
    target:delHP(dmg)
=======
    target:takeDamage(dmg, mob, dsp.attackType.MAGICAL, dsp.damageType.FIRE)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end
