Shortify
=======================

Objective: 
----------

It's a small fully responsive application, which let users to shorten their long urls, one at a time.
- User can give a http or https starting url. In absense of http/s, app will append a http.
- On success user will get a message on the same page, having information on short url.
- Users can optionally provide name and location. To pick the location JQuery's Geocomplete library is being used.
- If a url has been shortened before, app will return the same url.
- On failure user will receive error message on same page.
- App will also stores short url visiting user's IP, country, city etc. via api of freegeoip.net.
- Go to '/links' to see all the short url, and '/links/:short_url/visitors' to see that link's visitors.
- To do location processing application uses Sidekiq.

API
------------------

This app also includes a small set of API's which you can see via 

```
curl -X GET -H "Content-type: application/json" -H "Accept: application/json" localhost:3000
{	"status":200,
	"routes":[
				"get /links",
				"get /links/:short_url",
				"post /links"
			]
}
```

Similarly, to view all urls

```
curl -X GET -H "Content-type: application/json" -H "Accept: application/json" localhost:3000/links

{
	"status":200,
	"link":{
		"id":25,
		"short_url":"6eed65",
		"long_url":"http://box.com",
		"creator":"sumit",
		"location":"delhi",
		"created_at":"2014-04-17T16:46:43.237Z",
		"updated_at":"2014-04-17T16:46:43.237Z"
	},
	"visitors":[
		{
			"id":4,
			"link_id":25,
			"ip":"127.0.0.1",
			"country_code":"RD",
			"country_name":"Reserved",
			"region_code":"",
			"region_name":"",
			"city":"",
			"zipcode":"",
			"latitude":"0",
			"longitude":"0",
			"created_at":"2014-04-17T20:08:36.390Z",
			"updated_at":"2014-04-17T20:08:36.390Z"
		}
	]...
}
```

Similarly, to view a short url 

```
curl -X GET -H "Content-type: application/json" -H "Accept: application/json" localhost:3000/links/6eed65

```

And to generate a new short url

```
curl -X POST -H "Content-type: application/json" -H "Accept: application/json" -D {"long_url":"twitter.com", "creator" : "Sumit", "location" : "Delhi"} localhost:3000/links

{
	"status":200,
	"link":{
		"id":28,
		"short_url":"b4b470",
		"long_url":"http://twitter.com",
		"creator":"Sumit",
		"location":"Delhi",
		"created_at":"2014-04-17T20:32:01.578Z",
		"updated_at":"2014-04-17T20:32:01.578Z"
	},
	"errors":null
}
```


TO DO
----------
- Writing all kinds of tests, functional, model, controller.
- Adding google map on visitor page of a link.

