return {
    [10300] = {
        --月卡
        ["Type"] = "MonthlyCard",
        ["Description"] = T(LSTR("RECHARGE.120_DAILY_DIAMONDS_CAN_BE_OBTAINED_30_DAYS_IN_A_ROW"), '120'),
        ["Mutiple"] = 0,
        ["Order"] = 1,
        ["Get Diamond"] = 300,
        ["Replace ID"] = 0,
        ["Icon"] = "UI/alpha/HVGA/recharge_monthlycard_1.png",
        ["Display Name"] = T(LSTR("RECHARGE.MONTHLY_GIFT_PACKAGE_OF_300_DIAMONDS"), '120'),
        ["Limit"] = 0,
        ["Recommended"] = true,
        ["ID"] = 10300,
        ["VIP Exp"] = 300,
        ["Days"] = 30,
        ["Hero"] = 0,
        ["Cost"] = 4.99
    },

    --这里以后补充节日礼包部分 600以后

    --下面是常规礼包部分
    [10500] = {
        --礼包1
        ["Type"] = "Instant",
        ["Description"] = T(LSTR("RECHARGE.BONUS_GEMS"), '150'),
        ["Mutiple"] = 0,
        ["Order"] = 11,
        ["Get Diamond"] = 300,
        ["Replace ID"] = 0,
        ["Icon"] = "UI/alpha/HVGA/recharge_diamond_icon_6.png",
        ["Display Name"] = T(LSTR("RECHARGE.GEMS"), '150'),
        ["Limit"] = 1,
        ["Recommended"] = true,
        ["ID"] = 10500,
        ["VIP Exp"] = 150,
        ["Days"] = 0,
        ["Hero"] = 0, --
        ["Cost"] = 4.99
    },
    [10510] = {
        --礼包2
        ["Type"] = "Instant",
        ["Description"] = T(LSTR("RECHARGE.BONUS_GEMS"), '380'),
        ["Mutiple"] = 0,
        ["Order"] = 11,
        ["Get Diamond"] = 680,
        ["Replace ID"] = 10500,
        ["Icon"] = "UI/alpha/HVGA/recharge_diamond_icon_6.png",
        ["Display Name"] = T(LSTR("RECHARGE.GEMS"), '300'),
        ["Limit"] = 1,
        ["Recommended"] = true,
        ["ID"] = 10510,
        ["VIP Exp"] = 300,
        ["Days"] = 0,
        ["Hero"] = 0, --
        ["Cost"] = 9.99
    },
    [10501] = {
        --礼包3
        ["Type"] = "Instant",
        ["Description"] = T(LSTR("RECHARGE.BONUS_GEMS"), '900'),
        ["Mutiple"] = 0,
        ["Order"] = 11,
        ["Get Diamond"] = 1500,
        ["Replace ID"] = 10510,
        ["Icon"] = "UI/alpha/HVGA/recharge_diamond_icon_6.png",
        ["Display Name"] = T(LSTR("RECHARGE.GEMS"), '600'),
        ["Limit"] = 1,
        ["Recommended"] = true,
        ["ID"] = 10501,
        ["VIP Exp"] = 600,
        ["Days"] = 0,
        ["Hero"] = 0, --送全能骑士
        ["Cost"] = 19.99
    },
    [10502] = {
        --礼包4
        ["Type"] = "Instant",
        ["Description"] = T(LSTR("RECHARGE.BONUS_GEMS"), '2,500'),
        ["Mutiple"] = 0,
        ["Order"] = 12,
        ["Get Diamond"] = 4000,
        ["Replace ID"] = 10501,
        ["Icon"] = "UI/alpha/HVGA/recharge_diamond_icon_6.png",
        ["Display Name"] = T(LSTR("RECHARGE.GEMS"), '1,500'),
        ["Limit"] = 1,
        ["Recommended"] = true,
        ["ID"] = 10502,
        ["VIP Exp"] = 1500,
        ["Days"] = 0,
        ["Hero"] = 0, --送冰女
        ["Cost"] = 49.99
    },
    [10503] = {
        --礼包5
        ["Type"] = "Instant",
        ["Description"] = T(LSTR("RECHARGE.BONUS_GEMS"), '6,000'),
        ["Mutiple"] = 0,
        ["Order"] = 13,
        ["Get Diamond"] = 9000,
        ["Replace ID"] = 10502,
        ["Icon"] = "UI/alpha/HVGA/recharge_diamond_icon_6.png",
        ["Display Name"] = T(LSTR("RECHARGE.GEMS"), '3,000'),
        ["Limit"] = 1,
        ["Recommended"] = true,
        ["ID"] = 10503,
        ["VIP Exp"] = 3000,
        ["Days"] = 0,
        ["Hero"] = 0, --送白虎
        ["Cost"] = 99.99
    },


    --下面是基础物品部分

    [10400] = {
        --基础1
        ["Type"] = "Instant",
        ["Description"] = T(LSTR("RECHARGE.BONUS_GEMS"), '30'),
        ["Mutiple"] = 0,
        ["Order"] = 23,
        ["Get Diamond"] = 280,
        ["Replace ID"] = 0,
        ["Icon"] = "UI/alpha/HVGA/recharge_diamond_icon_5.png",
        ["Display Name"] = T(LSTR("RECHARGE.GEMS"), '250'),
        ["Limit"] = 0,
        ["Recommended"] = false,
        ["ID"] = 10400,
        ["VIP Exp"] = 250,
        ["Days"] = 0,
        ["Hero"] = 0,
        ["Cost"] = 4.99
    },
   [10401] = {
        --基础1
        ["Type"] = "Instant",
        ["Description"] = T(LSTR("RECHARGE.BONUS_GEMS"), '6'),
        ["Mutiple"] = 0,
        ["Order"] = 24,
        ["Get Diamond"] = 56,
        ["Replace ID"] = 0,
        ["Icon"] = "UI/alpha/HVGA/recharge_diamond_icon_5.png",
        ["Display Name"] = T(LSTR("RECHARGE.GEMS"), '50'),
        ["Limit"] = 0,
        ["Recommended"] = false,
        ["ID"] = 10401,
        ["VIP Exp"] = 50,
        ["Days"] = 0,
        ["Hero"] = 0,
        ["Cost"] = 0.99
    },
    [10410] = {
        --基础2
        ["Type"] = "Instant",
        ["Description"] = T(LSTR("RECHARGE.BONUS_GEMS"), '80'),
        ["Mutiple"] = 0,
        ["Order"] = 22,
        ["Get Diamond"] = 580,
        ["Replace ID"] = 0,
        ["Icon"] = "UI/alpha/HVGA/recharge_diamond_icon_5.png",
        ["Display Name"] = T(LSTR("RECHARGE.GEMS"), '500'),
        ["Limit"] = 0,
        ["Recommended"] = false,
        ["ID"] = 10410,
        ["VIP Exp"] = 500,
        ["Days"] = 0,
        ["Hero"] = 0,
        ["Cost"] = 9.99
    },
    [10402] = {
        --基础3
        ["Type"] = "Instant",
        ["Description"] = T(LSTR("RECHARGE.BONUS_GEMS"), '180'),
        ["Mutiple"] = 0,
        ["Order"] = 22,
        ["Get Diamond"] = 1180,
        ["Replace ID"] = 0,
        ["Icon"] = "UI/alpha/HVGA/recharge_diamond_icon_5.png",
        ["Display Name"] = T(LSTR("RECHARGE.GEMS"), '1,000'),
        ["Limit"] = 0,
        ["Recommended"] = false,
        ["ID"] = 10402,
        ["VIP Exp"] = 1000,
        ["Days"] = 0,
        ["Hero"] = 0,
        ["Cost"] = 19.99
    },
    [10403] = {
        --基础4
        ["Type"] = "Instant",
        ["Description"] = T(LSTR("RECHARGE.BONUS_GEMS"), '830'),
        ["Mutiple"] = 0,
        ["Order"] = 21,
        ["Get Diamond"] = 3330,
        ["Replace ID"] = 0,
        ["Icon"] = "UI/alpha/HVGA/recharge_diamond_icon_5.png",
        ["Display Name"] = T(LSTR("RECHARGE.GEMS"), '2,500'),
        ["Limit"] = 0,
        ["Recommended"] = false,
        ["ID"] = 10403,
        ["VIP Exp"] = 2500,
        ["Days"] = 0,
        ["Hero"] = 0,
        ["Cost"] = 49.99
    },
    [10404] = {
        --基础5
        ["Type"] = "Instant",
        ["Description"] = T(LSTR("RECHARGE.BONUS_GEMS"), '1,250'),
        ["Mutiple"] = 0,
        ["Order"] = 20,
        ["Get Diamond"] = 6250,
        ["Replace ID"] = 0,
        ["Icon"] = "UI/alpha/HVGA/recharge_diamond_icon_5.png",
        ["Display Name"] = T(LSTR("RECHARGE.GEMS"), '5,000'),
        ["Limit"] = 0,
        ["Recommended"] = false,
        ["ID"] = 10404,
        ["VIP Exp"] = 5000,
        ["Days"] = 0,
        ["Hero"] = 0,
        ["Cost"] = 99.99
    },
}
