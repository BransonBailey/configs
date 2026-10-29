-- Loaded from lua/config/autocmds.lua.
-- Ask once per language: when a file opens whose LazyVim language pack is off,
-- offer to turn it on.  [y]es -> added to lazyvim.json (restart to install)
--                      [n]ever -> remembered in stdpath("state")/lang-ask.json
--                      [l]ater -> asked again next session
-- Packs already on, or marked "never", are not asked about.

-- filetype -> { pack, label }
local packs = {
  python = { "python", "Python" },
  c = { "clangd", "C/C++" }, cpp = { "clangd", "C/C++" }, objc = { "clangd", "C/C++" },
  objcpp = { "clangd", "C/C++" }, cuda = { "clangd", "C/C++" },
  rust = { "rust", "Rust" },
  javascript = { "typescript", "JavaScript/TypeScript" }, javascriptreact = { "typescript", "JavaScript/TypeScript" },
  typescript = { "typescript", "JavaScript/TypeScript" }, typescriptreact = { "typescript", "JavaScript/TypeScript" },
  go = { "go", "Go" }, gomod = { "go", "Go" }, gowork = { "go", "Go" }, gotmpl = { "go", "Go" },
  java = { "java", "Java" },
  kotlin = { "kotlin", "Kotlin" },
  scala = { "scala", "Scala" }, sbt = { "scala", "Scala" },
  ruby = { "ruby", "Ruby" }, eruby = { "ruby", "Ruby" },
  php = { "php", "PHP" },
  elixir = { "elixir", "Elixir" }, eex = { "elixir", "Elixir" }, heex = { "elixir", "Elixir" },
  erlang = { "erlang", "Erlang" },
  haskell = { "haskell", "Haskell" }, lhaskell = { "haskell", "Haskell" }, cabal = { "haskell", "Haskell" },
  zig = { "zig", "Zig" },
  dart = { "dart", "Dart" },
  julia = { "julia", "Julia" },
  r = { "r", "R" }, rmd = { "r", "R" },
  ocaml = { "ocaml", "OCaml" },
  nix = { "nix", "Nix" },
  terraform = { "terraform", "Terraform" }, hcl = { "terraform", "Terraform" },
  yaml = { "yaml", "YAML" },
  json = { "json", "JSON" }, jsonc = { "json", "JSON" }, json5 = { "json", "JSON" },
  toml = { "toml", "TOML" },
  markdown = { "markdown", "Markdown" },
  tex = { "tex", "LaTeX" }, plaintex = { "tex", "LaTeX" }, bib = { "tex", "LaTeX" },
  sql = { "sql", "SQL" }, mysql = { "sql", "SQL" }, plsql = { "sql", "SQL" },
  dockerfile = { "docker", "Docker" },
  cmake = { "cmake", "CMake" },
  vue = { "vue", "Vue" },
  svelte = { "svelte", "Svelte" },
  astro = { "astro", "Astro" },
  prisma = { "prisma", "Prisma" },
  gleam = { "gleam", "Gleam" },
  elm = { "elm", "Elm" },
  clojure = { "clojure", "Clojure" },
  lean = { "lean", "Lean" },
  nu = { "nushell", "Nushell" },
  typst = { "typst", "Typst" },
  solidity = { "solidity", "Solidity" },
  rego = { "rego", "Rego" },
  thrift = { "thrift", "Thrift" },
  twig = { "twig", "Twig" },
  helm = { "helm", "Helm" },
  ["yaml.ansible"] = { "ansible", "Ansible" },
  htmlangular = { "angular", "Angular" },
  handlebars = { "ember", "Ember" }, glimmer = { "ember", "Ember" },
  cs = { "dotnet", ".NET (C#/F#)" }, fsharp = { "dotnet", ".NET (C#/F#)" },
}

local never_file = vim.fn.stdpath("state") .. "/lang-ask.json"
local asked = {} -- packs already asked about this session

local function read_never()
  local ok, data = pcall(function() return vim.json.decode(table.concat(vim.fn.readfile(never_file), "\n")) end)
  return ok and type(data) == "table" and data or {}
end

local function ask(buf)
  if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].buftype ~= "" then return end
  local entry = packs[vim.bo[buf].filetype]
  if not entry then return end
  local name, label = entry[1], entry[2]
  local module = "lazyvim.plugins.extras.lang." .. name
  if asked[name] or vim.tbl_contains(LazyVim.config.json.data.extras, module) then return end
  local never = read_never()
  if vim.tbl_contains(never, name) then return end
  asked[name] = true

  local choice = vim.fn.confirm(
    ("LazyVim has a %s language pack (lang.%s). Enable it?"):format(label, name),
    "&Yes\n&Never ask\n&Later", 3)
  if choice == 1 then
    table.insert(LazyVim.config.json.data.extras, module)
    table.sort(LazyVim.config.json.data.extras)
    LazyVim.json.save()
    LazyVim.info(("`lang.%s` enabled. Restart Neovim to install it."):format(name), { title = "Language packs" })
  elseif choice == 2 then
    table.insert(never, name)
    vim.fn.mkdir(vim.fn.fnamemodify(never_file, ":h"), "p")
    vim.fn.writefile({ vim.json.encode(never) }, never_file)
    LazyVim.info(("Won't ask about %s again (remove it from %s to undo)."):format(label, never_file),
      { title = "Language packs" })
  end
end

local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("lang_ask", { clear = true }),
    callback = function(ev)
      -- after the screen is drawn, so the question is visible
      vim.defer_fn(function() ask(ev.buf) end, 300)
    end,
  })
  -- the file Neovim was opened with got its FileType before this ran
  vim.defer_fn(function() ask(vim.api.nvim_get_current_buf()) end, 300)
end

return M
