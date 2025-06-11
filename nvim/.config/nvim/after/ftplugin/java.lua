local os = os.getenv("OS")

vim.opt_local.shiftwidth = 2 -- match google-java-fromat

local jdtls_path

if os == "Linux" then
  jdtls_path = "/bin/jdtls"
elseif os == "Darwin" then
  jdtls_path = "/opt/homebrew/bin/jdtls"
end

local config = {
  cmd = { jdtls_path },
  root_dir = vim.fs.dirname(
    vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]
  ),
  settings = {
    java = {
      configuration = {
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- And search for `interface RuntimeOption`
        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
        -- runtimes = {
        --   {
        --     name = "JavaSE-11",
        --     path = "/usr/lib/jvm/java-11-openjdk/",
        --   },
        --   {
        --     name = "JavaSE-20",
        --     path = "/usr/lib/jvm/java-20-openjdk/",
        --   },
        -- },
      },
    },
  },
}
require("jdtls").start_or_attach(config)
