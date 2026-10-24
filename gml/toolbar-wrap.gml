// credits to these lovely people in the unoficial discord:
// sopholopho
// DaveyJones
// Ennea Lyhsayin

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
}

// Hook callback.
function toolbar_wrap_menu_opened(_ctx) {     
    // from sopholopho code example should just check for the toolbar
    var _menu = _ctx.menu;

    if (_menu == undefined || _menu[$"type"] != Menu.Toolbar) {
        return;
    }

    var orig_on_think = _menu.on_think;

    var new_scope = {
        menu: _menu,
        orig_on_think: orig_on_think
    };

    with new_scope {
        var new_on_think = function () {

            // current values
            var old_page = menu.page;
            var old_slot = ARI.held_item_index mod 10;

            // game values
            orig_on_think();

            // updated values
            var new_page = menu.page;
            var new_slot = ARI.held_item_index mod 10;

            if (new_page != old_page){
                if (new_slot == 0 && old_slot == 9){
                    ARI.set_held_item_index(old_page * 10);
                    menu.page = old_page;
                    menu.update();
                }
                else if (new_slot == 9 && old_slot == 0){
                    ARI.set_held_item_index((old_page * 10) + 9);
                    menu.page = old_page;
                    menu.update();
                }
            }

        };

        menu.on_think = new_on_think;
    }


    mmapi_log_info("toolbar_wrap", "mod loaded yay?");
    mmapi_log_flush("toolbar_wrap"); // make this one-line proof visible immediately
}

// MMAPI mod declaration and hook registration.
mmapi_mod_declare("toolbar_wrap", "1.0.0");
toolbar_wrap_register_callbacks();