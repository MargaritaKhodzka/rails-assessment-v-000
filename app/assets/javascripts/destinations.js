$(() => {
   let path = $(location).attr('href')
   $.get(path, function (data) {
     if (data.categories.length > 0) {
       let categoryList = $()
       data.categories.forEach(function (category) {
         categoryList = categoryList.add(`<li><strong><a href='/categories/${category['id']}'>${category['title']}</a></strong>
         <ul>
            <li>Climate: ${category['climate']}</li>
            <li>Must Have Item: ${category['must_have_items']}</li>
          </ul>`)
        })
        $('#categories').html(categoryList)
     } else {
       $('#categories').html('<div><h4>You do not have any categories yet.</h4></div>')
     }
  })
  $.getJSON('/destinations.json', function (data) {
    destinationValues = $.map(data, function (e) {
      return e.id
    })
  })
})
$(function () {
  $('.js-next').on('click', function () {
    let nextIndex
    let dataIdIndex = destinationValues.indexOf(parseInt($('.js-next').attr('data-id')))
    if (dataIdIndex === destinationValues.length - 1)
      nextIndex = 0
    else
      nextIndex = dataIdIndex + 1

    $.get('/destinations/' + destinationValues[nextIndex], function (data) {
      $('#name').html(`${data['name']}`)
      $('#description').html(`${data['description']}`)
      $('#country').html(`${data['country']}`)
      $('#best_season_to_visit').html(`${data['best_season_to_visit']}`)
      $('#visited').html(`${data['visited']}`)
      $('.js-next').attr('data-id', data['id'])
    })
  })
})
