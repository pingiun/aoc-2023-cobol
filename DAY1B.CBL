      ******************************************************************
      * Advent of Code 2023 Day 1, part B                              *
      *                                                                *
      * Jelle Besseling, 02/12/2023                                    *
      *                                                                *
      * Compile and run with:                                          *
      *   cobc -x -j DAY1B.cbl                                         *
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
       01  IN-RECORD           PIC X(80).
       WORKING-STORAGE SECTION.
       01  ECODE               PIC 9(2).
       01  PTR                 PIC 9(2) VALUE ZERO.
       01  TOTAL               PIC 9(9) VALUE ZERO.
       01  DIGITS.
           05  FIRST-NUMBER    PIC 9(1).
           05  SECOND-NUMBER   PIC 9(1).
       01  LINE-NUMBER         PIC 9(2).
       01  HAVE-FIRST          PIC X(1) VALUE 'N'.
       01  PARSE-RET           PIC 9(1).
       01  COUNTER             PIC 9(9) VALUE ZERO.
       LINKAGE SECTION.
       PROCEDURE DIVISION.

       OPEN INPUT IN-FILE.
       PERFORM PROCESS-LINE UNTIL ECODE = 10.
       CLOSE IN-FILE.

       DISPLAY TOTAL.
      *>    DISPLAY "COUNT: " COUNTER.

       GOBACK.

      *> PROCESS ONE LINE AND ADD TO THE RUNNING TOTAL
       PROCESS-LINE.
           READ IN-FILE.
           ADD 1 TO COUNTER
           IF ECODE NOT = 10
             MOVE 1 TO PTR
             MOVE 'N' TO HAVE-FIRST
             PERFORM UNTIL PTR > 80
                PERFORM PROCESS-CHAR
                ADD 1 TO PTR
             END-PERFORM
             MOVE DIGITS TO LINE-NUMBER
             ADD LINE-NUMBER TO TOTAL
           END-IF
       .
      *> PARSE SOMETHING AT THE CURRENT POINTER
       PROCESS-CHAR.
       IF IN-RECORD(PTR:1) IS NUMERIC
           IF HAVE-FIRST = 'N'
             MOVE IN-RECORD(PTR:1) TO FIRST-NUMBER
             MOVE IN-RECORD(PTR:1) TO SECOND-NUMBER
             MOVE 'Y' TO HAVE-FIRST
           ELSE
             MOVE IN-RECORD(PTR:1) TO SECOND-NUMBER
           END-IF
       ELSE
           MOVE 0 TO PARSE-RET
           PERFORM PARSE-WORD
           IF PARSE-RET NOT = 0
             AND HAVE-FIRST = 'N'
                MOVE PARSE-RET TO FIRST-NUMBER
                MOVE PARSE-RET TO SECOND-NUMBER
                MOVE 'Y' TO HAVE-FIRST
           ELSE IF PARSE-RET NOT = 0
                MOVE PARSE-RET TO SECOND-NUMBER
           END-IF
       END-IF
       .
      *> CHECK IF THE POINTER STARTS AT A SPELLED OUT NUMBER
      *> AND PUT IT IN PARSE-RET
       PARSE-WORD.
       EVALUATE IN-RECORD(PTR:3)
         WHEN "one"
           ADD 1 TO ZERO GIVING PARSE-RET
         WHEN "two"
           ADD 2 TO ZERO GIVING PARSE-RET
         WHEN "thr"
           ADD 3 TO PTR
           IF IN-RECORD(PTR:2) = "ee"
             ADD 3 TO ZERO GIVING PARSE-RET
           END-IF
           SUBTRACT 3 FROM PTR
         WHEN "fou"
           ADD 3 TO PTR
           IF IN-RECORD(PTR:1) = "r"
             ADD 4 TO ZERO GIVING PARSE-RET
           END-IF
           SUBTRACT 3 FROM PTR
         WHEN "fiv"
           ADD 3 TO PTR
           IF IN-RECORD(PTR:1) = "e"
             ADD 5 TO ZERO GIVING PARSE-RET
           END-IF
           SUBTRACT 3 FROM PTR
         WHEN "six"
           ADD 6 TO ZERO GIVING PARSE-RET
         WHEN "sev"
           ADD 3 TO PTR
           IF IN-RECORD(PTR:2) = "en"
             ADD 7 TO ZERO GIVING PARSE-RET
           END-IF
           SUBTRACT 3 FROM PTR
         WHEN "eig"
           ADD 3 TO PTR
           IF IN-RECORD(PTR:2) = "ht"
             ADD 8 TO ZERO GIVING PARSE-RET
           END-IF
           SUBTRACT 3 FROM PTR
         WHEN "nin"
           ADD 3 TO PTR
           IF IN-RECORD(PTR:1) = "e"
             ADD 9 TO ZERO GIVING PARSE-RET
           END-IF
           SUBTRACT 3 FROM PTR
       END-EVALUATE
       .
       END PROGRAM DAY1A.
