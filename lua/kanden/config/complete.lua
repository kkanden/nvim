local map = require("kanden.lib").map
local augroup = require("kanden.lib").augroup

vim.o.complete = "F,o"
vim.o.completeitemalign = "kind,abbr,menu"
vim.o.completeopt = "noinsert,popup,menuone,fuzzy"
vim.o.autocomplete = true

-- <CR> accepts the completion for some reason, i don't want that
map({ "i" }, "<CR>", "pumvisible() ? '<C-e><CR>' : '<CR>'", { expr = true })

map({ "i", "c" }, "<C-b>", "pumvisible() ? '<C-y>' : '<C-b>'", { expr = true })

vim.o.wildmode = "noselect:full"
vim.o.wildoptions = "fuzzy"
vim.cmd("autocmd CmdlineChanged [:/?] call wildtrigger()")

vim.o.pumborder = "single"
vim.o.pumheight = 10
vim.o.pumwidth = 15
vim.o.pummaxwidth = 50

kind_map = {}
for k, v in pairs(vim.lsp.protocol.CompletionItemKind) do
    if type(k) == "string" and type(v) == "number" then kind_map[v] = k end
end

kind_icons = {
    Class = "󱡠",
    Color = "󰏘",
    Constant = "󰏿",
    Constructor = "󰒓",
    Enum = "󰦨",
    EnumMember = "󰦨",
    Event = "󱐋",
    Field = "󰜢",
    File = "󰈔",
    Folder = "󰉋",
    Function = "󰊕",
    Interface = "󱡠",
    Keyword = "󰻾",
    Method = "󰊕",
    Module = "󰅩",
    Operator = "󰪚",
    Property = "󰖷",
    Reference = "󰬲",
    Snippet = "󱄽",
    Struct = "󱡠",
    Text = "󰉿",
    TypeParameter = "󰬛",
    Unit = "󰪚",
    Value = "󰦨",
    Variable = "󰆦",
}

vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lsp_complete"),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, args.buf, {
                autotrigger = true,
                convert = function(item)
                    local kind = kind_map[item.kind]
                    local icon = kind_icons[kind]
                    local _, hl, _ =
                        require("mini.icons").get("lsp", kind or "Unknown")
                    return {
                        kind = icon,
                        kind_hlgroup = hl,
                        abbr = item.label,
                        menu = item.documentation,
                    }
                end,
            })
        end
    end,
})
