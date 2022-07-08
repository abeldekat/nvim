--[[
TODO: Null-ls problem, lualine problem, telescope todo lir etc
Title:
Defer Telescope Setup, using packer lazy loading on "module = telescope"

The situation:
ak.telescope.init.lua does a safety check on require "telescope"
packer compiles to a file in plugin folder named packer_compiled(starts with a p)

Prerequisites:
Testcase : No impatient, no fixcursorhold, all telescope in opt folder
Clean nvim after every run...
Also: No "requires" to telescope outside of the lua/ak/telescope package, except for packer calling telescope setup,
and different starting positions(test scenarios) trying to invoke telescope init

The questions:
Does this require in ak.telescope.init.lua return true? 
Does calling this require result in invoking the ak.telescope.setup through packer?

Scenarios:
The starting positions calling ak.telescope.init:
a) Call from init.lua, as last line in first_load
b) Call from plugin folder, inside a file named a.lua, alphabetically less than packer_compiled
c) Call from plugin folder, inside a file named z.lua
d) Call from after/plugin folder, inside a file named z.lua

CASE 1. plugins: packer,  colortheme, plenary and telescope collection
a NO has telescope, NO invokes setup
b NO has telescope, NO invokes setup
c YES has telescope, YES invokes setup
d YES has telescope, YES invokes setup

CASE 2. plugins: all core (except impatient and fixcursor)
a NO has telescope, NO invokes setup
b NO has telescope, NO invokes setup
c YES has telescope, YES invokes setup
d YES has telescope, YES invokes setup
==> SAME as case 1

CASE 3. plugins: all (except impatient and fixcursor)
a NO has telescope, NO invokes setup
b NO has telescope, NO invokes setup
c YES has telescope, YES invokes setup
d YES has telescope, YES invokes setup
==> SAME as case 1

CASE 4. plugins: packer, color, plenary, treesitter collection AND ( impatient and fixcursor)
a NO has telescope, NO invokes setup. 
b NO has telescope, NO invokes setup
c YES has telescope, YES invokes setup
c YES has telescope, YES invokes setup
==> SAME as case 1
==> BUT: See *, impatient peculiarity

CASE 5. plugins: all
a NO has telescope, NO invokes setup.
b NO has telescope, NO invokes setup
c YES has telescope, YES invokes setup
d YES has telescope, YES invokes setup
==> BUT: See *, impatient peculiarity

* 4AB, 5AB No has telescope, thus no keymappings. But, from commandline, perform 
lua require("telescope.builtin").fd()
Now, next on next restart time, Telescope is yes on startup
And: The require("telescope") in ak.telescope.init does NOT trigger the setup!!!
--> a YES has telescope, NO invokes setup situation
Question: Does this also happen in case 1(same, without impatient) 
Answer: No. This strange behaviour occurs because of impatient!

Conclusion: 
Invoking ak.telescope.init, containing a safety check on require("telescope"),
using lazy loading on packer module = "telescope", triggering ak.telescope.setup:
Without impatience: 
No activation in scenario A+B. Telescope is in opt, but packer is not active yet 
Activation in scenario C+D. Packer triggers setup immediately, which is not the intention
With impatience:
Scenario A+B, not safe

Scenarion C ( the alpabet ) is not that great. Thus, scenarion 4, in after/plugin applies.
The first test should be the presence of the *file* telescope in opt, as a test on require
activates setup.lua immediately. With that test present, scenario A becomes the best candidate
]]
