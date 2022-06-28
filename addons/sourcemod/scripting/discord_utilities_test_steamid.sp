#include <sourcemod>
#include <discord_utilities>

public void OnPluginStart()
{
    RegConsoleCmd("sm_discord_steamid", CommandDiscordSteamId);
}

public Action CommandDiscordSteamId(int client, int args)
{
    char szSteamId[32];
    GetCmdArg(1, szSteamId, sizeof(szSteamId));

    char szTest[32];
    Format(szTest, sizeof(szTest), "Teste123");

    DataPack data = new DataPack();
    data.WriteString(szTest);

    DU_GetUserIdBySteamId(szSteamId, OnLoadedUserId, data);
    return Plugin_Handled;
}

public void OnLoadedUserId(const char[] szSteamId, const char[] discordId, any data)
{
    char szTest[32];

    DataPack dPack = view_as<DataPack>(data);
    dPack.Reset();
    dPack.ReadString(szTest, sizeof(szTest));
    delete dPack;
    
    PrintToChatAll("Steam ID: %s | Discord ID: %s | szTest: %s", szSteamId, discordId, szTest);
}