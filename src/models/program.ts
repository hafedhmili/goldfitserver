export class Exercise {
    name : string;
    description: String;
    numberRepetitions: Interval;
    url: URL;

    constructor(n:string,d:string,nR:Interval, ur: URL){
        this.name = n;
        this.description = d;
        this.numberRepetitions = nR;
        this.url = ur;
    }
};


export class ExerciseSeries {
    name: string;
    description: string;
    exercices: Map<Exercise,Interval>;
    exerciseOrders: Map<number,Exercise>;
    constructor(n: string, d: string) {
        this.name = n;
        this.description = d;
        this.exercices = new Map<Exercise,Interval>();
        this.exerciseOrders = new Map<number,Exercise>();
    }

    addExercice(ex: Exercise, interv: Interval, position: number){
        this.exercices.set(ex,interv);
        this.exerciseOrders.set(position,ex);
    }

    getExerciseAtPosition(position: number)  {
        return this.exerciseOrders.get(position)
    }

    getNumberSeriesForExercise(ex: Exercise){
        return this.exercices.get(ex)
    }

    getNumberSeriesForExerciseNumber(num: number){
        const ex = this.getExerciseAtPosition(num);
        if (ex) return this.exercices.get(ex);
        return undefined
    }

    getNumberOfExercices() {
        return this.exercices.size
    }
};

export class Interval  {
    min: number;
    max : number;

    constructor(mi:number,ma:number){
        this.min = mi;
        this.max = ma;
    }
};

export class Program  {
    name: String;
    description: String;
    duration: number;
    mapExerciseSeries: Map<Interval,ExerciseSeries>;

    constructor(n:String, des: string, d: number) {
        this.name = n;
        this.description = des;
        this.duration = d;
        this.mapExerciseSeries = new Map<Interval,ExerciseSeries>();
    }

 
    addExerciseSeries (itr: Interval,exSeries: ExerciseSeries) {
        this.mapExerciseSeries.set(itr,exSeries);
    }

    getExerciseSeriesForDay (day: number){
        if ((day <1) || (day > this.duration)) {
            console.log('No exercise series for day: ',day, '. Program is only ',this.duration, ' days long.');
            return null;
        }
        const keys = Array.from (this.mapExerciseSeries.keys());
        const l = keys.length;
    
        for (var i = 0; i < l; i++) {
            let interval = keys[i];
            if ((day >=interval.min) && (day <= interval.max)) return this.mapExerciseSeries.get(interval);
        };
        return null;
    };

    getNumberOfSegments() {
        return this.mapExerciseSeries.size
    }

    getInterval(rank: number) {
        const keys = Array.from (this.mapExerciseSeries.keys());
        keys.sort(function(inta,intb) {return inta.min - intb.min})
        return keys[rank-1]
    }

    stringify () {
        var stringProgSequences = '{' + this.mapExerciseSeries +'}';
    //    this.mapExerciseSeries.forEach((element)=> {
    //        stringProgSequences = stringProgSequences+ element.key + '->' + element.value +','
    //    })
    //    stringProgSequences = stringProgSequences.replace(/.$/,'}')

        var globalString = '{'+ '"name" : "'+this.name + '";' +
        '"description" : "'+this.description + '";' +
        '"duration" : "'+this.duration + '";' +
        '"mapExerciseSeries" : "'+stringProgSequences + '}'

        return globalString;
    }


};