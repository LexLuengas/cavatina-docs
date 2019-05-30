/**
 * Translation table for Cavatina symbols with respect to the US-English dialect.
 * The character at position n in a string corresponds to the character at the
 * same position in the US-Layout string.
 *
 * NOTE: This is *not* the same as `keyLayoutRosetta`.
 */
const cavatinaRosetta = {
    US:
        "`1234567890-=qwertyuiop[]\\asdfghjkl;'zxcvbnm,./" +
        '~!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:"ZXCVBNM<>?',
    DE:
        "^1234567890'#qwertzuiopöü*asdfghjkl;äyxcvbnm,.-" +
        '°!"§$%&/()=?ßQWERTZUIOPÖÜ+ASDFGHJKL:ÄYXCVBNM<>_',
    SPh:
        "|1234567890'¿qwertyuiop{}*asdfghjkl;ñzxcvbnm,.-" +
        '°!"#$%&/()=?¡QWERTYUIOP[]+ASDFGHJKL:ÑZXCVBNM<>_',
    FR:
        '!&é"\'(-è_çà)=azertyuiopmù°qsdfghjkl;*wxcvbn,/.³' +
        '§1234567890£$AZERTYUIOPM%+QSDFGHJKL:μWXCVBN?<>²',
    IT:
        "\\1234567890*+qwertyuiopùòlasdfghjk<;'zxcvbnm,.-" +
        '|!"£$%&/()=èéQWERTYUIOP§çLASDFGHJK>:?ZXCVBNM°à_',
    PTb:
        "'1234567890-=qwertyuiop[]lasdfghjkÇ;´zxcvbnm,./" +
        '"!@#$%¨&*()_+QWERTYUIOP{}LASDFGHJKç:`ZXCVBNM<>?',
    PTp:
        '\\1234567890*+qwertyuiop«çlasdfghjk<;´zxcvbnm,.-' +
        '|!"#$%&/()=?\'QWERTYUIOP»ÇLASDFGHJK>:`ZXCVBNMºª_',
    PTa:
        '§1234567890*+qwertyuiop~çªasdfghjkl;´zxcvbnm,.-' +
        '±!"#$%&/()=?\'QWERTYUIOP^ÇºASDFGHJKL:`ZXCVBNM<>_',
    SPi:
        "º1234567890'¡qwertyuiopñç*asdfghjkl;´zxcvbnm,.-" +
        'ª!"·$%&/()=?¿QWERTYUIOPÑÇ+ASDFGHJKL:¨ZXCVBNM<>_',
    BRw:
        "`1234567890~#qwertyuiop[]_asdfghjkl;'zxcvbnm,./" +
        '¬!"£$%^&*()-=QWERTYUIOP{}+ASDFGHJKL:@ZXCVBNM<>?',
    BRa:
        "§1234567890-=qwertyuiop[]\\asdfghjkl;'zxcvbnm,./" +
        '±!@£$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:"ZXCVBNM<>?'
};

/**
 * Mapping between one keyboard layout and another.
 */
const keyLayoutRosetta = {
    US:
        '`1234567890-=' +
        'qwertyuiop[]\\' +
        "asdfghjkl;' " +
        ' zxcvbnm,./ ' +
        '~!@#$%^&*()_+' +
        'QWERTYUIOP{}|' +
        'ASDFGHJKL:" ' +
        ' ZXCVBNM<>? ',
    DE:
        '^1234567890ß´' +
        'qwertzuiopü+ ' +
        'asdfghjklöä#' +
        '<yxcvbnm,.- ' +
        '°!"§$%&/()=?`' +
        'QWERTZUIOPÜ* ' +
        "ASDFGHJKLÖÄ'" +
        '>YXCVBNM;:_ ',
    SPh:
        "|1234567890'¿" +
        'qwertyuiop´+ ' +
        'asdfghjklñ{}' +
        '<zxcvbnm,.- ' +
        '°!"#$%&/()=?¡' +
        'QWERTYUIOP¨* ' +
        'ASDFGHJKLÑ[]' +
        '>ZXCVBNM;:_ ',
    FR:
        '²&é"\'(-è_çà)=' +
        'azertyuiop^$ ' +
        'qsdfghjklmù*' +
        '<wxcvbn,;:! ' +
        ' 1234567890°+' +
        'AZERTYUIOP¨£ ' +
        'QSDFGHJKLM%μ' +
        '>WXCVBN?./§ ',
    IT:
        "\\1234567890'ì" +
        'qwertyuiopè+ ' +
        'asdfghjklòàù' +
        '<zxcvbnm,.- ' +
        '|!"£$%&/()=?^' +
        'QWERTYUIOPé* ' +
        'ASDFGHJKLç°§' +
        '>ZXCVBNM;:_ ',
    PTb:
        "'1234567890-=" +
        'qwertyuiop´[ ' +
        'asdfghjklç~]' +
        '\\zxcvbnm,.;/' +
        '"!@#$%¨&*()_+' +
        'QWERTYUIOP`{ ' +
        'ASDFGHJKLÇ^}' +
        '|ZXCVBNM<>:?',
    PTp:
        "\\1234567890'«" +
        'qwertyuiop+´ ' +
        'asdfghjklçº~' +
        '<zxcvbnm,.- ' +
        '|!"#$%&/()=?»' +
        'QWERTYUIOP*` ' +
        'ASDFGHJKLÇª^' +
        '>ZXCVBNM;:_ ',
    PTa:
        "§1234567890'+" +
        'qwertyuiopº´ ' +
        'asdfghjklç~\\' +
        '<zxcvbnm,.- ' +
        '±!"#$%&/()=?*' +
        'QWERTYUIOPª` ' +
        'ASDFGHJKLÇ^|' +
        '>ZXCVBNM;:_ ',
    SPi:
        "º1234567890'¡" +
        'qwertyuiop`+ ' +
        'asdfghjklñ´ç' +
        '<zxcvbnm,.- ' +
        'ª!"·$%&/()=?¿' +
        'QWERTYUIOP^* ' +
        'ASDFGHJKLÑ¨Ç' +
        '>ZXCVBNM;:_ ',
    BRw:
        '`1234567890-=' +
        'qwertyuiop[] ' +
        "asdfghjkl;'#" +
        '\\zxcvbnm,./ ' +
        '¬!"£$%^&*()_+' +
        'QWERTYUIOP{} ' +
        'ASDFGHJKL:@~' +
        '|ZXCVBNM<>? ',
    BRa:
        '§1234567890-=' +
        'qwertyuiop[] ' +
        "asdfghjkl;'\\" +
        '`zxcvbnm,./ ' +
        '±!@£$%^&*()_+' +
        'QWERTYUIOP{} ' +
        'ASDFGHJKL:"|' +
        '~ZXCVBNM<>? '
};

const cavatinaSemantic = `
inverter,C6 eighth note,D6 eighth note,E6 eighth note,F6 eighth note,G6 eighth note,A6 eighth note,B6 eighth note,C7 eighth note,D7 eighth note,E7 eighth note,flat,sharp,
C5 eighth note,D5 eighth note,E5 eighth note,F5 eighth note,G5 eighth note,A5 eighth note,B5 eighth note,coda,1st repetition,sustain pedal,mordent,eighth rest,piano,
C4 eighth note,D4 eighth note,E4 eighth note,F4 eighth note,G4 eighth note,A4 eighth note,B4 eighth note,da capo,crescendo,repetition start,staccato,
C3 eighth note,D3 eighth note,E3 eighth note,F3 eighth note,G3 eighth note,A3 eighth note,B3 eighth note,barline,final barline,short staff block,
time,C6 quarter note,D6 quarter note,E6 quarter note,F6 quarter note,G6 quarter note,A6 quarter note,B6 quarter note,C7 quarter note,D7 quarter note,E7 quarter note,F-clef,G-clef,
C5 quarter note,D5 quarter note,E5 quarter note,F5 quarter note,G5 quarter note,A5 quarter note,B5 quarter note,segno,ottava,arpeggio,turn,quarter rest,forte,
C4 quarter note,D4 quarter note,E4 quarter note,F4 quarter note,G4 quarter note,A4 quarter note,B4 quarter note,dal segno,tie,repetition end,tenuto,
C3 quarter note,D3 quarter note,E3 quarter note,F3 quarter note,G3 quarter note,A3 quarter note,B3 quarter note,dot,accent,triplet`
    .replace(/\n/g, '')
    .split(',');

const usLayoutSemantics = cavatinaSemantic.reduce((acc, val, i, a) => {
    return acc.set(cavatinaRosetta['US'].charAt(i), val);
}, new Map());

const extraKeyToUsIndex = {
    '0': 25,
    '1': 37,
    '2': 38,
    '3': 49
};

function getKeyPairByIndex(countryCode, index) {
    index = index % 50;
    return [
        keyLayoutRosetta[countryCode].charAt(index),
        keyLayoutRosetta[countryCode].charAt(index + 50)
    ];
}

function getKey(c) {
    // Assumes c is a character from the US-layout keyboard
    if (c.length !== 1) return [c, c];
    let i = keyLayoutRosetta['US'].indexOf(c);
    return getKeyPairByIndex('US', i);
}

function getSymbolName(c) {
    // Assumes c is a symbol from the US-layout dialect
    if (c === ' ') return 'staff block';
    return usLayoutSemantics.get(c);
}

function showcaseSymbol(s) {
    // Provides a string for showcasing a symbol of the US-layout dialect
    let symbolName = getSymbolName(s);
    if (/^[A-Z]\d/.test(symbolName) || ';:]}kK'.includes(s)) return '  ' + s;
    if ('_+/'.includes(s)) return s;
    if ('oiI'.includes(s)) return s + '  ';
    return '  F' + s;
}

function translateChar(countryCode, c) {
    // always translates from US-layout
    if (c === ' ') return c;
    let i = cavatinaRosetta['US'].indexOf(c);
    return cavatinaRosetta[countryCode].charAt(i);
}

function translateChars(countryCode, s) {
    if (countryCode === 'US') return s;
    return s
        .split('')
        .map(c => translateChar(countryCode, c))
        .join('');
}

function translateCharFrom(countryCode, c) {
    // always translates *to* US-layout
    if (c === ' ') return c;
    let i = cavatinaRosetta[countryCode].indexOf(c);
    return cavatinaRosetta['US'].charAt(i);
}

/**
 * Remaps keys from the 'US' keyboard layout to the given layout.
 * @param {string} countryCode The counrty code of the target keyboard layout to convert to
 * @param {string} key
 * @param {boolean} isExtra
 * @returns {Array<string>} Array containing up to two key strings.
 */
function remapKey(countryCode, key, isExtra) {
    let i;
    if (!isExtra) {
        if (countryCode === 'US') return getKey(key);
        i = keyLayoutRosetta['US'].indexOf(key);
    } else {
        i = extraKeyToUsIndex[key];
    }
    return getKeyPairByIndex(countryCode, i);
}

function getKeyboardType(countryCode) {
    switch (countryCode) {
        case 'US':
            return 1;
        case 'PTb':
            return 3;
        default:
            return 2;
    }
}

export {
    getKey,
    getKeyboardType,
    remapKey,
    translateChars,
    translateCharFrom,
    getSymbolName,
    showcaseSymbol
};
