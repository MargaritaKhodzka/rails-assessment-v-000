'use strict'

$(() => {
  $.getJSON('/categories.json', function (data) {
    let categoriesValues = $.map(data, function (e) {
      return e.id
    })
  })
  $('form').submit(function (e) {
    e.preventDefault()
    let values = $(this).serialize()
    let posting = $.post('/categories', values)
    posting.done(function (data) {
      $('#title').html(`${data['title']}`)
      $('#climate').html(`Rating: ${data['climate']}`)
      $('#must_have_items').html(`Notes: ${data['must_have_items']}`)
    })
  })
})

$('.js-next').on('click', function () {
  let nextIndex
  let dataIdIndex = categoriesValues.indexOf(parseInt($('.js-next').attr('data-id')))
  if (dataIdIndex === categoriesValues.length - 1)
    nextIndex = 0
  else
    nextIndex = dataIdIndex + 1
  $.getJSON('/categories/' + categoriesValues[nextIndex], function (data) {
    $('#title').html(`${data['title']}`)
    $('#climate').html(`Rating: ${data['climate']}`)
    $('#must_have_items').html(`Notes: ${data['must_have_items']}`)
  })
})
