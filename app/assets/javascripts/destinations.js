(function(){
  $(document).on('click', ".js-more", function() {
    var id = $(this).data("id")
    // change the URL to the new route
    $.get("/destinations/" + id + ".json", function(data) {
      var descriptionText = "<p>" + data["description"] + "</p>"
      // Replace text of destination-id div
      $("#destination-" + id).html(descriptionText)
    })
  })
})()

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
  var id = parseInt($(".js-next").attr("data-id"))
  $.get(`/destinations/${id}/next.json`, function (data) {
    destination = new Destination(data.id, data.name, data.description, data.country, data.best_season_to_visit, data.visited, data.categories)
    $('.categories').html('')
    destination.formatShow()
    $(".js-next").attr("data-id", destination.id)
    $(".new_category").attr("action", `/destinations/${destination.id}/categories`)
    let categoryList = $()
    data.categories.forEach(function (category) {
      categoryList = categoryList.add(`<li><a href='/categories/${category['id']}'>${category['title']}</a></li>
      <ul>
        <li>Climate: ${category['climate']}</li>
        <li>Must Have: ${category['must_have_items']}</li>
      </ul>`)
    })
    $('#categories').html(categoryList)
  })
})

$(function() {
  $(".new_category").on("submit", function (e) {
    e.preventDefault()
    $.ajax({
      type: ($("input[name='_method']").val() || this.method),
      url: this.action,
      data: $(this).serialize(),
      success: function (response) {
        $("#category_title").val("")
        $("#category_climate").val("")
        $("#category_must_have_items").val("")
        $("div#categories").append(response)
      }
    })
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
  $('.categories').text(`${this.categories}`)
  $('.edit-link').html(`<a href="/destinations/${this.id}/edit">Edit</a>`)
  $('.delete-link').html(`<a href="/destinations/${this.id}/destroy">Delete</a>`)
}
