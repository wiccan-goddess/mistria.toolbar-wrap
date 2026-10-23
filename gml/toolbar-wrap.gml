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
    // look into GML method and functions
    // https://manual.gamemaker.io/lts/en/#t=GameMaker_Language%2FGML_Reference%2FVariable_Functions%2Fmethod.htm&rhsearch=method&rhhlterm=method
    // syntax for ref: method(struct_ref_or_instance_id, func)

    // add the original function?
    // and edit what i need?
    // or do I need to call the full function itself?
    // paste the function here? --- would that even work???
    // use native glm logic? functions or methods?
    // DaveyJones said to either replace or load before/after
    // replacing makes sense... or maybe loading after?

    // _menu.on_think = method(_menu, function(){
        
    // });

    // format came from Ennea Lyhsayin 
    // called a monkey patch witch is funny

    // mmapi_on("ui.menu_opened", function (ctx) {
    //     if (!is_struct(ctx) || ctx[$ "kind"] != Menu.Toolbar) { return; }

    //     var orig_on_think = ctx.menu.on_think;

    //     var new_scope = {
    //         menu: ctx.menu,
    //         orig_on_think: orig_on_think
    //     };

    //     with new_scope {
    //         var new_on_think = function () {
    //             trace("-- before on think");

    //             // your code before the original on_think

    //             orig_on_think();

    //             // your code after the original on_think

    //             trace("-- after on think");
    //         };

    //         menu.on_think = new_on_think;
    //     }
    // });

    var orig_on_think = _menu.on_think;

    var new_scope = {
        menu: _menu,
        orig_on_think: orig_on_think
    };

    with new_scope {
        var new_on_think = function () {

            // log the vars from toolbar to track location?
            // maybe compare them as well?
            // to check if the page changed at the very least?

            // def need page var to check witch page ari is on
            // maybe item index for ari?

            // for my sanity if it'd be self.something in the ToolbarMenu.gml it'll be menu.something here
            // so don't get confused if you fall asleep again...

            trace("-- before on think");

            // current values
            var old_page = menu.page;
            var old_slot = ARI.held_item_index mod 10; // stole from the toolbar

            // your code before the original on_think

            orig_on_think();

            // updated after change hopefully
            var new_page = menu.page;
            var new_slot = ARI.held_item_index mod 10;

            // your code after the original on_think

            trace("-- after on think");

            if (new_page != old_page){
                if (new_slot == 0 && old_slot == 9){
                    // if the slot itself changed then it probably rolled to the new tab
                    ARI.set_held_item_index(old_page * 10);
                    menu.page = old_page;
                    menu.update();
                }
                else if (new_slot == 9 && old_slot == 0){
                    // should work the other way now
                    // SHOULD WORK NOW
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