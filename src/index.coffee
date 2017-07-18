greeting = (name) ->
	"Hello #{name}!"

menus       = []
menu_strs   = []

line_cursor = 0
console.log greeting "Marcus"

class Menu
  set_parent: (menu) ->
    @parent = menu

  add_node: (menu) ->
    @nodes.push menu

  constructor: (text,level) ->
    @text   = text.trim()
    @level  = level 
    @parent = {}
    @nodes  = []

cal_level = (line) -> 
  len_space = line.match(/^\s*/)[0].length
  level     = len_space / 2

fs          = require('fs')
readline    = require('readline')
stream      = require('stream')
instream    = fs.createReadStream('./menu.txt')
outstream   = new stream
rl          = readline.createInterface(instream, outstream)
rl.on 'line', (line) ->
  line_trim = line.trim()
  current_m = new Menu(line , cal_level(line) )
  menus.push current_m
  menu_strs.push line_trim

  if current_m.level == 0
    current_m.set_parent {}
  if current_m.level > 0 
    line_index = menu_strs.indexOf( line_trim )
    # console.log( menu_strs , line_trim, level ,line_index , line_index - 1  )
    for i in [line_index..0]
      # console.log( menus[line_index].level )
      menu_level      = menus[i].level
      if menu_level == current_m.level - 1
        parent_menu   = menus[i]
        current_m.set_parent parent_menu
        parent_menu.add_node current_m
        break;
      # console.log(i)
    # 


  return
rl.on 'close', ->
  console.log '>> result end '
  console.dir menus, {depth: 3, colors: true}
 
  
