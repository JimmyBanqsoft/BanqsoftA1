table 50004 "Seminar Instructor"
{
    DataClassification = CustomerContent;
    DataCaptionFields = "ID", "Instructor Name";
    LookupPageId = "Seminar Instructor List";
    DrillDownPageId = "Seminar Instructor List";

    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'Intructor ID';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(10; "Instructor Name"; Text[50])
        {
            Caption = 'Intructor Name';
            DataClassification = CustomerContent;

        }

        field(20; "Area of Expertise"; Text[100])
        {
            Caption = 'Area of Expertise';
            DataClassification = CustomerContent;

        }
    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; ID, "Instructor Name", "Area of Expertise")
        { }
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SeminarSetup: Record "Seminar Setup";

    trigger OnInsert()
    begin
        if ID = '' then begin
            SeminarSetup.Reset();
            SeminarSetup.Get();
            SeminarSetup.TestField("Sem Instructor ID No. Series");
            NoSeriesMgt.InitSeries(SeminarSetup."Sem Instructor ID No. Series", '', 0D, ID, SeminarSetup."Sem Instructor ID No. Series");
        end;
    end;
}