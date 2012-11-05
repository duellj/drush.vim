Drush support in Vim
====================

Currently provides two functions:

`DrushHook [hook]`
------------------

Searches current Drupal install for implementations of the passed hook, e.g.

    :DrushHook menu

will find all active implementations of `hook_menu`.

`DrushVariable [variable]`
--------------------------

Gets a list of variables and values and formats them in `variable_set`s.
`[variable]` argument can be a wild card, e.g.

    :DrushVariable preprocess

will print out the following:

    variable_set('preprocess_js', 0);
    variable_set('preprocess_css', 0);

Any other suggestions to make Drupal development in vim easier are welcome!
