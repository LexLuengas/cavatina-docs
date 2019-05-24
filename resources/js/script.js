var k2colors = {
  C: '#ff5c00',
  D: '#fc9200',
  E: '#ffc600',
  F: '#b8d30b',
  G: '#2daebf',
  A: '#067ccf',
  B: '#b445d9'
};

$.domReady(() => {
  $('body').addClass('is-loaded');

  $('ul.keyboard li a').on('click', function() {
    return false;
  });

  $(document)
    .on('mouseenter', '#k1', function() {
      $('#koverlay1').css('opacity', 0.2);
    })
    .on('mouseleave', '#k1', function() {
      $('#koverlay1').css('opacity', 0.9);
    })
    .on('mouseenter', '#koverlay2 li a.box.on', function(e) {
      var keyEl = $(e.target);
      var pitchClass = keyEl
        .attr('class')
        .split(' ')
        .pop();
      $('#k2 ul.keyboard.pop li a.' + pitchClass).addClass('triggerPulse');
      keyEl.css({
        color: k2colors[keyEl.textContent],
        background: '#3d4a53',
        'text-shadow': '1px 1px 4px black'
      });
    })
    .on('mouseleave', '#koverlay2 li a.box.on', function(e) {
      var keyEl = $(e.target);
      var pitchClass = keyEl
        .attr('class')
        .split(' ')
        .pop();
      $('#k2 ul.keyboard.pop li a.' + pitchClass).removeClass('triggerPulse');
      keyEl.css({
        color: 'white',
        background: '#1b2a34',
        'text-shadow': '0 -1px #090909'
      });
    })
    .on('mouseenter', '#k2 ul.keyboard.pop li a.box.on', function(e) {
      var keyEl = $(e.target);
      var octnr = keyEl
          .closest('ul')
          .attr('id')
          .slice(-1),
        sstr,
        pitchClass = keyEl
          .attr('class')
          .split(' ')
          .pop(),
        $basenote = $('#koverlay2 li .' + pitchClass);
      if ($.inArray(keyEl.textContent, ['8', '9', '0'])) {
        sstr = $('<sub>' + 7 + '</sub>');
      } else {
        sstr = $('<sub>' + octnr + '</sub>');
      }
      pitchName = $basenote.textContent;
      $basenote.append(sstr);
      $basenote.css({
        color: k2colors[pitchName],
        background: '#3d4a53',
        'text-shadow': '1px 1px 4px black'
      });
    })
    .on('mouseleave', '#k2 ul.keyboard.pop li a.box.on', function(e) {
      var keyEl = $(e.target);
      var pitchClass = keyEl
        .attr('class')
        .split(' ')
        .pop();
      $basenote = $('#koverlay2 li .' + pitchClass);
      $('#koverlay2 li .' + pitchClass + ' sub').remove();
      $basenote.css({
        color: 'white',
        background: '#1b2a34',
        'text-shadow': '0 -1px #090909'
      });
    });
});
