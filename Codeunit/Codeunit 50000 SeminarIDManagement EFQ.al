codeunit 50000 "SeminarIDManagement"
{
    procedure InitSeminarInfoID(OpenUI: Boolean);
    var
        SeminarInfo: Record "Seminar Info";
    begin
        SeminarInfo.Insert(true);


        if OpenUI then begin
            SeminarInfo.SETRANGE("Seminar ID", SeminarInfo."Seminar ID");
            PAGE.RUN(50001, SeminarInfo);
        end;
    end;

    procedure InitSeminarRoomID(OpenUI: Boolean);
    var
        SeminarRoom: Record "Seminar Room";
    begin
        SeminarRoom.Insert(true);


        if OpenUI then begin
            SeminarRoom.SETRANGE("Room ID", SeminarRoom."Room ID");
            PAGE.RUN(50005, SeminarRoom);
        end;
    end;

    procedure InitSeminarInstructorID(OpenUI: Boolean);
    var
        SeminarInstructor: Record "Seminar Instructor";
    begin
        SeminarInstructor.Insert(true);


        if OpenUI then begin
            SeminarInstructor.SETRANGE("ID", SeminarInstructor."ID");
            PAGE.RUN(50008, SeminarInstructor);
        end;
    end;

    procedure InitScheduledSeminarID(OpenUI: Boolean);
    var
        ScheduledSeminar: Record "Scheduled Seminar";
    begin
        ScheduledSeminar.Insert(true);


        if OpenUI then begin
            ScheduledSeminar.SETRANGE("ID", ScheduledSeminar."ID");
            PAGE.RUN(50011, ScheduledSeminar);
        end;
    end;
}