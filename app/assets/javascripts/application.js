// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require_tree .
//= require jquery
//= require jquery.mousewheel
//= require materialize

// card枚数がx枚になったら横スクロールする
const displayWidth = $(window).width();
const LARGEST_SIZE = 1777;
const LARGE_SIZE = 1552;
const MIDDLE_SIZE = 1330;
const SMALL_SIZE = 1110;
var cardNum = 9;
var speed = 30;

if (displayWidth > LARGEST_SIZE) {
  cardNum = 9;
} else if (displayWidth > LARGE_SIZE) {
  cardNum = 8;
} else if (displayWidth > MIDDLE_SIZE) {
  cardNum = 7;
} else if (displayWidth > SMALL_SIZE) {
  cardNum = 6;
} else {
  cardNum = 5;
}

$(document).ready(function() {
  $('.card-flex').each(function(i){
    if ($('.card-flex:eq('+i+') a').length >= cardNum) {
      $('#cards-'+i).mousewheel(function(e, delta) {
          this.scrollLeft -= (delta * speed);
          e.preventDefault();
      });       
    }
  })
});
