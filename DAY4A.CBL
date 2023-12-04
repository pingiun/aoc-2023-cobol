      ******************************************************************
      * Advent of Code 2023 Day 4, part A                              *
      *                                                                *
      * Jelle Besseling, 04/12/2023                                    *
      *                                                                *
      * Compile and run with:                                          *
      *   cobc -x -j DAY4A.cbl                                         *
      *                                                                *
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY4A.
       AUTHOR. JELLE BESSELING.
       DATE-WRITTEN.  02/12/2023.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT IN-FILE
           ASSIGN TO "DAY4.DAT"
           ORGANIZATION IS LINE SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS ECODE.
       DATA DIVISION.
       FILE SECTION.
       FD IN-FILE.
       01  IN-RECORD.
           05  SKIP-CARD       PIC X(4).
           05  CARD-NUM        PIC 9(4).
           05  SKIP-COLON      PIC X.
           05  WINNING-NUMS    OCCURS 10 TIMES
                               ASCENDING KEY IS WINNING-NUM
                               INDEXED BY W.
               10 WINNING-NUM   PIC 9(3).
           05  SKIP-PIPE       PIC XX.
           05  HAVE-NUMS       OCCURS 25 TIMES INDEXED BY I.
               10 HAVE-NUM     PIC 9(3).
       WORKING-STORAGE SECTION.
       01  ECODE               PIC 9(2).
       01  TOTAL               PIC 9(9) VALUE ZERO.
       01  POINTS              PIC 9(3).
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
             MOVE 0 TO POINTS
             SORT WINNING-NUMS ASCENDING WINNING-NUM
             PERFORM CHECK-WINNING VARYING I FROM 1 BY 1 UNTIL I > 25
             ADD POINTS TO TOTAL
           END-IF
       .
       CHECK-WINNING.
           SEARCH ALL WINNING-NUMS
             WHEN WINNING-NUM(W) = HAVE-NUMS(I)
             IF POINTS IS ZERO
               ADD 1 TO POINTS
             ELSE
               MULTIPLY POINTS BY 2 GIVING POINTS
             END-IF
           END-SEARCH
       .
       END PROGRAM DAY4A.
