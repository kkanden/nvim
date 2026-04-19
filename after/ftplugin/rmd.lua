vim.bo.shiftwidth = 2
vim.wo.foldexpr = "v:lua.RFoldComment(v:lnum)"
vim.wo.foldmethod = "expr"

function RFoldComment(lnum)
    local line = vim.fn.getline(lnum)
    if string.match(line, "^```{?%w+") then
        return ">1"
    elseif string.match(line, "^```") then
        return "<1"
    elseif string.match(line, "^#%s*.*%s*-+%s*#*$") then
        return ">2"
    end
    return "="
end
