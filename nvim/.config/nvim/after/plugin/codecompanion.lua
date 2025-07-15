require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = {
        name = "copilot",
        model = "claude-sonnet-4",
      },
    },
  },
})

