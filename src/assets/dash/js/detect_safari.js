var isSafari = false;

if (window.navigator.vendor.includes('Apple') &&
    !window.navigator.userAgent.includes('CriOS') &&
    !window.navigator.userAgent.includes('FxiOS')) {
        isSafari = true;
} 

if (isSafari) {
    var child = document.getElementById('dartpad-landing-page');
    child.parentNode.removeChild(child);
}
