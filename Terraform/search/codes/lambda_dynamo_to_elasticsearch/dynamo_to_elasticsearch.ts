import {SerieAMatch} from "./serie_a_match";
import { Client } from '@elastic/elasticsearch'

import {StreamRecord} from "aws-sdk/clients/dynamodbstreams";

const host = process.env.HOST || "http://localhost:9200";
const index = process.env.INDEX;
const type = process.env.TYPE;

exports.handler = async (event:StreamRecord, context) => {
    // const event = {
    //     "ApproximateCreationDateTime":1556879386,
    //     "Keys":{"deviceUuid":{"S":"sdf"}},
    //     "NewImage":{
    //         "id": {"S":"sdf"},
    //         "home":{"S":"Richard"},
    //         "away":{"S":"Richard"},
    //         "date":{"S":"Richard"},
    //         "half_time":{"S":"Richard"},
    //         "final_score":{"S":"Richard"},
    //         "season":{"S":"Richard"},
    //     },
    //     "SequenceNumber":"1700000000005499036173",
    //     "SizeBytes":50,
    //     "StreamViewType":"NEW_AND_OLD_IMAGES"
    // };

    let request_event = JSON.stringify(event, null, 2);
    console.log('Received event:', request_event);

    const new_seriea_match:SerieAMatch = new SerieAMatch({id: event.NewImage.id, home: event.NewImage.home,
        away: event.NewImage.away, date: event.NewImage.date, half_time: event.NewImage.half_time,
        final_score: event.NewImage.final_score, season: event.NewImage.season});

    const client = new Client({node: host});
    client.index({
            index,
            type,
            body: {
                home: new_seriea_match.home,
                away: new_seriea_match.away,
                date: new_seriea_match.date,
                half_time: new_seriea_match.half_time,
                final_score: new_seriea_match.final_score,
                season: new_seriea_match.season
            },
            refresh: 'true'
        },
        (e, r) => console.log('Event Recorded: ', request_event)
    );
    // console.log('Received event:', JSON.stringify(event, null, 2));
    // event.Records.forEach((record) => {
    //     console.log(record.eventID);
    //     console.log(record.eventName);
    //     console.log('DynamoDB Record: %j', record.dynamodb);
    // });
    // return `Successfully processed ${event.Records.length} records.`;
};
