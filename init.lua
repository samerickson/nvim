
require 'options'
require 'keymaps'
require 'autocmds'

if not require('samerickson.utils').is_windows then
    require('vim._core.ui2').enable {}
end

