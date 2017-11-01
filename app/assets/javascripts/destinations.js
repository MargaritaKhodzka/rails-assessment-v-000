$(function() {
  bindClickHandlers()
})

const bindClickHandlers = () => {
  $('.all_destinations').on('click', (e) => {
    e.preventDefault()
    history.pushState(null, null, "destinations")
    fetch('/destinations.json')
    .then(res => res.json())
    .then(data => {
      $('#app-container').html('')
      data.data.forEach( destination => {
        let newDestination = new Destination(destination)
        let postHtml = newDestination.formatIndex()
        $('#app-container').append(postHtml)
      })
    })
  })

  $(document).on('click', ".show_link", function(e) {
    e.preventDefault()
    $('#app-container').html('')
    let id = $(this).attr('data-id')
    fetch(`/destinations/${id}.json`)
    .then(res => res.json())
    .then(data => {
      console.log(data)
      let newDestination = new Destination(data.data)
      let postHtml = newDestination.formatShow()
      $('#app-container').append(postHtml)
    })
  })

  $(document).on("click", ".next-destination", function() {
    let id = $(this).attr('data-id')
    fetch(`destinations/${id}/next`)

  })
}

//constructor function
function Destination(destination) {
  this.id = destination.id
  this.name = destination.attributes.name
  this.description = destination.attributes.description
  this.country = destination.attributes.country
  this.best_season_to_visit = destination.attributes.best_season_to_visit
  this.categories = destination.attributes.categories
}

Destination.prototype.formatIndex = function(){
  let postHtml = `
    <a href="/destinations/${this.id}" data-id="${this.id}" class="show_link"><h1>${this.name}</a>
    <h4>${this.description}</h4>
    `
  return postHtml
}

Destination.prototype.formatShow = function(){
  console.log(this)
  let postHtml = `
    <h1>${this.name}</h1>
    <h4>Categories: </h4></br>
    <h4>${this.categories.map(function(element){
      return `${element.title}</br>` }).join('') }
    </h4>`
  return postHtml
}
