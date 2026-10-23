// My First GML Mod

// Runtime state initialization.
function __toolbar_wrap_runtime() {
    if (global[$ "__toolbar_wrap"] == undefined) {
        global.__toolbar_wrap = { registered_hooks: undefined };
    }
    return global.__toolbar_wrap;
}

// Hook callback registration.
function toolbar_wrap_register_callbacks() {
    var _rt = __toolbar_wrap_runtime();
    
    if (_rt.registered_hooks != undefined) {
        return;
    }

    _rt.registered_hooks = true;

    mmapi_on("ui.menu_opened", toolbar_wrap_menu_opened); // EVENT hook registration
    // menu_opened? instead of the game_day... tracks I think?
}

// Hook callback.
function toolbar_wrap_menu_opened(_ctx) {     
    // from sopholopho code example should just check for the toolbar
    var _menu = _ctx.menu;

    if (_menu == undefined || _menu[$"type"] != Menu.Toolbar) {
        return;
    }
    
    // _menu would be toolbar now so do I just call the on_think function and edit it?
    // seems like maybe that's what Davey did for their mod?

    // something like:?
    _menu.on_think (
        // add the original function?
        // and edit what i need?
    )

    // paste the function here? --- would that even work???
    // use native glm logic? functions or methods?
    // DaveyJones said to either replace or load before/after
    // replacing makes sense... or maybe loading after?


    mmapi_log_info("toolbar_wrap", "mod loaded yay?");
    mmapi_log_flush("toolbar_wrap"); // make this one-line proof visible immediately
}

// MMAPI mod declaration and hook registration.
mmapi_mod_declare("toolbar_wrap", "1.0.0");
toolbar_wrap_register_callbacks();