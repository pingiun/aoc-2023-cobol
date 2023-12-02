      ******************************************************************
      * Advent of Code 2023 Day 1, part A                              *
      *                                                                *
      * Jelle Besseling, 02/12/2023                                    *
      *                                                                *
      * Compile and run with:                                          *
      *   cobc -x -j DAY1A.cbl                                         *
      *                                                                *
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY1A.
       AUTHOR. JELLE BESSELING.
       DATE-WRITTEN.  02/12/2023.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT IN-FILE
           ASSIGN TO "DAY1.DAT"
           ORGANIZATION IS LINE SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS ECODE.
       DATA DIVISION.
       FILE SECTION.
       FD IN-FILE
           RECORD VARYING FROM 1 to 80 CHARACTERS.
       01  IN-RECORD PIC X(80).
       WORKING-STORAGE SECTION.
       01  ECODE         PIC 9(2).
       01  PTR                 PIC 9(2) VALUE ZERO.
       01  TOTAL               PIC 9(9) VALUE ZERO.
       01  DIGITS.
           05  FIRST-NUMBER    PIC 9(1).
           05  SECOND-NUMBER   PIC 9(1).
       01  LINE-NUMBER         PIC 9(2).
       01  HAVE-FIRST          PIC X(1) VALUE 'N'.
       LINKAGE SECTION.
       PROCEDURE DIVISION.

       OPEN INPUT IN-FILE.
       PERFORM PROCESS-LINE UNTIL ECODE = 10.
       CLOSE IN-FILE.

       DISPLAY TOTAL.

       GOBACK.

      *> PROCESS ONE LINE AND ADD TO THE RUNNING TOTAL
       PROCESS-LINE.
           READ IN-FILE.
           IF ECODE NOT = 10
             MOVE ZERO TO PTR
             MOVE 'N' TO HAVE-FIRST
             PERFORM UNTIL PTR > 80
                PERFORM PROCESS-CHAR
                ADD 1 TO PTR
             END-PERFORM
             MOVE DIGITS TO LINE-NUMBER
             ADD LINE-NUMBER TO TOTAL
           END-IF
       .
      *> PROCESS ONE CHARACTER
       PROCESS-CHAR.
       IF IN-RECORD(PTR:1) IS NUMERIC
           IF HAVE-FIRST = 'N'
             MOVE IN-RECORD(PTR:1) TO FIRST-NUMBER
             MOVE IN-RECORD(PTR:1) TO SECOND-NUMBER
             MOVE 'Y' TO HAVE-FIRST
           ELSE
             MOVE IN-RECORD(PTR:1) TO SECOND-NUMBER
           END-IF
       END-IF
       .
       END PROGRAM DAY1A.
