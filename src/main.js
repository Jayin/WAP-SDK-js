var BASE_URL = 'http://api.wap.com:3000/api/v1'

var wa_tag = document.getElementsByTagName('script')[0]
var website_id = wa_tag.getAttribute('id')

var addEvent = function(website_id, category, action, opt_label, opt_value) {

    fetch(BASE_URL + '/website/:website_id/events'.replace(':website_id', website_id), {
            method: 'post',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                category: category,
                action: action,
                opt_label: opt_label,
                opt_value: opt_value

            })
        })
        .then(function(response) {
            return response.json()
        })
        .then(function(json) {
            if (json.msg){
                console.error(json.msg)
            }
        })
}

Object.observe(_wa, function(changes) {
    var c = changes[0]
    if (c.type == 'add') {
        var obj = _wa[_wa.length - 1]
        if(obj.type === 'event'){
            addEvent(website_id, obj.category, obj.action, obj.opt_label, obj.opt_value)
        }
    }
})