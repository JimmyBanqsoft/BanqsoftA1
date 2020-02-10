tableextension 50001 SalesInvoiceHeaderExt extends "Sales Invoice Header" //MyTargetTableId
{
    // 2020-01-17  LCY   Created a field extended to Sales Invoice Header
    fields
    {
        field(50000; "Scheduled Seminar ID"; Code[20])
        {
            Caption = 'Scheduled Semianr ID';
            DataClassification = CustomerContent;
        }
    }

}