"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
exports.__esModule = true;
var elasticsearch_1 = require("@elastic/elasticsearch");
var CreateAndMappingElasticSearch = /** @class */ (function () {
    function CreateAndMappingElasticSearch(_a) {
        var protocol = _a.protocol, host = _a.host, port = _a.port;
        var node = protocol + "://" + host + ":" + port;
        this.client = new elasticsearch_1.Client({ node: node });
    }
    CreateAndMappingElasticSearch.prototype["delete"] = function (index) {
        return __awaiter(this, void 0, void 0, function () {
            var response, err_1;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        console.log("Removing index " + index);
                        _a.label = 1;
                    case 1:
                        _a.trys.push([1, 3, , 4]);
                        return [4 /*yield*/, this.client.indices["delete"]({ index: index })];
                    case 2:
                        response = _a.sent();
                        console.log(response);
                        console.log("Removed index " + index);
                        return [3 /*break*/, 4];
                    case 3:
                        err_1 = _a.sent();
                        console.log(err_1.message);
                        return [3 /*break*/, 4];
                    case 4: return [2 /*return*/];
                }
            });
        });
    };
    CreateAndMappingElasticSearch.prototype.create = function (index) {
        return __awaiter(this, void 0, void 0, function () {
            var response, err_2;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        console.log("Creating index " + index);
                        _a.label = 1;
                    case 1:
                        _a.trys.push([1, 3, , 4]);
                        return [4 /*yield*/, this.client.indices.create({ index: index })];
                    case 2:
                        response = _a.sent();
                        console.log(response);
                        console.log("Created index " + index);
                        return [3 /*break*/, 4];
                    case 3:
                        err_2 = _a.sent();
                        console.error("Error on creating index " + index, err_2);
                        return [3 /*break*/, 4];
                    case 4: return [2 /*return*/];
                }
            });
        });
    };
    CreateAndMappingElasticSearch.prototype.mapping = function (index, type, schema) {
        return __awaiter(this, void 0, void 0, function () {
            var response, err_3;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        console.log("Mapping Index[" + index + "] Type[" + type + "]");
                        _a.label = 1;
                    case 1:
                        _a.trys.push([1, 3, , 4]);
                        return [4 /*yield*/, this.client.indices.putMapping({ index: index, type: type, body: { properties: schema }, include_type_name: true })];
                    case 2:
                        response = _a.sent();
                        console.log(response);
                        console.log("Mapped Index[" + index + "] Type[" + type + "]");
                        return [3 /*break*/, 4];
                    case 3:
                        err_3 = _a.sent();
                        console.error(JSON.stringify(err_3.meta.body));
                        return [3 /*break*/, 4];
                    case 4: return [2 /*return*/];
                }
            });
        });
    };
    return CreateAndMappingElasticSearch;
}());
var protocol = process.env.PROTOCOL || "http";
var host = process.env.HOST || "localhost";
var port = process.env.PORT || "9200";
var index = process.env.INDEX;
var type = process.env.TYPE;
if (!type || !index) {
    throw new Error("No index or type");
}
var schema = {
    match_date: { type: 'date' },
    home: { type: 'text' },
    away: { type: 'text' },
    score_first_half: { type: 'text' },
    final_score: { type: 'text' }
};
var params = JSON.stringify({ protocol: protocol, host: host, port: port, index: index, type: type });
console.log("Params: " + params);
var cmes = new CreateAndMappingElasticSearch({ protocol: protocol, host: host, port: port });
cmes["delete"](index)
    .then(function () { return cmes.create(index); })
    .then(function () { return cmes.mapping(index, type, schema); });
