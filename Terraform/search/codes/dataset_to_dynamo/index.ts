// import fs from 'fs';

class SerieAMatch {
    readonly home:string;
    readonly away:string;
    readonly date:Date;
    readonly score_first_half:string;
    readonly final_score:string;

    constructor({home, away, date, score_final_half, final_score}) {
        this.home = home;
        this.away = away;
        this.date = date;
        this.score_first_half = score_final_half;
        this.final_score = final_score;
    }
}


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
