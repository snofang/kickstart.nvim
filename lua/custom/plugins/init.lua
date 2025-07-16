return {
  {
    'David-Kunz/gen.nvim',
    opts = {
      model = 'tinyllama',
      display_mode = 'vertical-split',
      show_prompt = false,
      show_model = false,
      no_auto_close = false,
      init = function(options)
        pcall(io.popen, 'ollama serve > /dev/null 2>&1 &')
      end,
      command = "ollama run $model '$prompt'",
    },
  },
  -- Add keymap for safely closing buffers
  {
    'nvim-lua/plenary.nvim', -- A common utility plugin
    lazy = true,
    config = function()
      local function close_buffer_safely()
        local current_buf = vim.api.nvim_get_current_buf()
        local listed_buffers = vim.tbl_filter(function(b)
          return vim.fn.buflisted(b) == 1 and vim.api.nvim_buf_get_name(b) ~= ''
        end, vim.api.nvim_list_bufs())

        if #listed_buffers <= 1 then
          -- This is the last real buffer.
          -- Create a new empty buffer to prevent Neovim from closing.
          vim.cmd.enew()
          -- Now delete the original buffer if it still exists and is listed.
          if vim.fn.bufexists(current_buf) == 1 and vim.fn.buflisted(current_buf) == 1 then
            vim.cmd('bdelete! ' .. current_buf)
          end
        else
          -- There are other buffers.
          -- Get the buffer number to delete *before* switching.
          local buf_to_delete = current_buf
          -- Switch to the next buffer first. This prevents the window from closing.
          vim.cmd.bnext()
          -- Now, safely delete the original buffer in the background.
          if vim.fn.bufexists(buf_to_delete) == 1 and vim.fn.buflisted(buf_to_delete) == 1 then
            vim.cmd('bdelete! ' .. buf_to_delete)
          end
        end
      end

      vim.keymap.set('n', '<leader>c', close_buffer_safely, { desc = 'Close Buffer Safely' })
    end,
  },
}