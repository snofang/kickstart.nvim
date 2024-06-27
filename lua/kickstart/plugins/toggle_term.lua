return {
  'akinsho/toggleterm.nvim',
  version = '*',
  cmd = { 'ToggleTerm', 'TermExec' },
  setup = true,
  opts = {
    size = 10,
    -- open_mapping = [[<leader>tt]],
    shading_factor = 2,
    direction = 'float',
    float_opts = {
      border = 'curved',
      highlights = { border = 'Normal', background = 'Normal' },
    },
  },
}
