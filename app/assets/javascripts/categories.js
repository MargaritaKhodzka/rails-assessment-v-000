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
  $('.js-next').on('click', function (e) {
    e.preventDefault()
    var nextId = parseInt($(".js-next").attr("data-id")) + 1
    $.get('/categories/' + nextId + ".json", function (data) {
      var category = new Category(data.id, data.title, data.climate, data.must_have_items, data.destinations)

      category.formatShow()
      $(".js-next").attr("data-id", category.id)
      // $('.destinations').append(`<li><a href="#">Destination 1</a></li>`)
      // $('.destinations').append(`<li><a href="#">Destination 2</a></li>`)
      $('.destinations').html('')
      let destinations = []
      for(let i = 0; i <= category.length - 1; i++) {
      destinations.append(`<li>${data[i].destinations}<li>`)
      }
    })
  })
})

function Category (id, title, climate, must_have_items, destinations) {
  this.id = id
  this.title = title
  this.climate = climate
  this.must_have_items = must_have_items
  this.destinations = destinations
}

Category.prototype.formatShow = function() {
  $('.title').text(`${this.title} category`)
  $('.climate').text(`Climate: ${this.climate}`)
  $('.must_have_items').text(`Must Have Items: ${this.must_have_items}`)
}
