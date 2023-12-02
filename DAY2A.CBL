      ******************************************************************
      * Advent of Code 2023 Day 2, part A                              *
      *                                                                *
      * Jelle Besseling, 02/12/2023                                    *
      *                                                                *
      * Compile and run with:                                          *
      *   cobc -x -j DAY2A.cbl                                         *
      *                                                                *
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY2A.
       AUTHOR. JELLE BESSELING.
       DATE-WRITTEN.  02/12/2023.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT IN-FILE
           ASSIGN TO "DAY2.DAT"
           ORGANIZATION IS LINE SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS ECODE.
       DATA DIVISION.
       FILE SECTION.
       FD IN-FILE
           RECORD VARYING FROM 1 to 170 CHARACTERS.
       01  IN-REC              PIC X(170).
       WORKING-STORAGE SECTION.
       01  ECODE               PIC 9(2).
       01  TOTAL               PIC 9(9).
       01  GAME-REC.
           05  GAME-NUM        PIC 9(3).
           05  GAME-LINE       PIC X(165).
       01  GAME                PIC X(80).
       01  ELEMENT             PIC X(10).
       01  ELEMENT-DATA.
           05  ELEMENT-NUM     PIC 9(3).
           05  ELEMENT-NAME    PIC X(5).
       01  MORE                PIC X.
       01  RECORD-MORE         PIC X.
       01  CUR-DISQ            PIC X.
      *  UNSTRING statement control fields
       77  CHAR-CTR            PIC 9(3).
       77  REC-CHAR-CTR        PIC 9(3).
       PROCEDURE DIVISION.

       OPEN INPUT IN-FILE.
       IF ECODE NOT = 0
         DISPLAY "ERROR OPENING FILE: " ECODE
       END-IF
       PERFORM PROCESS-LINE UNTIL ECODE = 10.
       CLOSE IN-FILE.

       DISPLAY "TOTAL: " TOTAL.

       GOBACK.

      *> PROCESS ONE LINE OF INPUT
       PROCESS-LINE.
           READ IN-FILE.
           IF ECODE NOT = 10
             ADD 5 TO ZERO GIVING CHAR-CTR
             UNSTRING IN-REC DELIMITED BY ": "
               INTO GAME-NUM
                    GAME-LINE
               WITH POINTER CHAR-CTR
               ON OVERFLOW DISPLAY "OVERFLOW"
             END-UNSTRING
             PERFORM PROCESS-GAME-LINE
           END-IF
       .
      *> THE LINE HAS BEEN PARSED, NOW PROCESS THE RECORDS
       PROCESS-GAME-LINE.
           MOVE 'N' TO CUR-DISQ
           ADD 1 TO ZERO GIVING CHAR-CTR
           MOVE 'Y' TO MORE
           PERFORM UNTIL MORE = 'N'
             MOVE 'N' TO MORE
             UNSTRING GAME-LINE DELIMITED BY ";"
               INTO GAME
               WITH POINTER CHAR-CTR
               ON OVERFLOW MOVE 'Y' TO MORE
             END-UNSTRING
             ADD 1 TO CHAR-CTR
      *      DISPLAY GAME-NUM " GAME: " GAME
             PERFORM PROCESS-RECORD
           END-PERFORM
           IF CUR-DISQ = 'N'
             ADD GAME-NUM TO TOTAL
           END-IF
       .
       PROCESS-RECORD.
           ADD 1 TO ZERO GIVING REC-CHAR-CTR
           MOVE 'Y' TO RECORD-MORE
           PERFORM UNTIL RECORD-MORE = 'N'
             MOVE 'N' TO RECORD-MORE
             UNSTRING GAME DELIMITED BY ","
               INTO ELEMENT
               WITH POINTER REC-CHAR-CTR
               ON OVERFLOW MOVE 'Y' TO RECORD-MORE
             END-UNSTRING
             ADD 1 TO REC-CHAR-CTR
      *     DISPLAY " ELEMENT: " ELEMENT
             PERFORM PROCESS-ELEMENT
           END-PERFORM
       .
       PROCESS-ELEMENT.
           MOVE SPACES TO ELEMENT-DATA
           UNSTRING ELEMENT DELIMITED BY " "
              INTO ELEMENT-NUM
                   ELEMENT-NAME
           END-UNSTRING
      *    DISPLAY "  ELEMENT-NUM: " ELEMENT-NUM
      *    DISPLAY "  ELEMENT-NAME: " ELEMENT-NAME
           EVALUATE ELEMENT-NAME
             WHEN "red"
               IF ELEMENT-NUM IS GREATER THAN 12
                 AND CUR-DISQ = 'N'
                   MOVE 'Y' TO CUR-DISQ
      *             DISPLAY "GAME " GAME-NUM " RED TOO HIGH"
               END-IF
             WHEN "green"
               IF ELEMENT-NUM IS GREATER THAN 13
                 AND CUR-DISQ = 'N'
                   MOVE 'Y' TO CUR-DISQ
      *             DISPLAY "GAME " GAME-NUM " GREEN TOO HIGH"
               END-IF
             WHEN "blue"
               IF ELEMENT-NUM IS GREATER THAN 14
                 AND CUR-DISQ = 'N'
                   MOVE 'Y' TO CUR-DISQ
      *             DISPLAY "GAME " GAME-NUM " BLUE TOO HIGH"
               END-IF
           END-EVALUATE
       .
       END PROGRAM DAY2A.
