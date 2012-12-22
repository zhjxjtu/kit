# Place all the behaviors and hooks related to layouts here.

$ ->
  $("[rel=tooltip]").tooltip()
  $('.btn-remind').click ->
    $(this).button('loading')
    $(this).removeClass('btn-warning')
  $('.btn-accept').click ->
    $(this).button('loading')
    $(this).removeClass('btn-success')