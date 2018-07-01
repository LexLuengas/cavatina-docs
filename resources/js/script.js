$('ul.keyboard li a').on('click', function() {
  return false;
});

// Keyboard 1
$(document).on({
  mouseenter: function () {
    $("#koverlay1").css('opacity', 0.2);
  },
  mouseleave: function () {
    $("#koverlay1").css('opacity', 0.9);
  }
}, "#k1");

// Keyboard 2
// colors
var k2colors = {
  C: "#ff5c00",
  D: "#fc9200",
  E: "#ffc600",
  F: "#b8d30b",
  G: "#2daebf",
  A: "#067ccf",
  B: "#b445d9",
};

// hover keyboard
$(document).on({
  mouseenter: function(e) {
    var pitchClass = $(this).attr('class').split(" ").pop();
    $("#k2 ul.keyboard.pop li a." + pitchClass).addClass('triggerPulse');
    $(this).css({
      'color': k2colors[$(this).html()],
      'background': "#3d4a53",
      'text-shadow': '1px 1px 4px black'
    });
  },
  mouseleave: function(e) {
    var pitchClass = $(this).attr('class').split(" ").pop();
    $("#k2 ul.keyboard.pop li a." + pitchClass).removeClass('triggerPulse');
    $(this).css({
      'color': 'white',
      'background': "#1b2a34",
      'text-shadow': '0 -1px #090909'
    });
  }
}, "#koverlay2 li a.box.on");

// hover note row
$(document).on({
  mouseenter: function(e) {

    var octnr = $(this).closest('ul').attr('id').slice(-1),
      sstr,
      pitchClass = $(this).attr('class').split(" ").pop(),
      $basenote = $("#koverlay2 li ." + pitchClass);
    if ($.inArray($(this).html(), ["8", "9", "0"]) > -1) {
      sstr = $("<sub>" + 7 + "</sub>")
    } else {
      sstr = $("<sub>" + octnr + "</sub>")
    }
    pitchName = $basenote.html()
    $basenote.append(sstr);
    $basenote.css({
      'color': k2colors[pitchName],
      'background': "#3d4a53",
      'text-shadow': '1px 1px 4px black'
    });
    // text-shadow: 0 -1px $keybg;
  },
  mouseleave: function(e) {
    var pitchClass = $(this).attr('class').split(" ").pop();
    $basenote = $("#koverlay2 li ." + pitchClass);
    $("#koverlay2 li ." + pitchClass + " sub").remove();
    $basenote.css({
      'color': 'white',
      'background': "#1b2a34",
      'text-shadow': '0 -1px #090909'
    });
  }
}, "#k2 ul.keyboard.pop li a.box.on");

$(function() {
  $("body").addClass("is-loaded");
});