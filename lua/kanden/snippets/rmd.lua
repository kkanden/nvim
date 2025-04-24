local graphic = s("graphic", {
    t({ '```{r, fig.cap="' }),
    i(1, ""),
    t({ '", out.width="' }),
    i(2, ""),
    t({ '", out.height="' }),
    i(3, ""),
    t({ '"}', 'knitr::include_graphics("' }),
    i(4, ""),
    t({ '")', "```" }),
})

return { graphic }
