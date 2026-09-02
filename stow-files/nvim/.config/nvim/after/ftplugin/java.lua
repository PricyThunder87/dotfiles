local jdtls = require "jdtls"

local root_dir = jdtls.setup.find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
if not root_dir then
  return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath "data" .. "/site/java-workspace/" .. project_name

local mason_registry = require "mason-registry"
local jdtls_pkg = mason_registry.get_package "jdtls"
local jdtls_path = jdtls_pkg:get_install_path()

local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_dir = jdtls_path .. "/config_linux"

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    launcher_jar,
    "-configuration",
    config_dir,
    "-data",
    workspace_dir,
  },
  root_dir = root_dir,
  init_options = {
    extendedClientCapablities = jdtls.extendedClientCapablities,
  },
}

jdtls.start_or_attach(config)

-- Silence notification spam
local mini_notify = require "mini.notify"
mini_notify.setup {
  content = {
    sort = function(notif_arr)
      local filtered = vim.tbl_filter(function(notif)
        local is_lsp = notif.data and string.find(notif.msg, "jdtls") ~= nil
        return is_lsp == false
      end, notif_arr)

      return mini_notify.default_sort(filtered)
    end,
  },
}
