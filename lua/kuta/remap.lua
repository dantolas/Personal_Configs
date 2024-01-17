--Set the leader to start commands
vim.g.mapleader = " "
-- Enter netRw (the file tree)
vim.keymap.set("n", "<leader>ko",vim.cmd.Ex)
--CTRL C should function the same as escape, something with vertical save idk theprimeagem said it
vim.keymap.set("n","<C-c>","<Esc>")

--Move highlited lines up and down with capital J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
--Cursor stays at the start when appending line below to current line
vim.keymap.set("n", "J", "mzJ`z")
--Cursor stays centered when half page jumping and searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzz")
vim.keymap.set("n", "N", "Nzzz")

--Paste without overwriting current copied buffer
vim.keymap.set("x","<leader>p","\"_dP")

--Copy to system clipboard
vim.keymap.set("n","<leader>y","\"+y")
vim.keymap.set("v","<leader>y","\"+y")

--Delete to void register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

--No capital Q, it's evil
vim.keymap.set("n","Q","<nop")

--LSP suggestions navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

--Find and replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--Make current file executable (Linux)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
