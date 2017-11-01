$(function(){
  $('.button_to').on('click', function(e) {
    e.preventDefault()
    $.ajax({
      url: this.action,
      method: 'DELETE',
    success: function(response) {
      console.log('delete successful', response)
      $(`div#${e.target.id}`).remove()
      }
    })
  })
})

$(function(){
$('.new_note').on('submit', function(e) {
  e.preventDefault()
  url = this.action
  console.log(url)
  $.ajax({
    type: 'POST',
    url: url,
    data: {'note[content]': $('#note_content').val(),
          },
    success: function(response) {
      $('.notes-content ol').append(response)
      }
  })
  $('.new_note').trigger("reset")
})
})
