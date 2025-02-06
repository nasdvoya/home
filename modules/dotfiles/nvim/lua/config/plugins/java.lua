return {
  {
    "nvim-java/nvim-java",
    config = function() require("java").setup() end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").jdtls.setup({
        cmd = { "jdtls" },
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-21",
                  path = "/opt/jdk-21",
                  default = true,
                },
              },
            },
          },
        },
      })
    end,
  },
}
