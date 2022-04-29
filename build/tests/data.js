"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const program_1 = require("../models/program");
// Function creates a couple of programs
function createSomeData() {
    console.log('inside create some data');
    var ex1 = new program_1.Exercise('sit-ups', 'situps', { min: 20, max: 30 }, new URL('https://youtu.be/ojByzJhwVFE'));
    console.log('ex1', ex1);
    var ex2 = new program_1.Exercise('Lie down', 'not as easy as it seems', { min: 40, max: 50 }, new URL('https://youtu.be/ojByzJhwVFE'));
    var ex3 = new program_1.Exercise('Sleeping', 'do not laugh', { min: 50, max: 60 }, new URL('https://youtu.be/ojByzJhwVFE'));
    const eSeries1 = new program_1.ExerciseSeries('Ex12', 'Exercises 1 and 2');
    eSeries1.addExercice(ex1, { min: 2, max: 3 }, 1);
    eSeries1.addExercice(ex2, { min: 3, max: 4 }, 2);
    const eSeries2 = new program_1.ExerciseSeries('Ex13', 'Exercises 1 and 3');
    eSeries2.addExercice(ex1, { min: 2, max: 4 }, 1);
    eSeries2.addExercice(ex3, { min: 2, max: 5 }, 2);
    const eSeries3 = new program_1.ExerciseSeries('Ex123', 'Exercises 1, 2 and 3');
    eSeries3.addExercice(ex1, { min: 2, max: 4 }, 1);
    eSeries3.addExercice(ex2, { min: 4, max: 5 }, 2);
    eSeries3.addExercice(ex3, { min: 3, max: 4 }, 3);
    // two programs
    // program1: the same exercise series every day
    const program1 = new program_1.Program('PACE', 'This is the pace program', 60);
    program1.addExerciseSeries(new program_1.Interval(1, 60), eSeries3);
    console.log(program1);
    // program2: each 20 days of the program have their own exercice series
    const program2 = new program_1.Program('PATH', 'This is the path program', 60);
    program2.addExerciseSeries(new program_1.Interval(1, 20), eSeries1);
    program2.addExerciseSeries(new program_1.Interval(21, 40), eSeries2);
    program2.addExerciseSeries(new program_1.Interval(41, 60), eSeries3);
    // create a patient
    const patient = new program_1.Patient("Hafedh", "Mili", 1);
    // create a programe enrollment. Enrollment date is April 1rst, start date is April 4
    const progEnrollment = new program_1.ProgramEnrollment(patient, program2, "HM-01", new Date(2022, 3, 1), new Date(2022, 3, 4));
    return [program1, program2, patient, progEnrollment];
}
function testDataAccess() {
    const data = createSomeData();
    const pg1 = data[0];
    const pg2 = data[1];
    const patient = data[2];
    const progEnrollment = data[3];
    console.log('Exercice segments for ' + pg2.name + ': ' + pg2.getNumberOfSegments());
    var day = 1;
    console.log('Exercice segment for day: ', day, ' of program ', pg2.name, ' is: ', pg2.getExerciseSeriesForDay(day));
    day = 30;
    console.log('Exercice segment for day: ', day, ' of program ', pg2.name, ' is: ', pg2.getExerciseSeriesForDay(day));
    day = 65;
    console.log('Exercice segment for day: ', day, ' of program ', pg2.name, ' is: ', pg2.getExerciseSeriesForDay(day));
    const segmentNumber = 2;
    console.log(segmentNumber + 'nd exercise series period: ' + pg2.getInterval(segmentNumber));
    // display patient
    console.log('Patient: ', JSON.stringify(patient));
    // display exercice series for a given date
    // April 10th. We should be in the first segment
    const date1 = new Date(2022, 3, 10);
    const exSeries1 = progEnrollment.getExerciseSeriesForDay(date1);
    console.log('Exercise series for date ', date1, ' is: ', exSeries1);
    // April 26th. We should be in the second segment
    const date2 = new Date(2022, 3, 26);
    const exSeries2 = progEnrollment.getExerciseSeriesForDay(date2);
    console.log('Exercise series for date ', date2, ' is: ', exSeries2);
    // Mai 15th. We should be in third exercice series
    const date3 = new Date(2022, 4, 15);
    const exSeries3 = progEnrollment.getExerciseSeriesForDay(date3);
    console.log('Exercise series for date ', date3, ' is: ', exSeries3);
    // generate exercise day record for date2. It should be an instance
    // of exercice series 2
    progEnrollment.initializeDayRecordForDay(date2);
    console.log('Day record for: ', date2, ' is:', progEnrollment.getDayRecordForDay(date2));
}
exports.default = { createSomeData: createSomeData, testDataAccess: testDataAccess };
