tableextension 50001 SalesInvoiceHeaderExt extends "Sales Invoice Header" //MyTargetTableId
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