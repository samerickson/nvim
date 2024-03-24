return {
	'shortcuts/no-neck-pain.nvim',
	event = 'VeryLazy',
	opts = {
		buffers = {
			right = {
				enabled = false
			},
			scratchPad = {
				enabled = true,
				location = '~/Documents'
			},
			bo = {
				filetype = 'md'
			}
		}
	}
}
