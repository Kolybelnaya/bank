// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function() {
    var nowTemp = new Date();
    var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

  $('#client').click(function() {
    $("#account").toggle(this.checked);
  });

    $('#datepicker').datepicker({
      onRender: function(date) {
        return date.valueOf() < now.valueOf() ? 'disabled' : '';
      },
      format: 'dd/mm/yyyy'

    }).on('changeDate', function(ev){
        $('#create-datepicker').val(ev.date);
      });

  $('#create-datepicker').val($('#datepicker').val());

  $( "#services" ).change(function() {
    setOperator();
  });

  setOperator();

  var checkin = $('#gteq').datepicker({
  }).on('changeDate', function(ev) {
      if (ev.date.valueOf() > checkout.date.valueOf()) {
        var newDate = new Date(ev.date)
        newDate.setDate(newDate.getDate() + 1);
        checkout.setValue(newDate);
      }
      checkin.hide();
      $('#lteq')[0].focus();
    }).data('datepicker');
  var checkout = $('#lteq').datepicker({
    onRender: function(date) {
      return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';
    }
  }).on('changeDate', function(ev) {
      checkout.hide();
    }).data('datepicker');


});

$(document).on('page:load',function() {
  var nowTemp = new Date();
  var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

  $('#client').click(function() {
    $("#account").toggle(this.checked);
  });

  $('#datepicker').datepicker({
    onRender: function(date) {
      return date.valueOf() < now.valueOf() ? 'disabled' : '';
    },
    format: 'dd/mm/yyyy'

  }).on('changeDate', function(ev){
      $('#create-datepicker').val(ev.date);
    });

  $('#create-datepicker').val($('#datepicker').val());

  $( "#services" ).change(function() {
    setOperator();
  });

  setOperator();

  var checkin = $('#gteq').datepicker({
    format: 'dd/mm/yyyy'
  }).on('changeDate', function(ev) {
      if (ev.date.valueOf() > checkout.date.valueOf()) {
        var newDate = new Date(ev.date)
        newDate.setDate(newDate.getDate() + 1);
        checkout.setValue(newDate);
      }
      checkin.hide();
      $('#lteq')[0].focus();
    }).data('datepicker');
  var checkout = $('#lteq').datepicker({
    onRender: function(date) {
      return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';
    },

    format: 'dd/mm/yyyy'
  }).on('changeDate', function(ev) {
      checkout.hide();
    }).data('datepicker');

});


function setOperator(){
  var operator;
  switch($( "#services" ).val()) {
    case 'предоставление технической поддержки':
      operator = 1;
      break;
    case 'назначение встреч клиентов с сотрудниками отделений с целью дальнейшей продажи продукта':
      operator = 1;
      break;
    case 'работа с должниками':
      operator = 1;
      break;
    case 'reception':
      operator = 1;
      break;
    case 'работа с жалобами':
      operator = 2;
      break;
    case 'обслуживание держателей платежных карт':
      operator = 2;
      break;
    case 'послепродажное обслуживание':
      operator = 2;
      break;
    case 'продажа банковских продуктов':
      operator = 3;
      break;
    case 'информация о местоположении, контактах, режиме работы отделений':
      operator = 3;
      break;
    case 'информация о продуктах банка':
      operator = 3;
      break;
  }
  $('#search_operator_id').val(operator);
  $('#operator_id').val(operator);
  $('#service_hidden').val($( "#services" ).val());
};