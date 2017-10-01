var express = require('express')
var path = require("path")
var app = express()
var ip = require('ip')
var os = require('os')

app.use(function (req, res, next) {
    var filename = path.basename(req.url)
    var extension = path.extname(filename)

    if (extension === '.txt' || extension === '.jpg')
        console.log("The file " + filename + " was requested.")
    
    next()
})

app.use(express.static('public'))

app.get('/', function (req, res) {
	console.log('Receiving request: GET /')
	let headers = `Provider: ${req.get('Provider')}\n \
					X-Forwarded-Proto: ${req.get('X-Forwarded-Proto')} \
					X-Real-IP: ${req.get('X-Real-IP')}\
					HOST: ${req.get('HOST')}\
					X-Forwarded-For: ${req.get('X-Forwarded-For')}\
					`
    res.send(`\nHeaders: ${headers}\n`)
})

app.get('/server/url', function (req, res) {
	console.log(`server/url no cache`)
    res.send(req.url)
})

app.get('/server/ipaddress', function (req, res) {
    res.send(ip.address())
})

app.get('/server/hostname', function (req, res) {
    res.send(os.hostname())
})

app.listen(8080, function () {
    console.log('Simple Node.js REST API listening on port 8080!')
})