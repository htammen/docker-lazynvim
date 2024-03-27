-- change timeout from 5000 to 10000
return {
  "nvim-notify",
  -- opts will be merged with the parent spec
  opts = { timeout = 10000 },
}
