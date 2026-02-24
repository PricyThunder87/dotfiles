return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
        sections = {
            lualine_x = {
                {
                    function()
                        return require("noice").api.status.command.get()
                    end,
                    cond = function()
                        return package.loaded["noice"] and require("noice").api.status.command.has()
                    end,
                },
            },
        },
    },
}
