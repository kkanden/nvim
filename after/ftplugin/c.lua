local function runmain()
    local prog
    if vim.fn.executable("./main") == 1 then
        prog = "./main"
    elseif vim.fn.executable("./build/main") == 1 then
        prog = "./build/main"
    end
    if prog then vim.cmd("!" .. prog) end
end

vim.keymap.set("n", "ml", runmain, { desc = "Run main program" })
