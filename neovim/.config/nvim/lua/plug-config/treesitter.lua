require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "bash",
        "css",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "php"
    },
    highlight = {
        enable = true,
        use_languagetree = true
    }
}
