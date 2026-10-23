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
    if (_rt.registered_hooks != undefined) return;
    _rt.registered_hooks = true;

    mmapi_on("ui.menu_opened", toolbar_wrap_menu_opened); // EVENT hook registration
    // menu_opened? instead of the game_day... tracks I think?
}

// Hook callback.
// game.new_day is an EVENT: the return value is ignored.
function toolbar_wrap_menu_opened(_ctx) {
    // _ctx contains { total_days }.
    // create_notification takes a LOCALIZATION KEY, not raw text (the engine
    // runs it through local_get). Wrapping with ANCHOR.wrap_for_local lets raw
    // text through - fine for a first mod. Shipped mods register real keys
    // instead (translatable, filter-aware): see SNIPPETS.md "Show a
    // Notification" and Mod Anatomy's "User-Facing Text".

    // paste the function here?
    // would that even work???

    create_notification(ANCHOR.wrap_for_local("Day " + string(_ctx.total_days) + " begins."));
    mmapi_log_info("toolbar_wrap", "new day: " + string(_ctx.total_days));
    mmapi_log_flush("toolbar_wrap"); // make this one-line proof visible immediately
}

// MMAPI mod declaration and hook registration.
mmapi_mod_declare("toolbar_wrap", "1.0.0");
toolbar_wrap_register_callbacks();