var isSafari = /constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || (typeof safari !== 'undefined' && safari.pushNotification));

if (isSafari) {
    // select dartpad parent element
    var child = document.getElementById('dartpad-landing-page');
    child.parentNode.removeChild(child);
}