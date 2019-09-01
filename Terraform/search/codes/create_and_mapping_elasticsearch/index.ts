import { Client } from '@elastic/elasticsearch'

class CreateAndMappingElasticSearch {
    readonly client: Client;

    constructor(host) {
        this.client = new Client({node: host})
    }

    async delete(index: string) {
        console.log(`Removing index ${index}`);
        try {
            const response = await this.client.indices.delete({index});
            console.log(response)
            console.log(`Removed index ${index}`);
        } catch(err) {
            console.log(err.message)
        }
    }

    async create(index: string) {
        console.log(`Creating index ${index}`);
        try {
            const response = await this.client.indices.create({ index });
            console.log(response);
            console.log(`Created index ${index}`);
        } catch(err) {
            console.error(`Error on creating index ${index}`, err);
        }
    }

    async mapping(index: string, type: string, schema: object) {
        console.log(`Mapping Index[${index}] Type[${type}]`)
        try {
            // Remove Deprecation warning
            const response = await this.client.indices.putMapping({ index, type, body: { properties: schema }})
            console.log(response)
            console.log(`Mapped Index[${index}] Type[${type}]`)
        } catch(err) {
            console.error(JSON.stringify(err.meta.body))
        }
    }
}

const host = process.env.HOST || "http://localhost:9200";
const index = process.env.INDEX;
const type = process.env.TYPE;

if(!type || !index) {
    throw new Error("No index or type");
}

const schema =  {
    match_date: { type: 'date', fields: { type: "keyword" } },
    home: { type: 'text', fields: { type: "keyword" } },
    away: { type: 'text', fields: { type: "keyword" } },
    score_first_half: { type: 'text', fields: { type: "keyword" } },
    final_score: { type: 'text', fields: { type: "keyword" } },
    season: { type: 'text', fields: { type: "keyword" } }
};
const params = JSON.stringify({ host, index, type });
console.log(`Params: ${params}`);

const cmes = new CreateAndMappingElasticSearch(host);
cmes.delete(index)
    .then(() => cmes.create(index))
    .then(() => cmes.mapping(index, type, schema));

