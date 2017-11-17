/*
  1. Know how to use "this" and scope it and bind it to other functions
*/

(function(){
  $(document).on('click', ".js-more", function() {
    var button = this;
    var id = $(button).data("id")

    $.get(`/destinations/${id}.json`, function(destination) {
      $(`#destination-${id}`).html(`<p>${destination.description}</p>`)

      // remove the see more button from the dom after appendin the destinations html
      button.remove()
    })
  })
})()

$("#categories").on("load", function() {
  // var destinationId = parseInt($("#categories").attr("data-id"))
  // $.get(`/destinations/${destination.id}/categories`, function (categories) {
  //   var renderedCategories = formatCategory(categories)
  //   $("#categories").html(renderedCategories)
  // })
//or
  // make request to (`/destinations/${destination.id}/categories`)
  // let catList = $()
  // data.categories.forEach(function(category) {
  //   catList = catList.add(formatCategory(category))
  // })
  // $(#categories).add(catList)
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
    data.categories.forEach(function (category) {
      categoryList = categoryList.add(formatCategory(category))
    })
    $('#categories').html(categoryList)
  })
})

$(function() {
  $("form#new_category").on('submit', function (e) {
    e.preventDefault()
     e.stopPropagation()
     console.log('submitting')
    $.ajax({
      type: ($("input[name='_method']").val() || this.method),
      url: this.action,
      data: $(this).serialize(),
      success: function (response) {
        $("#category_title").val("")
        $("#category_climate").val("")
        $("#category_must_have_items").val("")
        $("div#categories").append(formatCategory(response))
      }
    })
  })
})

function formatCategory(response) {

  return `<li><a href='/categories/${response['id']}'>${response['title']}</a></li>
    <ul>
      <li>Climate: ${response['climate']}</li>
      <li>Must Have: ${response['must_have_items']}</li>
    </ul>`
}

// constructor
function Destination (id, name, description, country, best_season_to_visit, visited, categories) {
  this.id = id
  this.name = name
  this.description = description
  this.country = country
  this.best_season_to_visit = best_season_to_visit
  this.visited = visited
  this.categories = categories
}

// prototype
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
