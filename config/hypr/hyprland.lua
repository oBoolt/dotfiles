local dotfiles_path = os.getenv("DOTFILES_PATH")
if dotfiles_path then
    package.path = dotfiles_path .. "/?.lua;" .. package.path
end

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

require("modules")
require("rules")


do
    local file = io.open(dotfiles_path .. "/local/hypr.lua", "r")
    if file then
        file:close()
        require("local.hypr")
    end
end
