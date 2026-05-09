local jdk25 = vim.fn.expand("~/.local/share/mise/installs/java/temurin-25")
local jdk17 = vim.fn.expand("~/.local/share/mise/installs/java/temurin-17")

-- jdtls itself requires a recent JDK to run. Force it onto 25 regardless of
-- the shell's active mise version, so opening a Java 17 project doesn't break
-- the LSP. This leaks to other nvim subprocesses (e.g. `:!mvn`) — run build
-- tools from a terminal where mise picks the project's JDK.
vim.env.JAVA_HOME = jdk25

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
              { name = "JavaSE-17", path = jdk17, default = true },
              { name = "JavaSE-25", path = jdk25 },
            },
          },
        },
      },
    },
  },
}
