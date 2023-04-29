/*
 * Welcome to your app's main JavaScript file!
 *
 * We recommend including the built version of this JavaScript file
 * (and its CSS file) in your base layout (base.html.twig).
 */

// any CSS you import will output into a single css file (app.css in this case)
import './styles/app.css';

import './js/main.js';

// start the Stimulus application
import './bootstrap';


// var items = $(".list-wrapper .list-item");
// var numItems = items.length;
// var perPage = 4;

// items.slice(perPage).hide();

// $('#pagination-container').pagination({
//     items: numItems,
//     itemsOnPage: perPage,
//     prevText: "&laquo;",
//     nextText: "&raquo;",
//     onPageClick: function (pageNumber) {
//         var showFrom = perPage * (pageNumber - 1);
//         var showTo = showFrom + perPage;
//         items.hide().slice(showFrom, showTo).show();
//     }
// });
