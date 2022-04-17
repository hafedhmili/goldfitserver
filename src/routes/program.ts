import  {Exercise} from '../models/program';
import  {Interval} from '../models/program';
import  {ExerciseSeries} from '../models/program';
import  {Program} from '../models/program';

var mysql = require('mysql');
import { Client } from 'pg';

const Router = require('express');
var router = Router();

async function findProgramDetailsWithName(programName: string, response:any) {
  var res: any;
//  var con = mysql.createConnection({
//    host: "localhost",
//    user: "root",
//    password: "root",
//    database: 'GoldFit'
//  });

  const client = new Client({
    connectionString: process.env.DATABASE_URL,
    ssl: {
      rejectUnauthorized: false
    }
  });

  client.connect();


//  var res = await con.connect( async function(err: any, res:any) {
//    if (err) throw err;
//    console.log("Connected!");
//  });

  var selectClause = "SELECT * ",
      fromClause =  "FROM Program, ProgramExerciceSeries, ExerciceSeries, ExerciceSeriesExercice, Exercice ",
      whereCLAUSE = "WHERE Program.ProgramName = \"" + programName + "\" AND "+
      "Program.idProgram = ProgramExerciceSeries.ProgramId AND "+   // join Program with ProgramExerciceSeries
      "ProgramExerciceSeries.ExerciceSeriesId = ExerciceSeries.idExerciceSeries AND " +   // join ProgramExerciceSeries with ExerciceSeries
      "ExerciceSeries.idExerciceSeries = ExerciceSeriesExercice.ExerciceSeriesId AND " +   // join ExerciceSeries with ExerciceSeriesExerice
      "ExerciceSeriesExercice.ExerciceId = Exercice.idExercice";    // join ExerciceSeriesExerice with Exercice
  var programQuery = selectClause + fromClause + whereCLAUSE;  



//  var res = await con.query(programQuery, async function (err:any, result:any, fields:any) {
//      if (err) throw err;
//      if ((!result) || (result.length ==0)){
//        response.status(404).send('Did not find program with name: '+ programName)
//        return
//      }
//      console.log('Found a program with name: ' + programName + ', which is: ',result);
//      response.set('Access-Control-Allow-Origin', '*');
//      response.status(201).send(result)
//    });

    client.query(programQuery, async function (err:any, result:any) {
      if (err) throw err;
      if ((!result) || (result.length ==0)){
        response.status(404).send('Did not find program with name: '+ programName)
        return
      }
      console.log('Found a program with name: ' + programName + ', which is: ',result);
      response.set('Access-Control-Allow-Origin', '*');
      response.status(201).send(result)
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
    ssl: false
//    ssl: {
//      rejectUnauthorized: false
//    }
  });

  client.connect();

//  var con = mysql.createConnection({
//    host: "localhost",
//    user: "root",
//    password: "root",
//    database: 'GoldFit'
//  });

//  var res = await con.connect( async function(err: any, res:any) {
//    if (err) throw err;
//    console.log("Connected!");
//  });


  var selectClause = "SELECT PatientFirstName, PatientLastName, ProgramName, ProgramDuration, ProgramDescription ",
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
      
      const returnResult = stringifyArrayRowDataPackets(result)
      console.log('Found an enrollment record, which is: ',returnResult);
      response.set('Access-Control-Allow-Origin', '*');
      response.status(201).send(returnResult)
    });
  return ;
}


/* GET program header for a given enrollment code. */
router.get('/',  async function(req:any, res:any, next:any) {
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

/* GET program details for a given progra name. */
router.get('/program',  async function(req:any, res:any, next:any) {
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
// module.exports=router;
export default router
