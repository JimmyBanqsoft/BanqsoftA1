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

        }

        field(10; "Instructor Name"; Text[50])
        {
            Caption = 'Intructor Name';
            DataClassification = ToBeClassified;

        }

        field(20; "Area of Expertise"; Text[100])
        {
            Caption = 'Area of Expertise';
            DataClassification = ToBeClassified;

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
        SeminarSetup.FindLast();
        "ID" := NoSeriesMgt.GetNextNo(SeminarSetup."Sem Instructor ID No. Series", 0D, true);

    end;
}