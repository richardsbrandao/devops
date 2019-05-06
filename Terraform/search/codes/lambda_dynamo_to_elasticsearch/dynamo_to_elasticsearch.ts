// import {SerieAMatch} from "./serie_a_match";
// import { Client } from '@elastic/elasticsearch'

exports.handler = async (event, context) => {
    console.log('Received event:', JSON.stringify(event, null, 2));
    event.Records.forEach((record) => {
        console.log(record.eventID);
        console.log(record.eventName);
        console.log('DynamoDB Record: %j', record.dynamodb);
    });
    return `Successfully processed ${event.Records.length} records.`;
};