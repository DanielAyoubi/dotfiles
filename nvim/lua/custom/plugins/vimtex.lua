return {
    'lervag/vimtex',
    config = function()
        vim.g.tex_flavor = "latex"
        vim.g.vimtex_quickfix_ignore_filters = {'Underfull', 'Overfull'}
        vim.g.vimtex_view_method = "zathura"
        vim.g.Tex_IgnoreLevel = 8
    end
} -- vimtex, see below as well
