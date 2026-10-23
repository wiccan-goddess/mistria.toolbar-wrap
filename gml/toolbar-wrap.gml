// This is entirely based off of sopholopho's example in the unofficial discord. Thanks for the example!!! <3
// might have to find a dif way to hook but maybe not...

// custom function for mod
function toolbar_wrap_apply(_menu) {
    // have the bar wrap back to position one instead of the next tab
    // would this be a cursor thing? or is it a hardcoded keybind value?
    // who knows... not me. yet...
}

// hook into the game maybe?

function toolbar_wrap_menu_opened(_ctx){
    // game hook?
}

// mod name and version for MOMI to read. I think...
mmapi_mod_declare("toolbar wrap", "1.0.0")

// second function (hooking into the game?)
mmapi_on("ui.menu_opened", toolbar_wrap_menu_opened);

// first function (custom)
mmapi_on("ui.toolbar_tick", toolbar_wrap_apply);