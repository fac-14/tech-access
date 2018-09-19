
document.getElementById("submit-me").addEventListener("submit", function(e){
    e.preventDefault()
    createQuery();
})

function createQuery() {

    var resourceName = document.getElementById("name").value;
    var url = document.getElementById("url").value;
    var resourceDesc = document.getElementById("description").value;
    var resourceType = document.getElementById("type").value;
    var country = document.getElementById("country").value;
    var city = document.getElementById("city").value;;

    var sqlQuery = `with insert1 as (insert into resource (resource_name, url, resource_description, resource_type, country, city) values ('${resourceName}', '${url}', '${resourceDesc}', '${resourceType}', '${country}', '${city}') returning resource_id) insert into demographic_resource_link (link_resource_id, link_demographic_tag_id, relevance) values `

    var tags = []

    document.getElementById("directly-relevant").childNodes.forEach(i => {
        if(i.checked === true){
            tags.push({[i.name]:"direct"})
        }
    })

    document.getElementById("indirectly-relevant").childNodes.forEach(i => {
        if(i.checked === true){
            tags.push({[i.name]:"indirect"})
        }
    })



    tags.forEach(i => {
    sqlQuery += "((select * from insert1), (select demographic_tag_id from demographic_tag where tag_name='" + Object.keys(i)[0] + "'), '" + Object.values(i)[0] + "'), "
    })

    var newest = sqlQuery.slice(0, sqlQuery.length -2).replace(/'NULL'/g, "NULL") + ";"

    console.log(newest)

    document.getElementById("query-goes-here").textContent = newest;
}


