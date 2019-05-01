export class SerieAMatch {
    readonly season: string;
    readonly home: string;
    readonly away: string;
    readonly date: Date;
    readonly half_time: string;
    readonly final_score: string;

    constructor({home, away, date, half_time, final_score, season}) {
        this.home = home;
        this.away = away;
        this.date = date;
        this.half_time = half_time;
        this.final_score = final_score;
        this.season = season;
    }
}
