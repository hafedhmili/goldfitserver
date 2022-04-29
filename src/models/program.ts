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

        var globalString = '{ "name" : "'+this.name + '";"description" : "'+
        this.description + '"; "duration" : "'+this.duration + 
        '"; "mapExerciseSeries" : "'+stringProgSequences + '}'

        return globalString;
    }


};

export class Patient {
    firstName: String;
    lastName: String;
    patientId: number;
    

    constructor(fName:String, lName: string, id: number) {
        this.firstName = fName;
        this.lastName = lName;
        this.patientId = id;
    }


}

export class ExerciseRecord {
    exercise: Exercise;
    numberSeries: number;
    numberRepetitions: number;

    constructor(ex: Exercise, numSeries: number, numRepetitions: number) {
        this.exercise = ex;
        this.numberSeries = numSeries;
        this.numberRepetitions = numRepetitions;
    }

}

export enum DifficultyLevel {
    VeryVeryEasy = "Very Very Easy",
    VeryEasy = "Very Easy",
    Easy = "Easy",
    RelativelyEasy = "Relatively Easy",
    Average = "Average",
    RelativelyDifficult = "Relatively Difficult",
    Difficult = "Difficult",
    VeryDifficult = "Very Difficult",
    VeryVeryDifficult = "Very Very Difficult",
    IncrediblyDifficult = "Incredibly Difficult"
}

export enum SelfEfficacy {
    HighlyConfident = "Highly Confident",
    Confident = "Confident",
    LittleConfident = "Little Confident",
    NotConfident = "Not Confident"
}

export enum PainLevel {
    NoPain = "No Pain",
    LittlePain = "Little Pain",
    ModeratePain = "Moderate Pain",
    SeverePain = "Severe Pain"
}

export enum SatisfactionLevel {
    VerySatisfied = "Very Satisfied",
    Satisfied = "Satisfied",
    Insatisfied = "Insatisfied",
    VeryInsatisfied = "Very Insatisfied"
}

export class ProgramDayRecord {
    day: Date;
    exerciseSeries: ExerciseSeries;
    exerciceRecords : Map<Exercise,ExerciseRecord>;
    difficultyLevel: DifficultyLevel;
    selfEfficacy: SelfEfficacy;
    painLevel: PainLevel;
    satisfactionLevel: SatisfactionLevel;

    constructor(d: Date, exSeries: ExerciseSeries){
        
        this.day = d;
        this.exerciseSeries = exSeries;
        this.exerciceRecords = new Map<Exercise,ExerciseRecord>();
        this.difficultyLevel = DifficultyLevel.Average;
        this.selfEfficacy = SelfEfficacy.NotConfident;
        this.painLevel = PainLevel.NoPain;
        this.satisfactionLevel = SatisfactionLevel.Satisfied;


        if (!exSeries){
            console.log('Exercise series is undefined. Cannot define program day record. The list of exercise records is empty');
            return ;
        }

        var exRecord: ExerciseRecord ;
        const numExs = exSeries.getNumberOfExercices();
        for (var idx = 1; idx <= numExs; idx++) {
            const exercise = exSeries.getExerciseAtPosition(idx);
            if (exercise) {
                exRecord = new ExerciseRecord (exercise, 0, 0);
                this.exerciceRecords.set(exercise,exRecord)
            }

        }

    }


}
export class ProgramEnrollment {
    patient: Patient;
    program: Program;
    enrollmentCode: String;
    enrollmentDate: Date;
    startDate: Date;
    dayRecords: Map<Date,ProgramDayRecord>;

    constructor(p:Patient, prog: Program, code: String,enrDate: Date, startDate: Date){
        this.patient = p;
        this.program = prog;
        this.enrollmentCode = code;
        this.enrollmentDate = enrDate;
        this.startDate = startDate;
        this.dayRecords = new Map<Date,ProgramDayRecord>();
    }

    /**
     * A utility function that computes the number of days elapsed between
     * two dates given as an argument
     * @param d1 
     * @param d2 
     * @returns 
     */
    getNumberOfDaysBetween(d1:Date,d2:Date) {
        const days1 = Math.round(d1.getTime()/(1000*3600*24))
        const days2 = Math.round(d2.getTime()/(1000*3600*24))

        return days2 - days1
    }

    /**
     * returns the exercice series that corresponds to a particular date. This
     * depends on: 1) the (structure of the) program, and 2) the start date of
     * the program.
     * @param day 
     * @returns 
     */
    getExerciseSeriesForDay(day: Date) {
        const dayOfTheProgram = this.getNumberOfDaysBetween(this.startDate, day)+1;
        return this.program.getExerciseSeriesForDay(dayOfTheProgram);
    }

    
    /**
     * This function is used to initialize a program day record for <code>day</code>
     * based on date day, on program start date, and on program itself. 
     * Users can then edit values for series and repetitions for the exercises in the
     * series of the day.
     * @param day 
     * @returns 
     */
    initializeDayRecordForDay(day:Date){

        const exerciseSeries = this.getExerciseSeriesForDay(day);

        if(exerciseSeries) {
            const progDayRecord = new ProgramDayRecord(day,exerciseSeries);
            this.dayRecords.set(day,progDayRecord);
            return progDayRecord;
        }
        return null;
    }

    /**
     * returns the day record for a specific date
     */
    getDayRecordForDay(day:Date){
        return this.dayRecords.get(day)
    }

}