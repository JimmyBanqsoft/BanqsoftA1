table 50005 "Seminar Setup"
{
    Caption = 'Seminar Setup';

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            Editable = false;
        }

        field(10; "Seminar Info ID No. Series"; Code[20])
        {
            Caption = 'Seminar Info ID No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series" where(Code = filter('SEM*'));
        }

        field(20; "Seminar Info Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(30; "Seminar Room ID No. Series"; Code[20])
        {
            Caption = 'Seminar Room ID No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series" where(Code = filter('SEM*'));
        }

        field(40; "Seminar Room Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(50; "Sem Instructor ID No. Series"; Code[20])
        {
            Caption = 'Seminar Instructor ID No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series" where(Code = filter('SEM*'));
        }

        field(60; "Sem Instructor Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(70; "Scehduled Sem ID No. Series"; Code[20])
        {
            Caption = 'Scehduled Seminar ID No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series" where(Code = filter('SEM*'));
        }

        field(80; "Scehduled Sem Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}