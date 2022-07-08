local status_ok, fidget = pcall(require, "fidget")
if not status_ok then
  return
end

fidget.setup {
  text = {
    spinner = "moon",
  },
  align = {
    bottom = true,
  },
  window = {
    relative = "editor",
  },
}
