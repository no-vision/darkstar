---------------------------------------------------
-- Spike Flail
-- Deals extreme damage in a threefold attack to targets behind the user.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target,mob,skill)
    if (mob:hasStatusEffect(dsp.effect.MIGHTY_STRIKES)) then
        return 1
    elseif (mob:hasStatusEffect(dsp.effect.SUPER_BUFF)) then
        return 1
    elseif (mob:hasStatusEffect(dsp.effect.INVINCIBLE)) then
        return 1
    elseif (mob:hasStatusEffect(dsp.effect.BLOOD_WEAPON)) then
        return 1
    elseif (target:isBehind(mob, 48) == false) then
        return 1
    elseif (mob:AnimationSub() == 1) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = math.random(5,7)
    local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_DMG_VARIES,2,3,4)
<<<<<<< HEAD
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_PHYSICAL,MOBPARAM_SLASH,MOBPARAM_3_SHADOW)
    target:delHP(dmg)
=======
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.PHYSICAL,dsp.damageType.SLASHING,MOBPARAM_3_SHADOW)
    target:takeDamage(dmg, mob, dsp.attackType.PHYSICAL, dsp.damageType.SLASHING)
>>>>>>> AttackType and DamageType are now provided to `CBattleEntity::takeDamage()` to enable tracking damage by types
    return dmg
end
