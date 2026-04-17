local name = s("name", {
    t({ 'if __name__ == "__main__":', "\t" }),
    i(1, "pass"),
})

return { name }
