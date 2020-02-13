table 50006 "Seminar Reg Participant"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Schedule Seminar ID"; Code[20])
        {
            Caption = 'Schedule Seminar ID';
            Editable = false;
            TableRelation = "Scheduled Seminar".ID;
        }

        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }

        field(20; "ID"; Code[20])
        {
            Caption = 'Participant ID';
            Editable = false;
        }

        field(30; Name; Text[100])
        {
            Caption = 'Participant Name';
            Editable = false;
        }

        field(40; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }

        field(50; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }

        field(51; CompanyNo; Code[20])
        {
            Caption = 'Company No.';
            Editable = false;
        }

        field(52; CustomerID; Code[20])
        {
            Caption = 'Customer ID';
            Editable = false;
        }

        field(60; "Billable"; Boolean)
        {
            Caption = 'Bill-To-Participant';
            InitValue = true;
        }

        field(61; "Bill-To-Company"; Boolean)
        {
            Caption = 'Bill-To-Company';
            InitValue = true;
        }
    }

    keys
    {
        key(PK; "Schedule Seminar ID", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        TScheduledSeminar: Record "Scheduled Seminar";
    begin
        TScheduledSeminar.Get("Schedule Seminar ID");
        if TScheduledSeminar.Status <> TScheduledSeminar.Status::Registration then
            Error('You are not allow to delete')
        else
            RecalculateParticipant("Schedule Seminar ID", "Line No.");

    end;

    procedure RecalculateParticipant(ScheduledSemID: Code[20]; LineNo: Integer);
    var
        SemRegPart: Record "Seminar Reg Participant";
        ScheduledSem: Record "Scheduled Seminar";
        CountParticipant: Integer;
    begin
        SemRegPart.SetRange(SemRegPart."Schedule Seminar ID", ScheduledSemID);
        SemRegPart.SetFilter(SemRegPart."Line No.", '<>%1', "Line No.");
        if SemRegPart.FindSet() then begin
            repeat
                CountParticipant := CountParticipant + 1;
            until SemRegPart.Next() = 0;
        end;

        ScheduledSem.Reset();
        ScheduledSem.Get(ScheduledSemID);
        ScheduledSem."Total Registered Participants" := CountParticipant;
        ScheduledSem.Modify(true);
    end;
}