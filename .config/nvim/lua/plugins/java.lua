return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      settings = {
        java = {
          autobuild = { enabled = false },
          import = {
            gradle = { enabled = false },
            maven = { enabled = false },
          },
          configuration = {
            runtimes = {
              {
                name = "JavaSE-21",
                path = "/Library/Java/JavaVirtualMachines/amazon-corretto-21.jdk/Contents/Home",
                default = true,
              },
            },
          },
        },
      },
    },
  },
}
