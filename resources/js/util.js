export const isAlphaRegex = /^[A-Zèàùòüäöçñ]$/i;

export function setQueryParameter(key, value) {
    if (window.history.replaceState) {
        let { protocol, host, pathname, hash } = window.location;
        var url = `${protocol}//${host}${pathname}?${key}=${value}${hash}`;
        window.history.replaceState({ path: url }, document.title, url);
    }
}

export function reallocateKeyboard(keyboardType) {
    if (!(keyboardType >= 1 && keyboardType <= 3))
        throw new Error('keyboardType outside range [1, 3].');
    let klTypeClassList = [1, 2, 3].map(i => 'key-layout-type-' + i).join(' ');
    
    let keyboardContainerEl = $('.keyboard-container');
    keyboardContainerEl
        .removeClass(klTypeClassList)
        .addClass('key-layout-type-' + keyboardType);

    let keyReturnUpper = keyboardContainerEl.find('.is-key-return-upper button')[0];
    if (keyboardType !== 1) {
        keyReturnUpper.setAttribute('disabled', '');
    } else {
        keyReturnUpper.removeAttribute('disabled');
    }
}
