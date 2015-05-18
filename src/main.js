var BASE_URL = 'http://localhost:3000/api/v1'

var getWebsites = function() {
    fetch(BASE_URL + '/websites')
        .then(function(response) {
            return response.json()
        })
        .then(function(json) {
            console.log(json)
        })
}


getWebsites()

console.log('it work!')