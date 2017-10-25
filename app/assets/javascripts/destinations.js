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
       $('#categories').html('<div><h4>You do not have any categories_attributes yet.</h4></div>')
     }
  })
})
