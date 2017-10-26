$(function () {
  $('form').submit(function (e) {
    e.preventDefault()
    var values = $(this).serialize()
    var posting = $.post('/categories', values)
    posting.done(function (data) {
      $('#title').text(`${data['title']}`)
      $('#climate').text(`Rating: ${data['climate']}`)
      $('#must_have_items').text(`Notes: ${data['must_have_items']}`)
    })
  })
})

$(function () {
  $('.js-next').on('click', function () {
    var nextId = parseInt($(".js-next").attr("data-id")) + 1
    $.get('/categories/' + nextId + ".json", function (data) {
      var category = data
      $('.title').text(`${category['title']}`)
      $('.climate').text(`${category['climate']}`)
      $('.must_have_items').text(`${category['must_have_items']}`)
      $(".js-next").attr("data-id", category["id"])
    })
  })
})
