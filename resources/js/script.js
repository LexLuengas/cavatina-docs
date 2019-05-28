import {
    getKeyboardType,
    remapKeys,
    translateChars,
    reallocateKeyboard
} from './keyboard-layouts.js';

const noteClassEmphList = 'cdefgab'
    .split('')
    .map(n => 'note-emphasized-' + n + 'note');
const noteClassHghlList = 'cdefgab'
    .split('')
    .map(n => 'note-emphasized-' + n + 'note');

const isAlphaRegex = /^[A-Zèàùòüäöç]$/i;

function setQueryParameter(key, value) {
    if (window.history.pushState) {
        let { protocol, host, pathname, hash } = window.location;
        var url = `${protocol}//${host}${pathname}?${key}=${value}${hash}`;
        window.history.pushState({ path: url }, document.title, url);
    }
}

// Setup keyboard graphics
{
    let keyboardContFullEl = $('.keyboard-container-full');

    $('.keyboard-row-notes')
        .find('li')
        .on('mouseenter', function(e) {
            let noteClass = $(e.currentTarget)
                .find('button')[0]
                .classList.item(0);
            keyboardContFullEl.removeClass(noteClassEmphList.join(' '));
            keyboardContFullEl.addClass('note-emphasized-' + noteClass);
        })
        .on('mouseleave', e => {
            let noteClass = $(e.currentTarget)
                .find('button')[0]
                .classList.item(0);
            keyboardContFullEl.removeClass('note-emphasized-' + noteClass);
        });

    let removeHighlightTimeout;
    let lastNoteClass;
    keyboardContFullEl
        .find('.keyboard-row:not(.keyboard-row-notes)')
        .find('li > button:not([disabled])')
        .on('mouseenter', function(e) {
            let noteClass = $(e.currentTarget)[0].classList.item(0);
            if (lastNoteClass === noteClass) {
                clearTimeout(removeHighlightTimeout);
            }
            lastNoteClass = noteClass;
            let kbNoteClass = 'note-highlighted-' + noteClass;
            keyboardContFullEl.removeClass(
                noteClassHghlList.filter(c => c !== kbNoteClass).join(' ')
            );
            keyboardContFullEl.addClass(kbNoteClass);
        })
        .on('mouseleave', e => {
            let noteClass = $(e.currentTarget)[0].classList.item(0);
            lastNoteClass = noteClass;
            removeHighlightTimeout = setTimeout(() => {
                keyboardContFullEl.removeClass('note-highlighted-' + noteClass);
            }, 15);
        });
}

// Setup keyboard layout selection
{
    let codeEls = $('p').find('code');
    let keyEls = $('.keyboard-row').find('button');

    // Store inital US-Layout character for later conversion
    $('p > code, .keyboard-row button').each(codeEl => {
        codeEl.dataset.usLayoutChars = codeEl.textContent;
    });

    $('select.select-keyboard-layout')
        .on('change', e => {
            var countryCode = $(e.target).val();
            setQueryParameter('keyboard_layout', countryCode);
            
            let keyboardType = getKeyboardType(countryCode);
            reallocateKeyboard(keyboardType);

            codeEls.each(codeEl => {
                codeEl.textContent = translateChars(
                    countryCode,
                    codeEl.dataset.usLayoutChars
                );
            });

            keyEls.each(keyEl => {
                let isExtra = typeof keyEl.dataset.extraKey !== 'undefined';
                let key = !isExtra
                    ? keyEl.dataset.usLayoutChars
                    : keyEl.dataset.extraKey;
                let [bottomKey] = remapKeys(
                    countryCode,
                    key.toString(),
                    isExtra
                );
                keyEl.textContent = isAlphaRegex.test(bottomKey)
                    ? bottomKey.toUpperCase()
                    : bottomKey;
            });
        });
}

// Setup URL search query logic
{
    let params = new URLSearchParams(window.location.search.substring(1));
    let kblParam = params.get('keyboard_layout');
    if (!kblParam) {
        setQueryParameter('keyboard_layout', 'US');
    } else {
        if (kblParam !== 'US') {
            $('select.select-keyboard-layout')
                .val(params.get('keyboard_layout'))
                .trigger('change');
        }
    }
}
