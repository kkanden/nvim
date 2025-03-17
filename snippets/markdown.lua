local fig = s("fig", {
    t({ "<figure>", '  <img src="' }),
    i(1, ""),
    t({ '" width="' }),
    i(2, ""),
    t({ '" height="' }),
    i(3, ""),
    t({ '">', "  <figcaption>" }),
    i(4, ""),
    t({ "</figcaption>", "</figure>" }),
})

return { fig }
