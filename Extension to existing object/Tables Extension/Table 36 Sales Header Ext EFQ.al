tableextension 50000 "SalesHeaderExt" extends "Sales Header"
{
    fields
    {
        field(50000; "Scheduled Seminar ID"; Code[20])
        {
            Caption = 'Scheduled Semianr ID';
            DataClassification = CustomerContent;
        }
    }
}