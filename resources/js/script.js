let noteClassEmphList = 'cdefgab'
    .split('')
    .map(n => 'note-emphasized-' + n + 'note');
let noteClassHghlList = 'cdefgab'
    .split('')
    .map(n => 'note-emphasized-' + n + 'note');

$.domReady(() => {
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
});
