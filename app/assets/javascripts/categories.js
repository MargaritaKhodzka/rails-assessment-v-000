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
//
// function Category (id, title, climate, must_have_items, destinations) {
//   this.id = id
//   this.title = title
//   this.climate = climate
//   this.must_have_items = must_have_items
//   this.destinations = destinations
// }
//
// Category.prototype.formatShow = function() {
//   $('.title').text(`${this.title} category`)
//   $('.climate').text(`<b>Climate:</b> ${this.climate}`)
//   $('.must_have_items').text(`<b>Must Have:</b> ${this.must_have_items}`)
//   $(".edit-link").html(`<a href="/categories/${this.id}/edit">Edit</a>`)
//   $(".delete-link").html(`<a href="/categories/${this.id}/destroy">Delete</a>`)
// }
