import { translateChars } from './keyboard-layouts.js';

{
    let cavatinaSpanEl = $('span.cavatina');
    let cavatinaTextareaEl = $('.textarea-cavatina-input');

    // Store US-Layout so   urce for later conversion
    cavatinaSpanEl[0].dataset.usLayoutChars = cavatinaSpanEl[0].textContent;

    $('select.select-keyboard-layout').on('change', e => {
        let countryCode = $(e.target).val();
        let fontName = 'Cavatina ' + countryCode;

        cavatinaTextareaEl.val('').css('font-family', fontName);

        let cavatinaSource = cavatinaSpanEl[0].dataset.usLayoutChars;
        let translatedSource = translateChars(countryCode, cavatinaSource);

        cavatinaSpanEl.css('font-family', fontName).text(translatedSource);
    });

    cavatinaTextareaEl
        .on('keypress', e => {
            if (e.key === 'Enter') {
                e.preventDefault();
            }
        })
        .on('paste', e => {
            let currentVal = $(e.target).val();
            let pastedText = (
                event.clipboardData || window.clipboardData
            ).getData('text');

            currentVal += pastedText.replace(/(\r\n|\n|\r)/gm, '');
            $(e.target).val(currentVal);

            e.preventDefault();
        });
}
