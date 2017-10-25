'use strict'

$(() => {
  let path = $(location).attr('href')
  $.getJSON(path, function (data) {
    if (data.categories.length > 0) {
      let categoryList = $()
      data.categories.forEach(function (category) {
        categoryList = categoryList.add
        (`<li><strong><a href='/categories/${category['id']}'>${category['title']}</a></strong></li>
          <ul>
            <li>Climate: ${category['climate']}</li>
            <li>Must have items: ${category['must_have_items']}</li>
          </ul>`)
      })
      $('#categories').html(categoryList)
    } else {
      $('#categories').html('<div><p>You do not have any categories yet.</p></div>')
    }
  })
})
