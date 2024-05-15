addEventHandler("onDebugMessage", root, function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  for _FORV_7_, _FORV_8_ in ipairs(_UPVALUE0_) do
    if _ARG_0_:find(_UPVALUE0_[_FORV_7_]) then
      cancelEvent(true)
      return
    end
  end
  return
end)
function math_random(...)
  if ({
    ...
  })[1] == nil then
    mini = 0
    maxi = 0
  elseif ({
    ...
  })[2] == nil then
    mini = ({
      ...
    })[1]
    maxi = 1
  else
    mini = ({
      ...
    })[1]
    maxi = ({
      ...
    })[2]
  end
  if mini > maxi then
    tmp = maxi
    maxi = mini
    mini = tmp
  end
  _UPVALUE0_ = _UPVALUE0_ + 1
  if _UPVALUE0_ == 56 then
    _UPVALUE0_ = 1
  end
  _UPVALUE1_ = _UPVALUE1_ + 1
  if _UPVALUE1_ == 56 then
    _UPVALUE1_ = 1
  end
  if _UPVALUE2_[_UPVALUE0_] - _UPVALUE2_[_UPVALUE1_] < _UPVALUE3_ then
  end
  _UPVALUE2_[_UPVALUE0_] = _UPVALUE2_[_UPVALUE0_] - _UPVALUE2_[_UPVALUE1_] + _UPVALUE4_
  return _UPVALUE6_((_UPVALUE2_[_UPVALUE0_] - _UPVALUE2_[_UPVALUE1_] + _UPVALUE4_) * _UPVALUE5_ * (1 + maxi - mini) + mini)
end
addDebugHook("postFunction", function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, ...)
  return "skip"
end, {
  "addDebugHook"
})
addDebugHook("preFunction", function(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_, ...)
  return "skip"
end, {
  "addDebugHook"
})
function c3RhcnQ(_ARG_0_)
  if _ARG_0_ then
    _UPVALUE0_ = "Yml4b2JpcnVsZWlkZWxlaWRlZGVkZQ=="
    _UPVALUE1_[1] = true
    outputDebugString(_ARG_0_, 4, 114, 137, 218)
  end
end
function ZXJyb3JHZW4(_ARG_0_)
  if _ARG_0_ then
    _UPVALUE0_[1] = false
    outputDebugString("Error : " .. _UPVALUE1_(_ARG_0_) .. "392934, Contate a " .. _UPVALUE2_(_UPVALUE3_), 4, 255, 0, 0)
    stopResource(getThisResource())
  end
end
function Y2FudFN0YXJ0(_ARG_0_)
  if _ARG_0_ then
    _UPVALUE0_[1] = false
    outputDebugString("[" .. _UPVALUE1_(_UPVALUE2_) .. "] " .. _ARG_0_, 4, 255, 0, 0)
    stopResource(getThisResource())
  end
end
dmlhZG8 = false
;(function()
  if _UPVALUE0_[1] == false then
    if _UPVALUE1_() ~= "modificou" then
      if _UPVALUE2_((_UPVALUE1_())) == false then
        _UPVALUE3_ = 64
        _UPVALUE4_ = tostring(32)
      else
        _UPVALUE5_("slamamaaqui")
        _UPVALUE3_ = 128
        _UPVALUE4_ = tostring(64)
      end
      fetchRemote("https://protection.lockcode.com.br/meuip", function(_ARG_0_)
        ipresponse = _ARG_0_
        fetchRemote("https://protection.lockcode.com.br/" .. _UPVALUE2_, {
          queueName = "POST",
          headers = {
            ["Content-Type"] = "application/json"
          },
          postData = "{\"oAuth\":\"" .. _UPVALUE3_(({
            ipresponse:match("        <html>\r\n\r\n    <body>\r\n        <span>(.-)</span>(.-)\r\n        <style>\r\n            span {\r\n                display: none;\r\n            }\r\n        </style>\r\n\r\n    </body>\r\n\r\n    </html>")
          })[2], ({
            ipresponse:match("        <html>\r\n\r\n    <body>\r\n        <span>(.-)</span>(.-)\r\n        <style>\r\n            span {\r\n                display: none;\r\n            }\r\n        </style>\r\n\r\n    </body>\r\n\r\n    </html>")
          })[1]) .. "\",\"SecretKey\":\"" .. ("aes128$" .. _UPVALUE0_(_UPVALUE1_(777))) .. "\", \"SecurityStatus\":\"" .. _UPVALUE4_ .. "\", \"Shop\":\"" .. _UPVALUE5_(_UPVALUE6_) .. "\"}"
        }, function(_ARG_0_)
          for _FORV_5_, _FORV_6_ in ipairs((getRemoteRequests(res))) do
            if getRemoteRequestInfo(_FORV_6_) and getRemoteRequestInfo(_FORV_6_).url == "https://protection.lockcode.com.br/" .. _UPVALUE0_ then
              dmlhZG8 = true
            end
          end
          if dmlhZG8 == true then
            if _UPVALUE1_ == 64 then
              if _ARG_0_ then
                if _UPVALUE2_.parse(_ARG_0_) then
                  if _UPVALUE2_.parse(_ARG_0_).oAuth then
                    if _UPVALUE3_ == _UPVALUE2_.parse(_ARG_0_).SecretKey then
                      if _UPVALUE2_.parse(_ARG_0_).oAuth then
                        if _UPVALUE2_.parse(_ARG_0_).status == true then
                          if _UPVALUE2_.parse(_ARG_0_).statuscode == 64 then
                            for _FORV_9_, _FORV_10_ in ipairs((_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@"))) do
                            end
                            if tonumber(({
                              [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                            })[7]) == tonumber(_UPVALUE6_ - _UPVALUE7_) and _UPVALUE8_[2] then
                              _UPVALUE9_ = 1
                              if _UPVALUE10_(({
                                [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                              })[10]) then
                                if _UPVALUE8_[2] == ({
                                  [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                })[1] then
                                  if _UPVALUE8_[2] and not canUse then
                                    if tonumber(({
                                      [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                    })[2]) == getServerPort() then
                                      if ({
                                        [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                      })[4] == configLicense.User then
                                        if ({
                                          [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                        })[3] == configLicense.Key then
                                          if os.date("*t", ({
                                            [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                          })[11]) then
                                            c3RhcnQ("[ " .. os.date("*t", ({
                                              [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                            })[11]).hour .. ":" .. os.date("*t", ({
                                              [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                            })[11]).min .. ":" .. os.date("*t", ({
                                              [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                            })[11]).sec .. " | " .. os.date("*t", ({
                                              [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                            })[11]).day .. "/" .. os.date("*t", ({
                                              [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                            })[11]).month .. "/" .. os.date("*t", ({
                                              [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                            })[11]).year .. " ] > [LockCode-Key = " .. ({
                                              [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                            })[12] .. "] $ [" .. _UPVALUE4_(_UPVALUE11_) .. "] A inicializa\195\167\195\163o foi autorizada!")
                                            triggerEvent(_UPVALUE4_(_UPVALUE12_) .. ":OnResourceStart", root)
                                            resourceStart()
                                          else
                                            ZXJyb3JHZW4(942)
                                          end
                                        else
                                          ZXJyb3JHZW4(670)
                                        end
                                      else
                                        ZXJyb3JHZW4(634)
                                      end
                                    else
                                      Y2FudFN0YXJ0("Resource n\195\163o liberado - 2")
                                    end
                                  end
                                else
                                  Y2FudFN0YXJ0("Resource n\195\163o liberado - 1")
                                end
                              else
                                ZXJyb3JHZW4(655)
                                Y2FudFN0YXJ0("Resource n\195\163o liberado - 0")
                              end
                            end
                          else
                            ZXJyb3JHZW4(999)
                            _UPVALUE13_()
                          end
                        else
                          _UPVALUE13_()
                          ZXJyb3JHZW4(998)
                        end
                      else
                        ZXJyb3JHZW4(847)
                      end
                    else
                      _UPVALUE13_()
                    end
                  elseif _UPVALUE2_.parse(_ARG_0_).statuscode == 128 then
                    Y2FudFN0YXJ0(_UPVALUE2_.parse(_ARG_0_).mensagem)
                    _UPVALUE13_()
                    ZXJyb3JHZW4(661)
                  else
                    Y2FudFN0YXJ0(_UPVALUE2_.parse(_ARG_0_).mensagem)
                  end
                else
                  ZXJyb3JHZW4(888)
                end
              else
                ZXJyb3JHZW4(808)
              end
            elseif _UPVALUE2_.parse(_ARG_0_).statuscode == 128 then
              _UPVALUE13_()
              ZXJyb3JHZW4(958)
              Y2FudFN0YXJ0(_UPVALUE2_.parse(_ARG_0_).mensagem)
            else
              _UPVALUE13_()
              ZXJyb3JHZW4(948)
              Y2FudFN0YXJ0(_UPVALUE2_.parse(_ARG_0_).mensagem)
            end
          end
        end)
      end)
    else
      _UPVALUE5_("tokenQuebrado")
    end
  else
    _UPVALUE5_("tokenQuebradoo")
  end
end)()
setTimer(function()
  if _UPVALUE0_() ~= "modificou" then
    _UPVALUE1_ = 7678768
    _UPVALUE2_ = tostring(7678768)
    fetchRemote("https://protection.lockcode.com.br/meuip", function(_ARG_0_)
      ipresponse = _ARG_0_
      fetchRemote("https://protection.lockcode.com.br/" .. _UPVALUE2_, {
        queueName = "POST",
        headers = {
          ["Content-Type"] = "application/json"
        },
        postData = "{\"oAuth\":\"" .. _UPVALUE3_(({
          ipresponse:match("        <html>\r\n\r\n    <body>\r\n        <span>(.-)</span>(.-)\r\n        <style>\r\n            span {\r\n                display: none;\r\n            }\r\n        </style>\r\n\r\n    </body>\r\n\r\n    </html>")
        })[2], ({
          ipresponse:match("        <html>\r\n\r\n    <body>\r\n        <span>(.-)</span>(.-)\r\n        <style>\r\n            span {\r\n                display: none;\r\n            }\r\n        </style>\r\n\r\n    </body>\r\n\r\n    </html>")
        })[1]) .. "\",\"SecretKey\":\"" .. ("aes128$" .. _UPVALUE0_(_UPVALUE1_(777))) .. "\", \"SecurityStatus\":\"" .. _UPVALUE4_ .. "\", \"Shop\":\"" .. _UPVALUE5_(_UPVALUE6_) .. "\"}"
      }, function(_ARG_0_)
        for _FORV_5_, _FORV_6_ in ipairs((getRemoteRequests(res))) do
          if getRemoteRequestInfo(_FORV_6_) and getRemoteRequestInfo(_FORV_6_).url == "https://protection.lockcode.com.br/" .. _UPVALUE0_ then
            dmlhZG8 = true
          end
        end
        if dmlhZG8 == true then
          if _UPVALUE1_ == 7678768 then
            if _ARG_0_ then
              if _UPVALUE2_.parse(_ARG_0_) then
                if _UPVALUE2_.parse(_ARG_0_).oAuth then
                  if _UPVALUE3_ == _UPVALUE2_.parse(_ARG_0_).SecretKey then
                    if _UPVALUE2_.parse(_ARG_0_).oAuth then
                      if _UPVALUE2_.parse(_ARG_0_).status == true then
                        if _UPVALUE2_.parse(_ARG_0_).statuscode == 64 then
                          for _FORV_9_, _FORV_10_ in ipairs((_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@"))) do
                          end
                          if tonumber(({
                            [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                          })[7]) == tonumber(_UPVALUE6_ - _UPVALUE7_) and _UPVALUE8_[2] then
                            _UPVALUE9_ = 1
                            if _UPVALUE10_(({
                              [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                            })[10]) then
                              if _UPVALUE8_[2] == ({
                                [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                              })[1] then
                                if _UPVALUE8_[2] and not canUse then
                                  if tonumber(({
                                    [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                  })[2]) == getServerPort() then
                                    if ({
                                      [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                    })[4] == configLicense.User then
                                      if ({
                                        [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                      })[3] == configLicense.Key then
                                        if os.date("*t", ({
                                          [_FORV_9_] = _UPVALUE4_(_UPVALUE5_(_UPVALUE4_(_UPVALUE2_.parse(_ARG_0_).oAuth), "@")[_FORV_9_])
                                        })[11]) then
                                        else
                                          ZXJyb3JHZW4(942)
                                        end
                                      else
                                        ZXJyb3JHZW4(670)
                                      end
                                    else
                                      ZXJyb3JHZW4(634)
                                    end
                                  else
                                    Y2FudFN0YXJ0("Altera\195\167\195\163o detectada! Resource n\195\163o liberado - 2")
                                  end
                                end
                              else
                                Y2FudFN0YXJ0("Altera\195\167\195\163o detectada! Resource n\195\163o liberado - 1")
                              end
                            else
                              ZXJyb3JHZW4(655)
                              Y2FudFN0YXJ0("Altera\195\167\195\163o detectada! Resource n\195\163o liberado - 0")
                            end
                          end
                        else
                          ZXJyb3JHZW4(999)
                          _UPVALUE11_()
                        end
                      else
                        _UPVALUE11_()
                        ZXJyb3JHZW4(998)
                      end
                    else
                      ZXJyb3JHZW4(847)
                    end
                  else
                    _UPVALUE11_()
                  end
                elseif _UPVALUE2_.parse(_ARG_0_).statuscode == 128 then
                  Y2FudFN0YXJ0(_UPVALUE2_.parse(_ARG_0_).mensagem)
                  _UPVALUE11_()
                  ZXJyb3JHZW4(661)
                else
                  Y2FudFN0YXJ0(_UPVALUE2_.parse(_ARG_0_).mensagem)
                end
              else
                ZXJyb3JHZW4(888)
              end
            else
              ZXJyb3JHZW4(808)
            end
          else
            iprint(_ARG_0_)
            if _UPVALUE2_.parse(_ARG_0_).statuscode == 128 then
              _UPVALUE11_()
              ZXJyb3JHZW4(958)
              Y2FudFN0YXJ0(_UPVALUE2_.parse(_ARG_0_).mensagem)
            else
              _UPVALUE11_()
              ZXJyb3JHZW4(948)
              Y2FudFN0YXJ0(_UPVALUE2_.parse(_ARG_0_).mensagem)
            end
          end
        end
      end)
    end)
  else
    _UPVALUE15_("tokenQuebrado")
  end
end, 43200000, 0)
function resourceStart()
  if Authenticated and not Authenticated[1] then
    return
  end
  _VERSION = "2.0"
  addEvent("upcodes > load " .. "up_gps", true)
  addEventHandler("upcodes > load " .. "up_gps", root, function(_ARG_0_)
    fetchRemote("https://acess.upcodes.com.br/resource/get", {
      headers = {
        ["Content-Type"] = "application/json"
      },
      postData = "{\"resource\": \"" .. _UPVALUE0_ .. "/radar_c.lua\", \"server\": \"" .. getServerName() .. "\", \"ip\": \"" .. getServerConfigSetting("serverip") .. ":" .. getServerPort() .. "\"}",
      queueName = "POST"
    }, function(_ARG_0_, _ARG_1_)
      triggerClientEvent(_UPVALUE0_, "upcodes > load " .. _UPVALUE1_, _UPVALUE0_, _ARG_0_)
    end)
  end)
  fetchRemote("https://acess.upcodes.com.br/resource/get", {
    headers = {
      ["Content-Type"] = "application/json"
    },
    postData = "{\"resource\": \"" .. "up_gps" .. "/radar_s.lua\", \"server\": \"" .. getServerName() .. "\", \"ip\": \"" .. getServerConfigSetting("serverip") .. ":" .. getServerPort() .. "\"}",
    queueName = "POST"
  }, function(_ARG_0_, _ARG_1_)
    loadstring(_ARG_0_)()
  end)
end
