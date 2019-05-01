// var walk = require('walk');
import * as walk from 'walk'
import * as Papa from 'papaparse';
import {ReadStream} from "fs";
const fs = require('fs');
const path = require('path');

class SerieAMatch {
    readonly season:string;
    readonly home:string;
    readonly away:string;
    readonly date:Date;
    readonly half_time:string;
    readonly final_score:string;

    constructor({home, away, date, half_time, final_score, season}) {
        this.home = this.format(home);
        this.away = this.format(away);
        this.date = new Date(date);
        this.half_time = half_time;
        this.final_score = final_score;
        this.season = season;
    }

    private format(text):string {
        return text.replace(/ (\([0-9]+\))/g, '')
    }
}

class SerieAMatches {
    readonly matches: Array<SerieAMatch> = [];

    add(serieAMatch: SerieAMatch) {
        this.matches.push(serieAMatch);
    }
}


const serieAMatches = new SerieAMatches();
const walker = walk.walk('../../dataset/it-italy-master', { followLinks: false });

walker.on('file', (root:string, stat, next) => {
    if(stat.name.includes("1-seriea.csv")) {
        const filename:string = root + '/' + stat.name;
        const file:ReadStream = fs.createReadStream(filename);

        Papa.parse(file, {
            worker: true,
            header: true,
            step: function(result) {
                const match:object = result.data[0];
                const season:string = path.dirname(filename).split('/').pop();
                const serieAMatch = new SerieAMatch({home: match['Team 1'], away: match['Team 2'], date: match['Date'],
                    final_score: match['FT'], half_time: match['HT'], season});

                serieAMatches.add(serieAMatch);
            }
        })
    }
    next();
});

walker.on('end', () => {
    for(let i in serieAMatches.matches ) {

    }
});
