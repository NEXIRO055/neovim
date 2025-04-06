-- init.lua
vim.g.mapleader = " "

-- lazy.nvim 부트스트랩: 설치되어 있지 않으면 자동으로 클론합니다.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 최신 안정 버전
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 플러그인 설정
require("lazy").setup({
  -- Telescope: 강력한 파일 및 텍스트 검색 기능 제공
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup{}
    end
  },

  -- Gruvbox: 인기 있는 색상 테마
  {
    "morhetz/gruvbox",
    config = function()
      vim.cmd("colorscheme gruvbox")
    end
  },

  -- Coc.nvim: 강력한 언어 서버 프로토콜(LSP) 지원 플러그인
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      -- 기본 Coc 설정 예제 (필요에 따라 추가 설정)
      vim.cmd([[
        " <Tab> 키로 자동완성 메뉴 내 항목 선택
        inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
      ]])
    end
  },

  -- Neo-tree: 파일 탐색기 플러그인
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- 파일 아이콘을 위한 선택적 플러그인
      "MunifTanjim/nui.nvim"
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          hijack_netrw_behavior = "open_default", -- netrw 대신 neo-tree 사용
        }
      })
    end
  }
})

-- 키 매핑 설정
-- Telescope: 파일 및 텍스트 검색
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '파일 찾기' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '텍스트 검색' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '버퍼 목록' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '도움말 태그 검색' })

-- Neo-tree: 파일 탐색기 토글
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Neo-tree 토글' })

-- Coc.nvim: 코드 탐색 및 작업
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { desc = '정의로 이동' })
vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { desc = '참조 검색' })
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', { desc = '구현으로 이동' })
vim.keymap.set('n', 'K', ':call CocActionAsync("doHover")<CR>', { desc = '호버 정보 표시' })
-- 창 이동을 위한 키 매핑 (Ctrl + h/j/k/l)
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = '왼쪽 창 이동' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = '아래 창 이동' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = '위 창 이동' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = '오른쪽 창 이동' })

--c 커파일
-- C 파일 컴파일 및 실행 매핑 (한글과 영어 인코딩 지원, Active code page 출력 제거)
vim.keymap.set("n", "<F5>", ":w<CR>:!gcc -finput-charset=UTF-8 -fexec-charset=UTF-8 % -o %:r.exe && start cmd /c \"chcp 65001 >nul && %:r.exe & echo. & echo 종료하려면 아무키나 누르십시오.. & pause >nul\"<CR>", { noremap = true, silent = false })


