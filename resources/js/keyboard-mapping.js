import {
    getKey,
    getSymbolName,
    getKeyboardType,
    showcaseSymbol,
    remapKey,
    translateCharFrom
} from './keyboard-layouts.js';
import { setQueryParameter, reallocateKeyboard, isAlphaRegex } from './util.js';

let state = {
    selectedKey: null,
    isStaticInfoVisible: true,
    countryCode: 'US',
    currentKeySymbols: new Map()
};

let topOutputRow = $('.table-display-key-semantics tr:first-child');
let bottomOutputRow = $('.table-display-key-semantics tr:last-child');
let cavatinaElTop = topOutputRow.find('td .cavatina')[0];
let cavatinaElBottom = bottomOutputRow.find('td .cavatina')[0];
let symbolElTop = topOutputRow.find('td code')[0];
let symbolElBottom = bottomOutputRow.find('td code')[0];
let descriptionElTop = topOutputRow.find('td .cavatina-symbol-name')[0];
let descriptionElBottom = bottomOutputRow.find('td .cavatina-symbol-name')[0];

function setKeyLabel(keyEl, key) {
    let [bottomChar, topChar] = key;
    if (isAlphaRegex.test(bottomChar) && bottomChar === topChar.toLowerCase()) {
        keyEl.textContent = topChar;
    } else {
        // Display both symbols of the key
        keyEl.innerHTML = '<div></div><div></div>';
        keyEl.childNodes[1].textContent = bottomChar;
        keyEl.childNodes[0].textContent = topChar;
    }
}

function showKeyInfo([bottomChar, topChar]) {
    let usBottomChar = translateCharFrom(state.countryCode, bottomChar);
    let usTopChar = translateCharFrom(state.countryCode, topChar);

    cavatinaElBottom.textContent = showcaseSymbol(usBottomChar);
    cavatinaElTop.textContent = showcaseSymbol(usTopChar);

    symbolElBottom.textContent = bottomChar;
    symbolElTop.textContent = topChar;

    descriptionElBottom.textContent = usBottomChar.length
        ? getSymbolName(usBottomChar)
        : '(unused character)';
    descriptionElTop.textContent = usBottomChar.length
        ? getSymbolName(usTopChar)
        : '(unused character)';
}

function clearStaticInfo() {
    cavatinaElTop.textContent = '  ';
    cavatinaElBottom.textContent = '  ';
    symbolElTop.textContent = '';
    symbolElBottom.textContent = '';
    descriptionElTop.textContent = '';
    descriptionElBottom.textContent = '';
}

function showStaticInfo() {
    if (state.isStaticInfoVisible) return;
    state.isStaticInfoVisible = true;

    if (state.selectedKey !== null) {
        showKeyInfo(state.selectedKey);
    } else {
        clearStaticInfo();
    }
}

function clearSelection() {
    $('li.selected').removeClass('selected');
    state.selectedKey = null;
    clearStaticInfo();
    state.isStaticInfoVisible = false;
}

// Event binding and setup
{
    let keyEls = $('.keyboard-row button');

    // Store inital US-Layout character for later conversion
    keyEls.each(keyEl => {
        let symbol = keyEl.textContent;

        // Control key
        if (
            symbol.length === 0 &&
            typeof keyEl.dataset.extraKey === 'undefined'
        ) {
            return;
        }

        keyEl.dataset.usLayoutChars = symbol;

        let key = getKey(symbol);
        setKeyLabel(keyEl, key);
        state.currentKeySymbols.set(keyEl, key);

        $(keyEl)
            .on('mouseenter', () => {
                state.isStaticInfoVisible = false;
                let key = state.currentKeySymbols.get(keyEl);
                showKeyInfo(key);
            })
            .on('click', () => {
                let key = state.currentKeySymbols.get(keyEl);
                state.selectedKey = key;
                $('li.selected').removeClass('selected');
                $(keyEl)
                    .parent()
                    .addClass('selected');
            });
    });

    $('.keyboard-row').on('mouseenter', 'button[disabled]', _ => {
        showStaticInfo();
    });

    $('.keyboard-row-container').on('mouseleave', _ => {
        showStaticInfo();
    });

    $('body')
        .on('click', e => {
            if (e.target.closest('.keyboard-row-container') === null) {
                clearSelection();
            }
        })
        .on('keyup', _ => {
            clearSelection();
        });

    $('select.select-keyboard-layout').on('change', e => {
        var countryCode = $(e.target).val();
        setQueryParameter('keyboard_layout', countryCode);
        state.countryCode = countryCode;

        clearSelection();

        let keyboardType = getKeyboardType(countryCode);
        reallocateKeyboard(keyboardType);

        keyEls.each(keyEl => {
            let isExtra = typeof keyEl.dataset.extraKey !== 'undefined';
            let symbol = !isExtra
                ? keyEl.dataset.usLayoutChars
                : keyEl.dataset.extraKey;

            // Control key
            if (typeof symbol === 'undefined') {
                state.currentKeySymbols.delete(keyEl);
                return;
            }

            let key = remapKey(countryCode, symbol, isExtra);
            setKeyLabel(keyEl, key);
            state.currentKeySymbols.set(keyEl, key);
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
