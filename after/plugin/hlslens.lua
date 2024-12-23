require("hlslens").setup({
    -- show virtual text only on current line
    override_lens = function(render, posList, nearest, idx, relIdx)
        local absRelIdx = math.abs(relIdx)
        if absRelIdx > 1 then
            return
        end
        local text, chunks

        local lnum, col = unpack(posList[idx])
        local cnt = #posList
        text = ('[%d/%d]'):format(idx, cnt)
        if absRelIdx == 1 then
            chunks = { { ' ' }, { text, '' } }
        else
            chunks = { { ' ' }, { text, 'HlSearchLensNear' } }
        end
        render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
    end
})
