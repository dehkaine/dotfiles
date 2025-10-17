-- Replace Functions (BOL-only, simple & robust)

local first_element_map =  {
	checkbox_on  = "- [x] ",
	checkbox_off = "- [ ] ",
	heading1     = "# ",
	heading2     = "## ",
	heading3     = "### ",
	heading4     = "#### ",
	heading5     = "##### ",
	heading6     = "###### ",
	bullet       = "- ",
	number1      = "1. ",
	quote        = "> ",
}

local function strip_first(rest)
	local patterns = {
		"^%s*%-%s*%[[xX]%]%s*",   -- - [x] / - [X]
		"^%s*%-%s*%[%s%]%s*",     -- - [ ]
		"^%s*#+%s+",               -- headings: # / ## / ### ... + space
		"^%s*%-%s+",               -- bullet: -
		"^%s*%d+%.%s+",            -- number: 1.
	}
	for _, p in ipairs(patterns) do
		local new, n = rest:gsub(p, "")
		if n > 0 then
			return new
		end
	end
	return rest
end

local function replace_first_element(target_element)
	local target = first_element_map[target_element]
	if not target then return end

	local row  = vim.api.nvim_win_get_cursor(0)[1]
	local line = vim.api.nvim_get_current_line()
	local indent = line:match("^%s*") or ""
	local rest   = line:sub(#indent + 1)

	rest = strip_first(rest)
	local newline = indent .. target .. rest
	vim.api.nvim_buf_set_lines(0, row - 1, row, false, { newline })
end

local function set_element(cmd, key, desc)
	local fixed_cmd = "<localleader>"..cmd
	vim.keymap.set("n", fixed_cmd,
		function()replace_first_element(key)end,
		{ buffer = true, desc = desc or ("md:first->"..key)}
	)
end

set_element("h1", "heading1",     "Set first element to Heading1")
set_element("h2", "heading2",     "Set first element to Heading2")
set_element("h3", "heading3",     "Set first element to Heading3")
set_element("h4", "heading4",     "Set first element to Heading4")
set_element("h5", "heading5",     "Set first element to Heading5")
set_element("h6", "heading6",     "Set first element to Heading6")
set_element("ul", "bullet",       "Set first element to Bullet")
set_element("ol", "number1",      "Set first element to OrderedList1")
set_element("qo", "quote",        "Set first element to Quote")
set_element("t",  "checkbox_on",  "Set first element to AddTask")
set_element("at", "checkbox_off", "Set first element to FinishTask")
