//1. Know how to use "this" and scope it and bind it to other functions

$(window).load(function() {
  bindEventListeners()
})

function bindEventListeners() {
  $("#button").on('click', function() {
    var destinationId = parseInt($(".js-next").attr("data-id"))
    $.get(`/destinations/${destinationId}/categories.json`, function(categories) {
        $("div#categories")
        var categoryList = categories.map(category => formatCategory(category)).join()
        $("div#categories").append(categoryList)
    })
  })

  $(document).on('click', '.js-more', function() {
    var button = this
    var id = $(button).data("id")
    $.get(`/destinations/${id}.json`, function(destination) {
      $(`#destination-${id}`).html(`<p>${destination.description}</p>`)
      // remove the see more button from the dom after appendin the destinations html
      button.remove()
    })
  })

  $(".js-next").on("click", function (e) {
    e.preventDefault()
    var id = parseInt($(".js-next").attr("data-id"))
    $.get(`/destinations/${id}/next.json`, function (data) {
      destination = new Destination(data.id, data.name, data.description, data.country, data.best_season_to_visit, data.visited, data.categories)
      destination.formatShow()
      $(".js-next").attr("data-id", destination.id)
      $('#categories').html('')
      $("#new_category").attr("action", `/destinations/${destination.id}/categories`)
      let categoryList = $()
      data.categories.forEach(function(category) {
        categoryList = categoryList.add(formatCategory(category))
        $("#categories").html(categoryList)
      })
    })
  })

  $("#new_category").on('submit', function (e) {
    e.preventDefault()
    $.ajax({
      type: 'POST',
      url: this.action,
      data: $(this).serialize(),
      success: function (response) {
        $("div#categories").append(formatCategory(response))
      }
    })
    $('#new_category').trigger("reset")
  })
}

function formatCategory(response) {
  return `
    <li><a href='/categories/${response['id']}'>${response['title']}</a></li>
    <ul>
      <li>Climate: ${response['climate']}</li>
      <li>Must Have: ${response['must_have_items']}</li>
    </ul>
    `
}

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
  $('.visited').html(`${this.visited ? '<p><b>You visited this destination!</b></p>' : '<p><b>You have not visited this destination yet.</b></p>'}`)
  $('.categories').text(`${this.categories}`)
  $('.edit-link').html(`<a href="/destinations/${this.id}/edit">Edit</a>`)
  $('.delete-link').html(`<a href="/destinations/${this.id}/destroy">Delete</a>`)
}
