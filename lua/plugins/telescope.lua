local function find_git_root()
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir
    local cwd = vim.fn.getcwd()
    if current_dir == "" then
        current_dir = cwd
    else
        current_dir = vim.fn.fnamemodify(current_file, ":h")
    end
    local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
    if vim.v.shell_error ~= 0 then
        print("Not a git repository. Searching on current working directory")
        return cwd
    end
    return git_root
end
local function live_grep_git_root()
    local git_root = find_git_root()
    if git_root then
        require('telescope.builtin').live_grep({search_dirs = {git_root}})
    end
end
vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})
return{
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        }
    },
    config = function()
        require('telescope').setup {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            }
        }
        require('telescope').load_extension('fzf')
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff',builtin.find_files,{ desc = '[ff] Search Files'})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[fg] Search by Grep'})
        vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers'})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[fh] Search for Help'})
        vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files'})
        vim.keymap.set('n', '<leader>/', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {windlend = 10, previewer = false,})
        end, {desc = '[/] Fuzzily search in current buffer'})
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[fd] Search Diagnostics'})
        vim.keymap.set('n', '<leader>sg', ':LiveGrepGitRoot<cr>', { desc = '[sg] Search by Grep on git root'})
    end,
}
