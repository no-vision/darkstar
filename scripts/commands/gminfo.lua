--
-- GM Command: GMINFO
-- Print player's GM information
-- ------------------------------------------
-- Same level or below will show GM Level
--

cmdprops =
{
    permission = 1,
    parameters = "ssi"
};

function error(player, msg)
    player:PrintToPlayer(msg);
    player:PrintToPlayer("!gminfo <player> <gm_attrib> <set_value>");
end;

function printCommands()
end;