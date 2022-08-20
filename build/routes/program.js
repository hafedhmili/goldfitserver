"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
var mysql = require('mysql');
const pg_1 = require("pg");
const Router = require('express');
var router = Router();
function findProgramDetailsWithName(programName, response) {
    return __awaiter(this, void 0, void 0, function* () {
        var res;
        const client = new pg_1.Client({
            connectionString: process.env.DATABASE_URL,
            ssl: false
            // {rejectUnauthorized: false }
        });
        client.connect();
        var selectClause = "SELECT * ", fromClause = "FROM goldfit.Program, goldfit.ProgramExerciceSeries, goldfit.ExerciceSeries, goldfit.ExerciceSeriesExercice, goldfit.Exercice ", whereCLAUSE = "WHERE goldfit.Program.ProgramName = \'" + programName + "\' AND " +
            "goldfit.Program.idProgram = goldfit.ProgramExerciceSeries.ProgramId AND " + // join Program with ProgramExerciceSeries
            "goldfit.ProgramExerciceSeries.ExerciceSeriesId = goldfit.ExerciceSeries.idExerciceSeries AND " + // join ProgramExerciceSeries with ExerciceSeries
            "goldfit.ExerciceSeries.idExerciceSeries = goldfit.ExerciceSeriesExercice.ExerciceSeriesId AND " + // join ExerciceSeries with ExerciceSeriesExerice
            "goldfit.ExerciceSeriesExercice.ExerciceId = goldfit.Exercice.idExercice"; // join ExerciceSeriesExerice with Exercice
        var programQuery = selectClause + fromClause + whereCLAUSE;
        client.query(programQuery, function (err, result) {
            return __awaiter(this, void 0, void 0, function* () {
                if (err)
                    throw err;
                if ((!result) || (result.length == 0)) {
                    response.status(404).send('Did not find program with name: ' + programName);
                    return;
                }
                console.log('Found a program with name: ' + programName + ', which is: ', result);
                response.set('Access-Control-Allow-Origin', '*');
                response.status(201).send(result.rows);
            });
        });
    });
}
/*
* this function takes the result of q query and stringifies it
*/
function stringifyArrayRowDataPackets(rows) {
    return Object.values(JSON.parse(JSON.stringify(rows)));
}
/*
* This function take an enrollment code for a patient and sends back basic information
* about the program in which they are enrolled. If nothing is found, it sends back
* an error message
*/
function findProgramHeaderForEnrollmentCode(enrollmentCode, response) {
    return __awaiter(this, void 0, void 0, function* () {
        var res;
        console.log("Inside findProgramHeaderForEnrollmentCode, process.env.DATABASE_URL has value: ", process.env.DATABASE_URL, "and process.env.PORT has value: ", process.env.PORT);
        const client = new pg_1.Client({
            connectionString: process.env.DATABASE_URL,
            ssl: false
            // {rejectUnauthorized: false }
        });
        client.connect();
        var selectClause = "SELECT PatientFirstName, PatientLastName, idPatient, ProgramName, idProgramEnrollment, idProgram,ProgramDuration, ProgramDescription, ProgramEnrollmentDate, ProgramStartDate ", fromClause = "FROM goldfit.ProgramEnrollment, goldfit.Program, goldfit.Patient ", whereCLAUSE = "WHERE goldfit.ProgramEnrollment.ProgramId = goldfit.Program.idProgram AND " +
            "goldfit.ProgramEnrollment.PatientID = goldfit.Patient.idPatient AND " +
            "goldfit.ProgramEnrollment.ProgramEnrollmentCode = \'" + enrollmentCode + "\'";
        var programQuery = selectClause + fromClause + whereCLAUSE;
        client.query(programQuery, function (err, result) {
            return __awaiter(this, void 0, void 0, function* () {
                if (err)
                    throw err;
                if ((!result) || (result.length == 0)) {
                    response.status(404).send('Did not find program for enrollmernt code: ' + enrollmentCode);
                    return;
                }
                console.log('[DEBUG] Found an enrollment record, which is: ', result);
                response.set('Access-Control-Allow-Origin', '*');
                response.status(201).send(result.rows);
            });
        });
        return;
    });
}
/*
* This function take an enrollment code for a patient and sends back basic information
* about the program in which they are enrolled. If nothing is found, it sends back
* an error message
*/
function findEnrollmentDetailsWithCode(enrollmentCode, response) {
    return __awaiter(this, void 0, void 0, function* () {
        var res;
        console.log("[DEBUG] Inside findEnrollmentDetailsWithCode, process.env.DATABASE_URL has value: ", process.env.DATABASE_URL, "and process.env.PORT has value: ", process.env.PORT);
        const client = new pg_1.Client({
            connectionString: process.env.DATABASE_URL,
            ssl: false
            // {rejectUnauthorized: false}
        });
        client.connect();
        var selectClause = "SELECT idProgramEnrollment, PatientId, ProgramId, ProgramEnrollmentDate, ProgramStartDate, ProgramEnrollmentCode," +
            " idProgramDayRecord, date, satisfactionLevel, difficultyLevel, selfEfficacy, painLevel, motivationLevel," +
            "idExerciceRecord, ExerciceId, numberSeries, numberRepetitions ", fromClause = "FROM goldfit.ProgramEnrollment, goldfit.ProgramDayRecord, goldfit.ExerciceRecord ", whereCLAUSE = "WHERE goldfit.ProgramEnrollment.idProgramEnrollment = goldfit.ProgramDayRecord.ProgramEnrollmentId AND " +
            "goldfit.ExerciceRecord.ProgramDayRecordID = goldfit.ProgramDayRecord.idProgramDayRecord AND " +
            "goldfit.ProgramEnrollment.ProgramEnrollmentCode = \'" + enrollmentCode + "\'";
        var programQuery = selectClause + fromClause + whereCLAUSE;
        client.query(programQuery, function (err, result) {
            return __awaiter(this, void 0, void 0, function* () {
                if (err)
                    throw err;
                if ((!result) || (result.length == 0)) {
                    response.status(404).send('Did not find enrollment record for enrollmernt code: ' + enrollmentCode);
                    return;
                }
                console.log('[DEBUG] Found an enrollment record, which is: ', result);
                response.set('Access-Control-Allow-Origin', '*');
                response.status(201).send(result.rows);
            });
        });
        return;
    });
}
/* GET program header for a given enrollment code. */
router.get('/program_header', function (req, res, next) {
    return __awaiter(this, void 0, void 0, function* () {
        console.log('value of ec', req.query.ec);
        var _enrollmentCode = req.query.ec;
        if (!_enrollmentCode) {
            console.log('Enrollment code was not properly initialized');
            _enrollmentCode = "MAL-01";
        }
        try {
            const prog = yield findProgramHeaderForEnrollmentCode(_enrollmentCode, res);
        }
        catch (e) {
            console.log('Problem querying DB');
            res.status(500).send();
        }
    });
});
/* GET program details for a given program name. */
router.get('/program_details', function (req, res, next) {
    return __awaiter(this, void 0, void 0, function* () {
        var _programName = req.query.pgm_name;
        console.log('value of pgm_name', _programName);
        if (!_programName) {
            console.log('No program name provided');
            res.status(404).send('No program name provided');
            return;
        }
        try {
            const prog = yield findProgramDetailsWithName(_programName, res);
        }
        catch (e) {
            console.log('Problem querying DB');
            res.status(500).send();
        }
    });
});
/* GET enrollment details for a given enrollment code. */
router.get('/enrollment_details', function (req, res, next) {
    return __awaiter(this, void 0, void 0, function* () {
        var _enrollmentCode = req.query.ec;
        console.log('value of ec', _enrollmentCode);
        if (!_enrollmentCode) {
            console.log('[DEBUG] No enrollment code provided');
            res.status(404).send('No enrollment code provided');
            return;
        }
        try {
            const prog = yield findEnrollmentDetailsWithCode(_enrollmentCode, res);
        }
        catch (e) {
            console.log('Problem querying DB');
            res.status(500).send();
        }
    });
});
// module.exports=router;
exports.default = router;
