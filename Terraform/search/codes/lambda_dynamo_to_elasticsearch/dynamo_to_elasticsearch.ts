import {SerieAMatch} from "./serie_a_match";
import { Client } from '@elastic/elasticsearch'

exports.handler = function (event, context, callback) {
    // new Client({})
    context.succeed('hello world ');
};
