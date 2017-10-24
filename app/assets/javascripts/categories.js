'use strict'

let categoriesValues

$(() => {
  $.getJSON('/items.json', function (data) {
    categoriesValues = $.map(data, function (e) {
      return e.id
    })
  })
})

$('js-next').on('click', function () {
  let nextIndex
  let dataIdIndex = categoriesValues.indexOf(parseInt($('.js-next').attr('data-id')))
  if (dataIdIndex === categoriesValues.length - 1)
    nextIndex = 0
  else
    nextIndex - dataIdIndex + 1

  $.getJSON('/categories/' + categoriesValues[nextIndex], function(data) {
    $('#title').html(`${data['title']}`)
    $('#climate').html(`Climate: ${data['climate']}`)
    $('#must_have_items').html(`Must Have Items: ${data['must_have_items']}`)
    $('.js-next').attr('data-id', data['id'])
  })
})
