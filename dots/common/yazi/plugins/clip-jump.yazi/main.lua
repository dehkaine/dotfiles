-- ~/.config/yazi/plugins/clipjump.yazi/main.lua
---@async entry
return {
  entry = function()
    local clip = (ya.clipboard() or ""):gsub("%s+$", "")
    if clip == "" then
      return ya.notify{title="ClipJump", content="Clipboard is Nil", level="warn"}
    end
		-- if not clip:match("/$") then
    --   clip = clip:match("(.+)/[^/]+$") or clip
    -- end
		local base = clip:match("([^/]+)$") or ""
    if base:find("%.") and not base:match("^%.+$") then
      clip = clip:match("(.+)/[^/]+$") or clip
    end
    ya.emit("cd", { Url(clip) })
  end,
}
