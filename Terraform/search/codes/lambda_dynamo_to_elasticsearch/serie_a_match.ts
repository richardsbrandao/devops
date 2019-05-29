export class SerieAMatch {
    readonly id: string;
    readonly season: string;
    readonly home: string;
    readonly away: string;
    readonly date: Date;
    readonly half_time: string;
    readonly final_score: string;

    constructor({id, home, away, date, half_time, final_score, season}) {
        this.id = id;
        this.home = home;
        this.away = away;
        this.date = date;
        this.half_time = half_time;
        this.final_score = final_score;
        this.season = season;
    }
}
