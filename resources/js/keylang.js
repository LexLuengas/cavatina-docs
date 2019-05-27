var keyLayout = {
    US:
        '`1234567890-=qwertyuiop[]\\asdfghjkl;\'zxcvbnm,./~!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:"ZXCVBNM<>?',
    DE:
        '^1234567890\'#qwertzuiopöü+asdfghjkl;äyxcvbnm,.-°!"§$%&/()=?ßQWERTZUIOPÖÜ*ASDFGHJKL:ÄYXCVBNM<>_',
    SPh:
        '|1234567890\'¿qwertyuiop{}*asdfghjkl;ñzxcvbnm,.-°!"#$%&/()=?¡QWERTYUIOP[]+ASDFGHJKL:ÑZXCVBNM<>_',
    FR:
        '!&é"\'(-è_çà)=azertyuiopmù°qsdfghjkl;*wxcvbn,/.³§1234567890£$AZERTYUIOPM%+QSDFGHJKL:μWXCVBN?<>²',
    IT:
        '\\1234567890*+qwertyuiopùòlasdfghjk<;\'zxcvbnm,.-|!"£$%&/()=èéQWERTYUIOP§çLASDFGHJK>:?ZXCVBNM°à_',
    PTb:
        '\'1234567890-=qwertyuiop[]lasdfghjkÇ;´zxcvbnm,./"!@#$%¨&*()_+QWERTYUIOP{}LASDFGHJKç:`ZXCVBNM<>?',
    PTp:
        '\\1234567890*+qwertyuiop«çlasdfghjk<;´zxcvbnm,.-|!"#$%&/()=?\'QWERTYUIOP»ÇLASDFGHJK>:`ZXCVBNMºª_',
    PTa:
        '§1234567890*+qwertyuiop~çªasdfghjkl;´zxcvbnm,.-±!"#$%&/()=?\'QWERTYUIOP^ÇºASDFGHJKL:`ZXCVBNM<>_',
    SPi:
        'º1234567890\'¡qwertyuiopñç*asdfghjkl;´zxcvbnm,.-ª!"·$%&/()=?¿QWERTYUIOPÑÇ+ASDFGHJKL:¨ZXCVBNM<>_',
    BRw:
        '`1234567890~#qwertyuiop[]_asdfghjkl;\'zxcvbnm,./¬!"£$%^&*()-=QWERTYUIOP{}+ASDFGHJKL:@ZXCVBNM<>?',
    BRa:
        '§1234567890-=qwertyuiop[]\\asdfghjkl;\'zxcvbnm,./±!@£$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:"ZXCVBNM<>?'
};

let cavatinaSemantic = `
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

function remapChar(countryCode, c) {
    // always translates from US-layout
    var i = keyLayout['US'].indexOf(c);
    return keyLayout[countryCode].charAt(i);
}

function remapChars(countryCode, s) {
    return s.split('').map(c => remapChar(countryCode, c)).join('');
}

function remapKeys(countryCode, key) {
    if (typeof key == 'string') {
        return remapChar(countryCode, key);
    } else {
        // number, extra keys
        if (key == 0) return ['\\', '|'];
        if (key == 1)
            return [
                keyLayout[countryCode].charAt(37),
                keyLayout[countryCode].charAt(87)
            ];
        if (key == 2)
            return [
                keyLayout[countryCode].charAt(38),
                keyLayout[countryCode].charAt(88)
            ];
        if (key == 3)
            return [
                keyLayout[countryCode].charAt(49),
                keyLayout[countryCode].charAt(99)
            ];
    }
}

var states = [
    [true, false, false, false],
    [false, true, true, false],
    [false, true, true, true]
];

function reallocateKeyboard(i) {
    // i in [0, 1, 2],
    var s = states[i];

    $('#k2 [data-extra-key]')
        .parent()
        .each(function(index, e) {
            if (s[index]) {
                $(this).removeClass('hidden');
            } else {
                $(this).addClass('hidden');
                $(this)
                    .find('a')
                    .html(' ');
            }
        });

    $('#k1 ul#keyboard1 [data-extra-key]')
        .parent()
        .each(function(index, e) {
            if (s[index + 2]) {
                $(this).removeClass('hidden');
            } else {
                $(this).addClass('hidden');
                $(this)
                    .find('a')
                    .html(' ');
            }
        });

    $('#k1 ul#koverlay1 [data-extra-key]')
        .parent()
        .each(function(index, e) {
            if (s[index + 2]) {
                $(this).removeClass('hidden');
            } else {
                $(this).addClass('hidden');
                $(this)
                    .find('a')
                    .html(' ');
            }
        });

    // adjust key widths
    if (s[1]) {
        $('#k2 li#return').attr('id', 'return-small');
    } else {
        $('#k2 li#return-small').attr('id', 'return');
    }

    if (s[2]) {
        $('#k2 li#shift-small').attr('id', 'shift');
        $('#k2 li#shift')
            .first()
            .attr('id', 'shift-small');
    } else {
        $('#k2 li#shift-small').attr('id', 'shift');
    }

    if (s[3]) {
        $('#k2 li#shift').attr('id', 'shift-small');
    }
}

function extraKeysForLang(countryCode) {
    switch (countryCode) {
        case 'US':
            return 0;
        case 'PTb':
            return 2;
        default:
            return 1;
    }
}

$(function() {
    let lastLang = 'US';

    $('select.select-keyboard-layout').on('change', e => {
        var countryCode = $(e.target).val();
        if (countryCode === lastLang) return;
        lastLang = countryCode;

        let extraKeys = extraKeysForLang(countryCode);

        // Most of the times, no reallocation is necessary
        if (
            ['US', 'PTb'].includes(countryCode) ||
            ['US', 'PTb'].includes(lastLang)
        ) {
            reallocateKeyboard(extraKeys);
        }

        $('p:not([class])')
            .find('code')
            .each(codeEl => {
                codeEl.textContent = remapChars(countryCode, codeEl.textContent);
            });
    });
});
