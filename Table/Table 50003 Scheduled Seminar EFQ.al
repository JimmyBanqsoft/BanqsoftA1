table 50003 "Scheduled Seminar"
{
    DataCaptionFields = ID, "Seminar Name", Status;
    DataClassification = CustomerContent;
    LookupPageId = "Scheduled Seminar List";
    DrillDownPageId = "Scheduled Seminar List";

    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'Scheduled Seminar ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionMembers = "Registration","Confirm","Ongoing","Archieve","Cancelled";
            OptionCaption = 'Registration,Confirm,Ongoing,Archieve,Cancelled';
        }
        field(10; "Seminar ID"; Code[20])
        {
            Caption = 'Scheduled Seminar ID';
            DataClassification = CustomerContent;
            TableRelation = "Seminar Info"."Seminar ID";

            trigger OnValidate();
            begin
                SeminarInfo.Reset();
                SeminarInfo.Get("Seminar ID");
                "Seminar Name" := SeminarInfo."Seminar Name";
                "Minimum Participant" := SeminarInfo."Minimum Participants";

                Validate("Seminar Start Time");
            end;
        }

        field(11; "Seminar Name"; Text[100])
        {
            Caption = 'Seminar Name';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(20; "Room ID"; Code[20])
        {
            Caption = 'Room ID';
            DataClassification = CustomerContent;
            TableRelation = "Seminar Room"."Room ID";

            trigger OnValidate();
            begin
                if (("Seminar ID" <> '') and ("Room ID" <> '')) then begin
                    CheckMaxOrOverMaxParticipant("Seminar ID", "Room ID");
                    Validate("Minimum Participant");

                    if (("Seminar Start Time" <> 0T) and ("Seminar Date" <> 0D)) then
                        CheckIfSeminarRoomAvailable(ID, "Room ID", "Seminar Date", "Seminar Start Time", "Seminar End Time");
                end;
            end;
        }

        field(30; "Instructor ID"; Code[20])
        {
            Caption = 'Instructor ID';
            DataClassification = CustomerContent;
            TableRelation = "Seminar Instructor".ID;

            trigger OnValidate();
            begin
                if (("Seminar Date" <> 0D) and ("Seminar Start Time" <> 0T)) then
                    CheckIfInstructorAvailable(ID, "Instructor ID", "Seminar Date", "Seminar Start Time", "Seminar End Time");
            end;
        }

        field(40; "Seminar Date"; Date)
        {
            Caption = 'Seminar Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Seminar Start Time" <> 0T then
                    Validate("Seminar Start Time");
            end;
        }

        field(50; "Seminar Start Time"; Time)
        {
            Caption = 'Seminar Start Time';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ((ID <> '') and ("Seminar ID" <> '') and ("Room ID" <> '') and ("Instructor ID" <> '') and ("Seminar Start Time" <> 0T)) then begin
                    SeminarInfo.Reset();
                    SeminarInfo.Get("Seminar ID");
                    "Seminar End Time" := "Seminar Start Time" + SeminarInfo."Seminar Duration";

                    Validate("Room ID");
                    Validate("Instructor ID");
                end;
            end;
        }

        field(51; "Minimum Participant"; Integer)
        {
            Caption = 'Min. Participant';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate();
            begin
                if "Minimum Participant" > "Maximum Participant" then
                    Error('Room is not enough to fit all minimum participant.');
            end;
        }

        field(52; "Maximum Participant"; Integer)
        {
            Caption = 'Max. Participant';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(53; "Seminar End Time"; Time)
        {
            Caption = 'Seminar End Time';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(60; "Total Registered Participants"; Integer)
        {
            Caption = 'Total Registered Participants';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(61; InvoiceProcess; Boolean)
        {
            Caption = 'Is Invoice Process';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SeminarSetup: Record "Seminar Setup";
        SeminarInfo: Record "Seminar Info";
        SeminarRoom: Record "Seminar Room";

    trigger OnInsert()
    begin
        if ID = '' then begin
            SeminarSetup.Reset();
            SeminarSetup.Get();
            SeminarSetup.TestField("Scehduled Sem ID No. Series");
            NoSeriesMgt.InitSeries(SeminarSetup."Scehduled Sem ID No. Series", '', 0D, ID, SeminarSetup."Scehduled Sem ID No. Series");
        end;
    end;

    procedure CheckMaxOrOverMaxParticipant(SeminarID: Code[20]; RoomID: Code[20]);
    begin
        SeminarInfo.Reset();
        SeminarInfo.Get(SeminarID);

        SeminarRoom.Reset();
        SeminarRoom.Get(RoomID);

        if SeminarInfo."Maximum Participants" < SeminarRoom."Allocated Maximum Participant" then
            "Maximum Participant" := SeminarInfo."Maximum Participants"
        else
            "Maximum Participant" := SeminarRoom."Allocated Maximum Participant";
    end;

    procedure CheckIfSeminarRoomAvailable(ScheduledSemID: Code[20]; RoomID: Code[20]; SemDate: Date; SemStartTime: Time; SemEndTime: Time);
    var
        ScheduledSem: Record "Scheduled Seminar";
    begin
        ScheduledSem.Reset();
        ScheduledSem.SetRange(ScheduledSem."Room ID", RoomID);
        ScheduledSem.SetRange(ScheduledSem."Seminar Date", SemDate);
        ScheduledSem.SetFilter(ScheduledSem.Status, '<>%1', Status::Archieve);
        ScheduledSem.SetFilter(ScheduledSem.ID, '<>%1', ScheduledSemID);
        if ScheduledSem.FindSet() then begin
            repeat
                if SemStartTime < ScheduledSem."Seminar Start Time" then begin
                    if SemEndTime > ScheduledSem."Seminar Start Time" then
                        Error('The room has been booked on %1 at %2 to %3', ScheduledSem."Seminar Date", ScheduledSem."Seminar Start Time", ScheduledSem."Seminar End Time")
                end
                else begin
                    if SemStartTime < ScheduledSem."Seminar End Time" then
                        Error('The room has been booked on %1 at %2 to %3', ScheduledSem."Seminar Date", ScheduledSem."Seminar Start Time", ScheduledSem."Seminar End Time");
                end;
            until ScheduledSem.Next() = 0;
        end;
    end;

    procedure CheckIfInstructorAvailable(ID: Code[20]; InstructorID: Code[20]; SemDate: Date; SemStartTime: Time; SemEndTime: Time);
    var
        ScheduledSem: Record "Scheduled Seminar";
    begin
        ScheduledSem.Reset();
        ScheduledSem.SetRange("Instructor ID", InstructorID);
        ScheduledSem.SetRange("Seminar Date", SemDate);
        ScheduledSem.SetFilter(ScheduledSem.ID, '<>%1', ID);
        ScheduledSem.SetFilter(ScheduledSem.Status, '<>%1', Status::Archieve);
        if ScheduledSem.FindSet() then begin
            repeat
                if SemStartTime < ScheduledSem."Seminar Start Time" then begin
                    if SemEndTime > ScheduledSem."Seminar Start Time" then
                        Error('Instructor has been booked on %1 at %2 to %3', ScheduledSem."Seminar Date", ScheduledSem."Seminar Start Time", ScheduledSem."Seminar End Time")
                end
                else begin
                    if SemStartTime < ScheduledSem."Seminar End Time" then
                        Error('Instructor has been booked on %1 at %2 to %3', ScheduledSem."Seminar Date", ScheduledSem."Seminar Start Time", ScheduledSem."Seminar End Time");
                end;
            until ScheduledSem.Next() = 0;
        end;
    end;

    procedure ShowScheduledSemCard(TStatus: Boolean)
    var
        CardPageID: Integer;
    begin
        GET(ID);

        case Status of
            Status::Registration:
                begin
                    CardPageID := 50011;
                end;
            Status::Confirm:
                begin
                    CardPageID := 50018;
                end;
            Status::Ongoing:
                begin
                    CardPageID := 50019;
                end;
            Status::Cancelled, Status::Archieve:
                begin
                    CardPageID := 50020;
                end;

        end;

        if TStatus then
            PAGE.RUNMODAL(CardPageID, Rec)
        else
            PAGE.RUN(CardPageID, Rec);
    end;
}