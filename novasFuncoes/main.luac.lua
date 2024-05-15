WARN_MONEY_AMOUNT = 1000000
WARN_MONEY_COOLDOWN = 1
ALLOWED_STAFF_SERIALS = {
  ["03E5E08D0E6653422D276F7AB35E9A33"] = true,
  ["9CB29E2BFF11A6D573B19090CD5F5E42"] = true,
  ["B6F64F26DC6869F97E535237742DEAD3"] = true,
  ["C04FB4BC4D98E5E002CBCA2B0D6064B2"] = true,
  ["DF24F0B478E14CDF773259BF7933B6F4"] = true,
  ["7D8ABDE2BE9AE8FE772FB7D888282B63"] = true,
  ["8FBB1ABFA6E38A61F6865EE53C4D41F4"] = true,
  ["A63181A2ECF65130A80E5888D0C6D8B4"] = true,
  ["A7E2180D89CCE7E627BBE528BA4D8B94"] = true,
  ["3D8E70DF14DE0F6C2E7BD641252551E3"] = true,
  ["54CC35D0FF1B6E9713ABB414482C8C13"] = true,
  ["AB4D1641EB55D601AB38F53A78451394"] = true,
  ["FE0448FB3D845E147125BC38C7BE4391"] = true,
  ["DC80581ABADAE8DAC8B6101D7B6ACE94"] = true,
  ["F2BABC301DE37F8B2191A2EB89FFEFE3"] = true,
  ["FF13E1CC37471808E6A56F2EC30BA634"] = true,
  ["D9510035F00919A1B852BDBABA16A7B2"] = true,
  ["940D75775068895FB7793473746E514F"] = true,
  ["6B5CA8EC41E90527239889A7E7F7CCF4"] = true,
  ["5EA73801164B275FF8400546ED29A3F3"] = true,
  ["D134C4CE5F0C8240184F9364FE0AACB2"] = true,
  ["3C81948BF0B9C363A4C9F9BB76F7A9A1"] = true
}
SUSPECTS = {}
FORBIDDEN_NICKNAMES = {pao = true}
FORBIDDEN_WORDS = {
  ["cheat"] = true,
  ["hack"] = true,
  ["rack"] = true,
  ["hacker"] = true,
  ["hax"] = true,
  ["hacks"] = true,
  ["haxs"] = true,
  ["xit"] = true,
  ["xiter"] = true,
  ["xitado"] = true,
  ["xitando"] = true,
  ["0xcheat"] = true,
  ["0xcheats"] = true,
  ["vbr"] = true,
  ["menu"] = true,
  ["antirp"] = true,
  ["rdm"] = true,
  ["explodir"] = true,
  ["wecheat"] = true,
  ["wecheats"] = true,
  ["gna"] = true,
  ["gnaplay"] = true,
  ["mych"] = true,
  ["prz"] = true,
  ["massivo"] = true,
  ["masivo"] = true,
  ["dupar"] = true,
  ["dup"] = true,
  ["dupando"] = true,
  ["bypass"] = true,
  ["injetar"] = true,
  ["aimbot"] = true,
  ["aimb0t"] = true,
  ["paozin"] = true,
  [".gg"] = true,
  [".net"] = true
}
function getCodeAC(_ARG_0_)
  return _UPVALUE0_[_ARG_0_] or "Desconhecido"
end
function getForbiddenWords()
  return FORBIDDEN_WORDS
end
function sendDiscord(_ARG_0_)
  if not _ARG_0_.player then
    if not isElement(localPlayer) then
      outputDebugString("sendDiscordEmbed: player isn't defined and localPlayer is not valid.")
      return false
    end
    _ARG_0_.player = localPlayer
  end
  if _ARG_0_.action then
  else
  end
  if not _ARG_0_.notify then
    _ARG_0_.notify = ""
  else
    _ARG_0_.notify = " " .. _ARG_0_.notify
  end
  if not _ARG_0_.content then
    _ARG_0_.content = "@"
  end
  if _ARG_0_.screenshot then
    if isElement(localPlayer) then
      exports.destiny_discord:takeScreenshot({
        title = _ARG_0_.title or "?",
        content = _ARG_0_.content .. _ARG_0_.notify,
        fields = {
          {
            name = "\240\159\149\181\239\184\143 Personagem",
            value = getPlayerName(_ARG_0_.player):gsub("_", " ") .. "#" .. (getElementData(_ARG_0_.player, "character:id") or isElement(localPlayer) and getPlayerSerial() or getPlayerSerial(_ARG_0_.player)),
            inline = true
          },
          {
            name = "\240\159\147\156 Detalhes",
            value = _ARG_0_.details or "N/A",
            inline = true
          },
          {
            name = "\240\159\145\174 Puni\195\167\195\163o",
            value = "O jogador foi " .. (_UPVALUE0_[_ARG_0_.action] or "???") .. "." or "Nenhuma."
          }
        }
      }, _ARG_0_.webhook)
    else
      exports.destiny_discord:takeScreenshot(_ARG_0_.player, {
        title = _ARG_0_.title or "?",
        content = _ARG_0_.content .. _ARG_0_.notify,
        fields = {
          {
            name = "\240\159\149\181\239\184\143 Personagem",
            value = getPlayerName(_ARG_0_.player):gsub("_", " ") .. "#" .. (getElementData(_ARG_0_.player, "character:id") or isElement(localPlayer) and getPlayerSerial() or getPlayerSerial(_ARG_0_.player)),
            inline = true
          },
          {
            name = "\240\159\147\156 Detalhes",
            value = _ARG_0_.details or "N/A",
            inline = true
          },
          {
            name = "\240\159\145\174 Puni\195\167\195\163o",
            value = "O jogador foi " .. (_UPVALUE0_[_ARG_0_.action] or "???") .. "." or "Nenhuma."
          }
        }
      }, _ARG_0_.webhook)
    end
  else
    exports.destiny_discord:send(_ARG_0_.webhook, {
      content = _ARG_0_.content .. _ARG_0_.notify,
      embeds = {
        {
          title = _ARG_0_.title or "?",
          description = _ARG_0_.description or "\226\128\142",
          fields = {
            {
              name = "\240\159\149\181\239\184\143 Personagem",
              value = getPlayerName(_ARG_0_.player):gsub("_", " ") .. "#" .. (getElementData(_ARG_0_.player, "character:id") or isElement(localPlayer) and getPlayerSerial() or getPlayerSerial(_ARG_0_.player)),
              inline = true
            },
            {
              name = "\240\159\147\156 Detalhes",
              value = _ARG_0_.details or "N/A",
              inline = true
            },
            {
              name = "\240\159\145\174 Puni\195\167\195\163o",
              value = "O jogador foi " .. (_UPVALUE0_[_ARG_0_.action] or "???") .. "." or "Nenhuma."
            }
          },
          color = 5594094,
          footer = {
            text = os.date("%d/%m/%Y \195\160s %H:%M:%S", getRealTime().timestamp)
          }
        }
      }
    })
  end
end
