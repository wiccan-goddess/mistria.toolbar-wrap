// My First Mod

// Runtime state initialization.
function __my_first_mod_runtime() {
    if (global[$ "__my_first_mod"] == undefined) {
        global.__my_first_mod = { registered_hooks: undefined };
    }
    return global.__my_first_mod;
}

// Hook callback registration.
function my_first_mod_register_callbacks() {
    var _rt = __my_first_mod_runtime();
    if (_rt.registered_hooks != undefined) return;
    _rt.registered_hooks = true;

    mmapi_on("game.new_day", my_first_mod_new_day); // EVENT hook registration
}

// Hook callback.
// game.new_day is an EVENT: the return value is ignored.
function my_first_mod_new_day(_ctx) {
    // _ctx contains { total_days }.
    // create_notification takes a LOCALIZATION KEY, not raw text (the engine
    // runs it through local_get). Wrapping with ANCHOR.wrap_for_local lets raw
    // text through - fine for a first mod. Shipped mods register real keys
    // instead (translatable, filter-aware): see SNIPPETS.md "Show a
    // Notification" and Mod Anatomy's "User-Facing Text".
    create_notification(ANCHOR.wrap_for_local("Day " + string(_ctx.total_days) + " begins."));
    mmapi_log_info("my_first_mod", "new day: " + string(_ctx.total_days));
    mmapi_log_flush("my_first_mod"); // make this one-line proof visible immediately
}

// MMAPI mod declaration and hook registration.
mmapi_mod_declare("my_first_mod", "1.0.0");
my_first_mod_register_callbacks();