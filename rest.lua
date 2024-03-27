-- plugins/rest.lua
return {
  "rest-nvim/rest.nvim",
  dependencies = { { "nvim-lua/plenary.nvim" } },
  commit = "8b62563",
  config = function()
    require("rest-nvim").setup({
      --- Get the same options from Packer setup
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = true,
      result_split_in_place = true,
      result = {
        formatters = {
          json = "jq",
          html = function(body)
            return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
          end,
        },
      },
      keys = {
        { "<leader>rr", "<cmd><Plug>RestNvim<cr>", desc = "Run rest request under cursor" },
      },
    })
  end,
}
