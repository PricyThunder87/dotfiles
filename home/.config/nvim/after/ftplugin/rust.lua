local npairs = require("nvim-autopairs")

-- Remove single quote pairing for Rust buffers only
npairs.remove_rule("'")
