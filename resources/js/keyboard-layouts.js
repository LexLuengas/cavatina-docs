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
inverter,c6,d6,e6,f6,g6,a6,b6,c7,d7,e7,flat,sharp,
c5,d5,e5,f5,g5,a5,b5,coda,1st repetition,sustain pedal,mordent,eighth rest,piano,
c4,d4,e4,f4,g4,a4,b4,da capo,crescendo,repetition (start),staccato,
c3,d3,e3,f3,g3,a3,b3,barline,final barline,half space,
time,C6,D6,E6,F6,G6,A6,B6,C7,D7,E7,F-clef,G-clef,
C5,D5,E5,F5,G5,A5,B5,segno,ottava,arpeggio,turn,quarter rest,forte,
C4,D4,E4,F4,G4,A4,B4,dal segno,tie,repetition (end),tenuto,
C3,D3,E3,F3,G3,A3,B3,dot,accent,triplet`
    .replace('\n', '')
    .split(',');

const extraKeyToUsIndex = {
    '0': 25,
    '1': 37,
    '2': 38,   
    '3': 49
}

function getSymbolName(c) {
    // Assumes c is a character from the US-Layout dialect
    if (c === ' ') return 'space';
    var i = cavatinaRosetta['US'].indexOf(c);
    return cavatinaSemantic[i];
}

function translateChar(countryCode, c) {
    // always translates from US-layout
    if (c === ' ') return c;
    var i = cavatinaRosetta['US'].indexOf(c);
    return cavatinaRosetta[countryCode].charAt(i);
}

function translateChars(countryCode, s) {
    if (countryCode === 'US') return s;
    return s
        .split('')
        .map(c => translateChar(countryCode, c))
        .join('');
}

/**
 * Remaps keys from the 'US' keyboard layout to the given layout.
 * @param {string} countryCode
 * @param {string} key
 * @param {boolean} isExtra
 * @returns {Array<string>} Array containing up to two key strings.
 */
function remapKeys(countryCode, key, isExtra) {
    let remappedKeyAt = i => keyLayoutRosetta[countryCode].charAt(i);
    let remappedCompoundKeyAt = i => [remappedKeyAt(i), remappedKeyAt(i + 50)];

    if (!isExtra) {
        if (countryCode === 'US' || key.length !== 1) return [key];
        let i = keyLayoutRosetta['US'].indexOf(key);
        return [remappedKeyAt(i)];
    } else {
        let i = extraKeyToUsIndex[key];
        return remappedCompoundKeyAt(i);
    }
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

export { getKeyboardType, remapKeys, translateChars, getSymbolName }
