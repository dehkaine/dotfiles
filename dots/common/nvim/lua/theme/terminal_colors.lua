-- terminal 16 palette for :terminal buffer
local t = {
  [0]  = "#000000",
  [1]  = "#FF5555",
  [2]  = "#50FA7B",
  [3]  = "#F1FA8C",
  [4]  = "#BD93F9",
  [5]  = "#FF79C6",
  [6]  = "#8BE9FD",
  [7]  = "#BFBFBF",
  [8]  = "#4D4D4D",
  [9]  = "#FF6E67",
  [10] = "#5AF78E",
  [11] = "#F4F99D",
  [12] = "#CAA9FA",
  [13] = "#FF92D0",
  [14] = "#9AEDFE",
  [15] = "#E6E6E6",
}

for i, hex in pairs(t) do
  vim.g["terminal_color_" .. i] = hex
end
