'use strict';

var items = [
    { view: 'Translate' },
    { view: 'About' },
];

riot.mount('menu', { items: items });

var page = document.getElementById('page');

riot.route(function (view, username) {
    var custom = document.createElement(view);
    page.innerHTML = '';
    page.appendChild(custom);

    riot.mount(page, view, { username: username });
});
riot.route.start();
riot.route('Translate');
