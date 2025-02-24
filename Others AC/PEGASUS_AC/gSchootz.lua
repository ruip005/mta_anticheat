config = {
    ['modules'] = {
        ['AntiVPN'] = {
            ['state'] = true,
            ['keyAPI'] = 'dae700584980178404cfc2468edae0ba',
            ['commandWhitelist'] = 'addwhitelist',

            ['webhook'] = 'https://media.guilded.gg/webhooks/9a433440-a803-4f6e-82f9-c2028be66458/TMay4LDR0OSwSG0eeii08IuCUAsweaCuWWmCCuuYooaWAkgQQIyUgUWEASmkySi6CyeEUIe2OWYScqgIakG0qo',
        },

        ['PrintSuspect'] = {
            ['state'] = false,
            ['action'] = 'ban',
            ['command'] = 'print',

            ['items'] = {
                ['insert'] = true,
                ['F12'] = true,
                ['F10'] = true,
                ['esc'] = true,
                ['home'] = true,
                ['delete'] = true,
                ['pause'] = true,
                ['='] = true,
            },

            ['webhook'] = 'https://media.guilded.gg/webhooks/9a433440-a803-4f6e-82f9-c2028be66458/TMay4LDR0OSwSG0eeii08IuCUAsweaCuWWmCCuuYooaWAkgQQIyUgUWEASmkySi6CyeEUIe2OWYScqgIakG0qo',
        },

        ['Anti-Weapon'] = {
            ['state'] = true,
            ['action'] = 'ban',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['items'] = {
                [35] = true,
                [33] = true, 
                [36] = true, 
                [37] = true, 
                [38] = true, 
                [16] = true, 
                [18] = true, 
                [39] = true, 
                [40] = true,
            },

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },

        ['Anti-Stop'] = {
            ['state'] = true,
            ['action'] = 'ban',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },

        ['Anti-WeaponFire'] = {
            ['state'] = true,
            ['action'] = 'ban',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        };
        
        ['Anti-VBR'] = {
            ['state'] = false,
            ['action'] = 'kick',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },

        ['Anti-Invisible'] = {
            ['state'] = true,
            ['action'] = 'ban',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-Jetpack'] = {
            ['state'] = true,
            ['action'] = 'ban',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff", "Patrocinador"};
                ["element.data"] = {"onProt"};
            };

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-Fly'] = {
            ['state'] = true,
            ['action'] = 'warning',

            ["bypass"] = {
                ["acls"] = {"Console", 'Staff'};
                ["element.data"] = {"onProt", "Grudado", "SQUADY.carregado"};
            };
            
            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-Explosions'] = {
            ['state'] = true,
            ['action'] = 'ban',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['items'] = {
                [0] = true,
                [1] = true, 
                [2] = false, 
                [3] = true, 
                [4] = false, 
                [5] = true, 
                [6] = true, 
                [7] = true, 
                [8] = true, 
                [9] = false, 
                [10] = true, 
                [11] = true,
            },

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-Projectile'] = {
            ['state'] = true,
            ['action'] = 'ban',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-FastFire'] = {
            ['state'] = true,
            ['action'] = 'kick',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-Vehicle'] = {
            ['state'] = true,
            ['action'] = 'ban',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['items'] = {
                [425] = true,
                [520] = true, 
                [432] = true, 
                [590] = true, 
                [538] = true, 
                [570] = true, 
                [569] = true, 
                [537] = true, 
                [449] = true, 
                [464] = true,

            },

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-Speed'] = {
            ['state'] = true,
            ['action'] = 'ban',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-Executor'] = {
            ['state'] = true,
            ['action'] = 'ban',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-TriggerExists'] = {
            ['state'] = true,
            ['action'] = 'ban',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-ChangeData'] = {
            ['state'] = true,
            ['action'] = 'ban',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['items'] = {
                ['ID'] = true,
                ["Exp"] = true,
                ["Level"] = true,
                ["Emprego"] = true,
                ["onProt"] = true,
                ["guetto.points"] = true,
                ['battle.level'] = true,
            },

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-CarFucker'] = {
            ['state'] = true,
            ['action'] = 'warning',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };
            
            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-Block'] = {
            ['state'] = true,
            ['action'] = 'ban',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-Gui'] = {
            ['state'] = false,
            ['action'] = 'ban',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-Trigger'] = {
            ['state'] = true,
            ['action'] = 'ban',

            ["bypass"] = {
                ["acls"] = {"Console", "Staff"};
                ["element.data"] = {"onProt"};
            };

            ['Triggers'] = {
                ['PEGASUS_AC'] = {
                    ['Pegasus.DetectSpoofer'] = true,
                    ['Pegasus.detectCheaters'] = true,
                    ['Pegasus.ReceiverPrintFromClient'] = true,
                    ['Pegasus.onPlayerSendServerCod'] = true,
                    ['onPlayerGetInfos'] = true,
                },
            };

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-FakeWeapon'] = {
            ['state'] = true,
            ['action'] = 'warning',

            ["bypass"] = {
                ["acls"] = {};
                ["element.data"] = {};
            };

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
        ['Anti-Spoofer'] = {
            ['state'] = true,

            ['webhook'] = 'https://canary.discord.com/api/webhooks/1316875780952948807/JDfuE3laITvguqgPFqqOCryJWXGAeK-B2IoAsF2Ou6Fi5im7bbIW2eCLCIyVP5b5mAz_',
        },
    },
}

notifyC = function(message, type)
    return exports['QBD_notify']:showInfobox(type, message)
end

notifyS = function(player, message, type)
    return exports['QBD_notify']:showInfobox(player, type, message)
end