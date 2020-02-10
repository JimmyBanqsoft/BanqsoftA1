tableextension 50000 "SalesHeaderExt" extends "Sales Header" //MyTargetTableId
{
    // 2020-01-14  LCY   Created this Table Ext to add extra field and to do linking connection.
    fields
    {
        field(50000; "Scheduled Seminar ID"; Code[20])
        {
            Caption = 'Scheduled Semianr ID';
            DataClassification = CustomerContent;
        }
    }
}