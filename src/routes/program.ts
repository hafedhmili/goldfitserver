import  {Exercise, Patient} from '../models/program';
import  {Interval} from '../models/program';
import  {ExerciseSeries} from '../models/program';
import  {Program} from '../models/program';
import { ProgramEnrollment } from '../models/program';
import { ProgramDayRecord} from '../models/program';
import { ExerciseRecord } from '../models/program';


import { Client } from 'pg';

const Router = require('express');
var router = Router();

async function findProgramDetailsWithName(programName: string, response:any) {
  var res: any;

  const client = new Client({
    connectionString: process.env.DATABASE_URL,
    ssl:
      {rejectUnauthorized: false } // use this when connecting to cloud based database. Else, set ssl: to false
  });

  client.connect();

  var selectClause = "SELECT * ",
      fromClause =  "FROM goldfit.Program, goldfit.ProgramExerciceSeries, goldfit.ExerciceSeries, goldfit.ExerciceSeriesExercice, goldfit.Exercice ",
      whereCLAUSE = "WHERE goldfit.Program.ProgramName = \'" + programName + "\' AND "+
      "goldfit.Program.idProgram = goldfit.ProgramExerciceSeries.ProgramId AND "+   // join Program with ProgramExerciceSeries
      "goldfit.ProgramExerciceSeries.ExerciceSeriesId = goldfit.ExerciceSeries.idExerciceSeries AND " +   // join ProgramExerciceSeries with ExerciceSeries
      "goldfit.ExerciceSeries.idExerciceSeries = goldfit.ExerciceSeriesExercice.ExerciceSeriesId AND " +   // join ExerciceSeries with ExerciceSeriesExerice
      "goldfit.ExerciceSeriesExercice.ExerciceId = goldfit.Exercice.idExercice";    // join ExerciceSeriesExerice with Exercice
  var programQuery = selectClause + fromClause + whereCLAUSE;  

    client.query(programQuery, async function (err:any, result:any) {
      if (err) throw err;
      if ((!result) || (result.length ==0)){
        response.status(404).send('Did not find program with name: '+ programName)
        return
      }
      console.log('Found a program with name: ' + programName + ', which is: ',result);
      response.set('Access-Control-Allow-Origin', '*');
      response.status(201).send(result.rows)
    });
    

  }

/*
* this function takes the result of q query and stringifies it 
*/
function stringifyArrayRowDataPackets(rows: any) {
  return Object.values(JSON.parse(JSON.stringify(rows)))
}
/*
* This function take an enrollment code for a patient and sends back basic information
* about the program in which they are enrolled. If nothing is found, it sends back
* an error message
*/
async function findProgramHeaderForEnrollmentCode(enrollmentCode: string, response:any) {
  var res: any;

  console.log("Inside findProgramHeaderForEnrollmentCode, process.env.DATABASE_URL has value: ", process.env.DATABASE_URL,
  "and process.env.PORT has value: ", process.env.PORT)

  const client = new Client({
    connectionString: process.env.DATABASE_URL,
    ssl: 
      // false
       {rejectUnauthorized: false } // use this when connecting to cloud based database. Else, set ssl: to false
  });

  client.connect();


  var selectClause = "SELECT PatientFirstName, PatientLastName, idPatient, ProgramName, idProgramEnrollment, idProgram,ProgramDuration, ProgramDescription, ProgramEnrollmentDate, ProgramStartDate ",
      fromClause =  "FROM goldfit.ProgramEnrollment, goldfit.Program, goldfit.Patient ",
      whereCLAUSE = "WHERE goldfit.ProgramEnrollment.ProgramId = goldfit.Program.idProgram AND "+
      "goldfit.ProgramEnrollment.PatientID = goldfit.Patient.idPatient AND " +
      "goldfit.ProgramEnrollment.ProgramEnrollmentCode = \'" + enrollmentCode + "\'";
  var programQuery = selectClause + fromClause + whereCLAUSE;  

  client.query(programQuery, async function (err:any, result:any) {
      if (err) throw err;
      if ((!result) || (result.length ==0)){
        response.status(404).send('Did not find program for enrollmernt code: '+ enrollmentCode)
        return
      }
      
      console.log('[DEBUG] Found an enrollment record, which is: ',result);
      response.set('Access-Control-Allow-Origin', '*');
      response.status(201).send(result.rows)
    });
  return ;
}

/*
* This function take an enrollment code for a patient and sends back basic information
* about the program in which they are enrolled. If nothing is found, it sends back
* an error message
*/
async function findEnrollmentDetailsWithCode(enrollmentCode: string, response:any) {
  var res: any;

  console.log("[DEBUG] Inside findEnrollmentDetailsWithCode, process.env.DATABASE_URL has value: ", process.env.DATABASE_URL,
  "and process.env.PORT has value: ", process.env.PORT)

  const client = new Client({
    connectionString: process.env.DATABASE_URL,
      ssl: 
        // false
        {rejectUnauthorized: false} // use this when connecting to cloud based database. Else, set ssl: to false
  });

  client.connect();

  var selectClause = "SELECT idProgramEnrollment, PatientId, ProgramId, ProgramEnrollmentDate, ProgramStartDate, ProgramEnrollmentCode,"+
                      " idProgramDayRecord, date, satisfactionLevel, difficultyLevel, selfEfficacy, painLevel, motivationLevel, exerciseseriesid, " +
                      "idExerciceRecord, exerciceName, numberSeries, numberRepetitions ",
      fromClause =  "FROM goldfit.ProgramEnrollment, goldfit.ProgramDayRecord, goldfit.ExerciceRecord, goldfit.Exercice ",
      whereCLAUSE = "WHERE goldfit.ProgramEnrollment.idProgramEnrollment = goldfit.ProgramDayRecord.ProgramEnrollmentId AND "+
      "goldfit.ExerciceRecord.ProgramDayRecordID = goldfit.ProgramDayRecord.idProgramDayRecord AND " +
      "goldfit.ExerciceRecord.ExerciceId = goldfit.Exercice.idExercice AND " +
      "goldfit.ProgramEnrollment.ProgramEnrollmentCode = \'" + enrollmentCode + "\'";
  var programQuery = selectClause + fromClause + whereCLAUSE;  

  client.query(programQuery, async function (err:any, result:any) {
      if (err) throw err;
      if ((!result) || (result.length ==0)){
        response.status(404).send('Did not find enrollment record for enrollmernt code: '+ enrollmentCode)
        return
      }
      
      console.log('[DEBUG] Found an enrollment record. The result set: ',result.rows);
      response.set('Access-Control-Allow-Origin', '*');
      response.status(201).send(result.rows)
    });
  return ;
}


/**
 * This function computes a program enrollment object from the result set of a query with the
 * following SELECT statement:
 * SELECT idProgramEnrollment, PatientId, ProgramId, ProgramEnrollmentDate, ProgramStartDate, ProgramEnrollmentCode,
          idProgramDayRecord, date, satisfactionLevel, difficultyLevel, selfEfficacy, painLevel, motivationLevel, exerciseseriesid,
          idExerciceRecord, ExerciceId, numberSeries, numberRepetitions
 * The first time we encounter any ID, we check if we have an object with that ID. If we find in a Map of such objects,
          we use it, else, we construct it. That way we built a graph of objects.
 * The function takes three parameters
 * @param enrollment_results
 * @returns 
 */
function buildEnrollmentFromEnrollmentDetailsQueryResults(enrollment_results: Array<any>, patient: Patient|null, program: Program|null) {
    // enrollment_results consists of a bunch of rows, each one is the result
    // of joining a bunch of tables. I have to untangle them

    var tableEnrollments = new Map();
    var tableDayRecords = new Map();
    var tableExerciseRecords = new Map();
    var tableExerciseSeries = new Map() ; // exercise series are in program. This is simply for efficiency
    var tableExercises = new Map(); // exercises are in program. This one is just for efficiency
    var currentEnrollment = null
    var currentDayRecord = null
    var currentExerciseRecord = null

    enrollment_results.forEach(element => {
        // A. see if ProgramEnrollment object was already created, if not, create it
        currentEnrollment = tableEnrollments.get(element.idprogramenrollment)
        if (!currentEnrollment) {
          // if patient passed as argument was null, construct one just with the ID
          if (!patient) patient = new Patient('','',element.patientid)

          // if program passed as argument was null, construct one just with the ID
          if (!program) program = new Program('','',element.programid)

          currentEnrollment = new ProgramEnrollment(patient, program, element.programenrollmentcode, element.programenrollmentdate, element.programstartdate )
          // ProgramEnrollmentDate, ProgramStartDate, ProgramEnrollmentCode
          tableEnrollments.set(element.programenrollmentcode,currentEnrollment)
        }

        // B. see if ProgramDayRecord was already created, if not create it
        
        currentDayRecord = tableDayRecords.get(element.idprogramdayrecord)
        
        // if first time encountered, create it
        if (!currentDayRecord) {
          // 1. first get the date of the day record, by converting the string 'date' to a 
          // date object
          const currentDayRecordDate = new Date(element.date)
          
          // 2. get the exercice series applicable on that date. 
          // a. First, search by id in table
          var exerciceSeries = tableExerciseSeries.get(element.exerciseseriesid)

          // b. If not found, look for it the hard way
          if (!exerciceSeries) {
            exerciceSeries = currentEnrollment.getExerciseSeriesForDay(currentDayRecordDate)
            tableExerciseSeries.set(element.exerciseseriesid,exerciceSeries)
          }

          // 3. Now, create DayRecord, and add it to tableDayRecords
          currentDayRecord = new ProgramDayRecord( currentDayRecordDate, exerciceSeries )
          currentDayRecord.difficultyLevel = element.difficultylevel
          currentDayRecord.motivationLevel = element.motivationlevel
          currentDayRecord.painLevel = element.painlevel
          currentDayRecord.satisfactionLevel = element.satisfactionlevel
          currentDayRecord.selfEfficacy = element.selfefficacy

          tableDayRecords.set(element.idprogramdayrecord,currentDayRecord)
        }

        // C. Now, create exercice record!
        // 1. First, find exercise
        var exercice = tableExercises.get(element.exercicename)
        if (!exercice) {
          // look for it in current exerciseSeries object
          exercice = exerciceSeries.getExerciceWithName(element.exercicename)
          tableExercises.set(element.exercicename,exercice)
        }
        // 2. Now create exercise record
        var exerciceRecord = new ExerciseRecord(exercice,JSON.parse(element.numSeries), JSON.parse(element.numRepetitions))
        // 3. Now, add it to day record
        currentDayRecord.addExerciceRecord(exerciceRecord)
    });

    return currentEnrollment;
}


/* GET program header for a given enrollment code. */
router.get('/program_header',  async function(req:any, res:any, next:any) {
  console.log('value of ec',req.query.ec)
  var _enrollmentCode = req.query.ec
 if (!_enrollmentCode) {
    console.log('Enrollment code was not properly initialized')
   _enrollmentCode = "MAL-01";
 }
  try {
    const prog = await findProgramHeaderForEnrollmentCode(_enrollmentCode,res)
  } catch (e) {
    console.log('Problem querying DB')
    res.status(500).send()
  }
});

/* GET program details for a given program name. */
router.get('/program_details',  async function(req:any, res:any, next:any) {
  var _programName = req.query.pgm_name
  console.log('value of pgm_name',_programName)
  
 if (!_programName) {
    console.log('No program name provided')
    res.status(404).send('No program name provided');
    return
 }
  try {
    const prog = await findProgramDetailsWithName(_programName,res)
  } catch (e) {
    console.log('Problem querying DB')
    res.status(500).send()
  }
});


/* GET enrollment details for a given enrollment code. */
router.get('/enrollment_details',  async function(req:any, res:any, next:any) {
  var _enrollmentCode = req.query.ec
  console.log('value of ec',_enrollmentCode)
  
 if (!_enrollmentCode) {
    console.log('[DEBUG] No enrollment code provided')
    res.status(404).send('No enrollment code provided');
    return
 }
  try {
    const prog = await findEnrollmentDetailsWithCode(_enrollmentCode,res)
  } catch (e) {
    console.log('Problem querying DB')
    res.status(500).send()
  }
});


// module.exports=router;
export default router
