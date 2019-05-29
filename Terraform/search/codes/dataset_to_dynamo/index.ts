import * as walk from 'walk'
import * as Papa from 'papaparse';
import {ReadStream} from "fs";
import { DynamoDB } from 'aws-sdk'
import * as uuid from 'uuid';
const fs = require('fs');
const path = require('path');

const region = process.env.AWS_REGION;
const tableName = process.env.DYNAMODB_TABLE;

class SerieAMatch {
    readonly id:string;
    readonly season:string;
    readonly home:string;
    readonly away:string;
    readonly date:string;
    readonly half_time:string;
    readonly final_score:string;

    constructor({home, away, date, half_time, final_score, season}) {
        this.id = uuid.v1();
        this.home = this.format(home);
        this.away = this.format(away);
        this.date = new Date(date).toString();
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
                const match: object = result.data[0];
                const season: string = path.dirname(filename).split('/').pop();
                const request = {
                    home: match['Team 1'], away: match['Team 2'], date: match['Date'],
                    final_score: match['FT'], half_time: match['HT'], season
                };
                serieAMatches.add(new SerieAMatch(request));
            }
        })
    }
    next();
});

walker.on('end', async () => {
    const dynamoDb = new DynamoDB.DocumentClient();
    const watch = new Watch(100, {start: 'Starting recording', finish: `Done!`, log: 'entries were recorded!'});
    for(let i in serieAMatches.matches) {
        const params = {
            TableName:  tableName,
            Item: serieAMatches.matches[i]
        };

        try {
            await dynamoDb.put(params).promise();
        } catch (e) {
            console.error(`Error on performing request ${params}: ${e.message}`)
        }

        watch.incrementAndLog();
    }
    watch.finish();
});

class Watch {
    times:number = 0;
    private readonly multipleBy: number;
    private readonly messages: Map<String, String>;

    constructor(multipleBy, messages) {
        this.multipleBy = multipleBy;
        this.messages = messages;
        console.log(this.messages['start']);
    }


    incrementAndLog() {
        this.times++;
        if(this.times % this.multipleBy == 0) {
            console.log(`${this.times} ${this.messages['log']}`);
        }
    }

    finish() {
        console.log(this.messages['finish'])
    }
}
