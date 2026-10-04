-- HTML server (system: vscode-langservers-extracted)
return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  root_markers = { "package.json", ".git" },
  init_options = {
    provideFormatter = true,
    -- CSS & JS di dalam <style>/<script> ikut dianalisa
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
}
