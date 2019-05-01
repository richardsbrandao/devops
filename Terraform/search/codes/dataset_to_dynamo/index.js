"use strict";
exports.__esModule = true;
// var walk = require('walk');
var walk = require("walk");
var Papa = require("papaparse");
var fs = require('fs');
var path = require('path');
var SerieAMatch = /** @class */ (function () {
    function SerieAMatch(_a) {
        var home = _a.home, away = _a.away, date = _a.date, half_time = _a.half_time, final_score = _a.final_score, season = _a.season;
        this.home = this.format(home);
        this.away = this.format(away);
        this.date = new Date(date);
        this.half_time = half_time;
        this.final_score = final_score;
        this.season = season;
    }
    SerieAMatch.prototype.format = function (text) {
        return text.replace(/ (\([0-9]+\))/g, '');
    };
    return SerieAMatch;
}());
var SerieAMatches = /** @class */ (function () {
    function SerieAMatches() {
        this.matches = [];
    }
    SerieAMatches.prototype.add = function (serieAMatch) {
        this.matches.push(serieAMatch);
    };
    return SerieAMatches;
}());
var serieAMatches = new SerieAMatches();
var walker = walk.walk('../../dataset/it-italy-master', { followLinks: false });
walker.on('file', function (root, stat, next) {
    if (stat.name.includes("1-seriea.csv")) {
        var filename_1 = root + '/' + stat.name;
        var file = fs.createReadStream(filename_1);
        Papa.parse(file, {
            worker: true,
            header: true,
            step: function (result) {
                var match = result.data[0];
                var season = path.dirname(filename_1).split('/').pop();
                var serieAMatch = new SerieAMatch({ home: match['Team 1'], away: match['Team 2'], date: match['Date'],
                    final_score: match['FT'], half_time: match['HT'], season: season });
                serieAMatches.add(serieAMatch);
            }
        });
    }
    next();
});
walker.on('end', function () {
    for (var i in serieAMatches.matches) {
        console.log(typeof (serieAMatches.matches[i].date));
        console.log(serieAMatches.matches[i]);
    }
});
//parse in classes
//send to dynamo
// var walk    = require('walk');
// var files   = [];
//
// // Walker options
// var walker  = walk.walk('./test', { followLinks: false });
//
// walker.on('file', function(root, stat, next) {
//     // Add this file to the list of files
//     files.push(root + '/' + stat.name);
//     next();
// });
//
// walker.on('end', function() {
//     console.log(files);
// });
//https://www.papaparse.com/
