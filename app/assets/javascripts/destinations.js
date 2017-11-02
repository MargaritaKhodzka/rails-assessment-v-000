$('form').submit(function (e) {
  e.preventDefault()
  var values = $(this).serialize()
  var posting = $.post('/destinations', values)
  posting.done(function (data) {
    $('#name').text(`${data['name']}`)
    $('#description').text(`Description: ${data['description']}`)
    $('#country').text(`Country: ${data['country']}`)
    $('#best_season_to_visit').text(`Best season to visit: ${data['best_season_to_visit']}`)
    $('#visited').text(`${data['visited']}`)
  })
})

$(".js-next").on("click", function (e) {
  e.preventDefault()
  var nextId = parseInt($(".js-next").attr("data-id")) + 1
  $.get('/destinations/' + nextId + ".json", function (data) {
    var destination = new Destination(data.id, data.name, data.description, data.country, data.best_season_to_visit, data.visited, data.categories)
    destination.formatShow()
    $('.categories').html('')

    // re-set the id to current on the link
    $(".js-next").attr("data-id", destination.id)
    let categoryList = $()
    data.categories.forEach(function (category) {
      categoryList = categoryList.add(`<li><a href='/categories/${category['id']}'>${category['title']}</a>
      <ul>
        <li>Climate: ${category['climate']}</li>
        <li>Must Have: ${category['must_have_items']}</li>
      </ul>`)
    })
    $('#categories').html(categoryList)
  })
})


function Destination (id, name, description, country, best_season_to_visit, visited, categories) {
  this.id = id
  this.name = name
  this.description = description
  this.country = country
  this.best_season_to_visit = best_season_to_visit
  this.visited = visited
  this.categories = categories
}

Destination.prototype.formatShow = function() {
  $('.name').text(`${this.name}`)
  $('.description').text(`Description: ${this.description}`)
  $('.country').text(`Country: ${this.country}`)
  $('.best_season_to_visit').text(`Best season to visit: ${this.best_season_to_visit}`)
  $('.visited').text(`${this.visited}`)
  $(".add-category").html(`<a href="/destinations/${this.id}/categories/new">Add a new category to this destination</a>`)
  $('.edit-link').html(`<a href="/destinations/${this.id}/edit">Edit</a>`)
  $('.delete-link').html(`<a href="/destinations/${this.id}/destroy">Delete</a>`)
}
