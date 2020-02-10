codeunit 50001 AfterPostedSalesInvoices
{
    // 2020-01-16  LCY   Created this codeunit to subscribe an event afterpost.

    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', true, true)]
    procedure MyProcedure(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean)
    var
        PostedSalesInvoices: Record "Sales Invoice Header";
    begin
        PostedSalesInvoices.SetRange(PostedSalesInvoices."Pre-Assigned No.", SalesHeader."No.");
        if PostedSalesInvoices.FindFirst() then
            PostedSalesInvoices."Scheduled Seminar ID" := SalesHeader."Scheduled Seminar ID";
        PostedSalesInvoices.Modify(true);
    end;
}