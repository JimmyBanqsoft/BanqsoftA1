page 50019 "Scheduled Seminar Card Ongoing"
{
    // 2020-01-17  LCY   Added check if participant selfpay or pay by company verification. Added verify if invoice posted then only process to Archieve.
    // 2020-01-15  LCY   Redo Process to Sales Invoice part. 
    // 2020-01-14  LCY   Add a trigger to process to Sales invoice to do posting.
    // 2020-01-13  LCY   Created this page to show based on the seminar status. Add a process to switch status.

    Caption = 'Scheduled Seminar Card (Ongoing)';
    PageType = Card;
    SourceTable = "Scheduled Seminar";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(ID; ID)
                {
                    Caption = 'ID';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Seminar ID"; "Seminar ID")
                {
                    Caption = 'Seminar ID';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Room ID"; "Room ID")
                {
                    Caption = 'Room ID';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Instructor ID"; "Instructor ID")
                {
                    Caption = 'Instructor ID';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Seminar Date"; "Seminar Date")
                {
                    Caption = 'Seminar Date';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Seminar Start Time"; "Seminar Start Time")
                {
                    Caption = 'Start Time';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Seminar End Time"; "Seminar End Time")
                {
                    Caption = 'End Time';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Minimum Participant"; "Minimum Participant")
                {
                    Caption = 'Minimum Participant';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Maximum Participant"; "Maximum Participant")
                {
                    Caption = 'Maximum Participant';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Registered Participants"; "Total Registered Participants")
                {
                    Caption = 'Total Reg. Participants';
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            part("Seminar Add Exp List Part"; "Seminar Add Exp List Part")
            {
                Caption = 'Seminar Additional Expenses';
                SubPageLink = "Schedule Seminar ID" = field (ID);
                Editable = false;
            }

            part("Seminar Reg Ppt List Part"; "Seminar Reg Ppt List Part")
            {
                Caption = 'Seminar Registered Participant';
                SubPageLink = "Schedule Seminar ID" = field (ID);
            }
        }

        area(FactBoxes)
        {
            part("Seminar Info Details"; "Seminar Info Factbox")
            {
                Caption = 'Seminar Info Details';
                SubPageLink = "Seminar ID" = field ("Seminar ID");
            }

            part("Seminar Room Details"; "Seminar Room Factbox")
            {
                Caption = 'Seminar Room Details';
                SubPageLink = "Room ID" = field ("Room ID");
            }
            part("Seminar Instructor Details"; "Seminar Instructor Factbox")
            {
                Caption = 'Seminar Instructor Details';
                SubPageLink = "ID" = field ("Instructor ID");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Process)
            {
                ApplicationArea = All;
                Caption = 'Process';
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    TSalesHeader: Record "Sales Header";
                    PSalesInvoice: Page "Sales Invoice List";

                    TPostedSalesInvoices: Record "Sales Invoice Header";
                    PPostedSalesInvoices: Page "Posted Sales Invoices";
                begin
                    TSalesHeader.Reset();
                    TSalesHeader.SetRange(TSalesHeader."Scheduled Seminar ID", ID);
                    if TSalesHeader.FindFirst() then begin
                        Message('You haven''t posted all the invoices yet.');
                        if Dialog.Confirm('Do you wish to open Sales Invoice List?') then begin
                            TSalesHeader.Reset();
                            TSalesHeader.SetRange(TSalesHeader."Scheduled Seminar ID", ID);
                            PSalesInvoice.SetTableView(TSalesHeader);
                            PSalesInvoice.LookupMode(true);
                            PSalesInvoice.Run();
                        end;
                    end
                    else begin
                        TPostedSalesInvoices.SetRange(TPostedSalesInvoices."Scheduled Seminar ID", ID);
                        if TPostedSalesInvoices.FindFirst() then begin
                            Status := Status::Archieve;
                            CurrPage.Update(true);
                            ShowScheduledSemCard(false);
                            CurrPage.Close();

                            if Dialog.Confirm('Invoiced has been posted! Do you wish to open Posted Sales Invoice List?') then begin
                                TPostedSalesInvoices.Reset();
                                TPostedSalesInvoices.SetRange(TPostedSalesInvoices."Scheduled Seminar ID", ID);
                                PPostedSalesInvoices.SetTableView(TPostedSalesInvoices);
                                PPostedSalesInvoices.LookupMode(true);
                                PPostedSalesInvoices.Run();
                            end;
                        end
                        else
                            Error('You have not process an Invoice to post yet!');
                    end;
                end;
            }

            action(ToPost)
            {
                ApplicationArea = All;
                Caption = 'Process to Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    ListCompanyNo: List of [Code[20]];
                    ListCustID: List of [Code[20]];
                    ListCounter: Integer;
                    ListTotal: Integer;
                    SalesLineNo: Integer;

                    TSalesHeader: Record "Sales Header";
                    TSalesLine: Record "Sales Line";
                    TRegPart: Record "Seminar Reg Participant";
                    TContact: Record Contact;
                    TCustomer: Record Customer;
                    TSeminarInfo: Record "Seminar Info";
                    TAddExp: Record "Seminar Additional Expenses";
                    TSalesHeader2: Record "Sales Header";

                    PSalesInvoice: Page "Sales Invoice List";

                begin
                    if not InvoiceProcess then begin
                        TRegPart.Reset();
                        TRegPart.SetRange(TRegPart."Schedule Seminar ID", ID);

                        if TRegPart.FindSet() then begin
                            repeat
                                ListTotal := ListCompanyNo.Count();
                                if ListTotal > 0 then begin
                                    if ListCompanyNo.Contains(TRegPart.CompanyNo) then begin

                                    end
                                    else begin
                                        ListCompanyNo.Add(TRegPart.CompanyNo);
                                        ListCustID.Add(TRegPart.CustomerID);
                                        ListTotal := ListCompanyNo.Count();
                                    end;
                                end
                                else begin
                                    ListCompanyNo.Add(TRegPart.CompanyNo);
                                    ListCustID.Add(TRegPart.CustomerID);
                                    ListTotal := ListCompanyNo.Count();
                                end;
                            until TRegPart.Next() = 0;
                        end;

                        for ListCounter := 1 to ListTotal do begin
                            TRegPart.Reset();
                            TRegPart.SetFilter(TRegPart."Schedule Seminar ID", ID);
                            TRegPart.SetRange(TRegPart.CompanyNo, ListCompanyNo.Get(ListCounter));
                            TRegPart.SetFilter(TRegPart."Bill-To-Company", 'Yes');

                            if TRegPart.FindFirst() then begin
                                TCustomer.Reset();
                                TCustomer.Get(ListCustID.Get(ListCounter));

                                TContact.Reset();
                                TContact.Get(ListCompanyNo.Get(ListCounter));

                                Clear(TSalesHeader);
                                TSalesHeader.Reset();
                                TSalesHeader.Init();
                                TSalesHeader."Document Type" := TSalesHeader."Document Type"::Invoice;
                                TSalesHeader.Validate("No.");
                                TSalesHeader."Sell-to Customer Name" := TCustomer.Name;
                                TSalesHeader.Validate("Sell-to Customer Name");
                                TSalesHeader."Sell-to Contact No." := TContact."Company No.";
                                TSalesHeader."Sell-to Contact" := TContact."Company Name";
                                TSalesHeader."Scheduled Seminar ID" := ID;
                                TSalesHeader.Insert(true);

                                TRegPart.Reset();
                                TRegPart.SetFilter(TRegPart."Schedule Seminar ID", ID);
                                TRegPart.SetRange(TRegPart.CompanyNo, ListCompanyNo.Get(ListCounter));
                                TRegPart.SetFilter(TRegPart."Bill-To-Company", 'Yes');
                                TSeminarInfo.Get("Seminar ID");
                                SalesLineNo := 0;
                                if TRegPart.FindSet() then begin
                                    repeat
                                        SalesLineNo := SalesLineNo + 1;
                                        Clear(TSalesLine);
                                        TSalesLine.Reset();
                                        TSalesLine.Init();
                                        TSalesLine."Document Type" := TSalesHeader."Document Type";
                                        TSalesLine.Validate("Document Type");

                                        TSalesLine."Document No." := TSalesHeader."No.";

                                        TSalesLine."Line No." := SalesLineNo;

                                        TSalesLine.Type := TSalesLine.Type::"G/L Account";
                                        TSalesLine.Validate(Type);

                                        TSalesLine."No." := '6610';
                                        TSalesLine.Validate("No.");

                                        TSalesLine.Description := Format(TRegPart.Name);

                                        TSalesLine.Quantity := 1;
                                        TSalesLine.Validate(Quantity);

                                        TSalesLine."Unit Price" := TSeminarInfo."Seminar Price";
                                        TSalesLine.Validate("Unit Price");
                                        TSalesLine.Insert(true);

                                        TAddExp.SetRange(TAddExp."Schedule Seminar ID", ID);
                                        if TAddExp.FindSet() then begin
                                            if TAddExp."Bill-To-Customer" then
                                                if TRegPart.Billable then begin
                                                    SalesLineNo := SalesLineNo + 1;
                                                    Clear(TSalesLine);
                                                    TSalesLine.Reset();
                                                    TSalesLine.Init();
                                                    TSalesLine."Document Type" := TSalesHeader."Document Type";
                                                    TSalesLine."Document No." := TSalesHeader."No.";
                                                    TSalesLine."Line No." := SalesLineNo;
                                                    TSalesLine.Type := TSalesLine.Type::"G/L Account";
                                                    TSalesLine."No." := '6610';
                                                    TSalesLine.Validate("No.");
                                                    TSalesLine.Description := TAddExp.Remark;
                                                    TSalesLine.Quantity := 1;
                                                    TSalesLine.Validate(Quantity);
                                                    TSalesLine."Unit Price" := TAddExp.Amount;
                                                    TSalesLine.Validate("Unit Price");
                                                    TSalesLine.Insert(true);
                                                end;
                                        end;
                                    until TRegPart.Next() = 0
                                end;
                            end;

                            TRegPart.Reset();
                            TRegPart.SetFilter(TRegPart."Schedule Seminar ID", ID);
                            TRegPart.SetRange(TRegPart.CompanyNo, ListCompanyNo.Get(ListCounter));
                            TRegPart.SetFilter(TRegPart."Bill-To-Company", 'No');

                            if TRegPart.FindSet() then begin
                                TCustomer.Reset();
                                TCustomer.Get(ListCustID.Get(ListCounter));

                                TContact.Reset();
                                TContact.Get(ListCompanyNo.Get(ListCounter));

                                Clear(TSalesHeader);
                                TSalesHeader.Reset();
                                TSalesHeader.Init();
                                TSalesHeader."Document Type" := TSalesHeader."Document Type"::Invoice;
                                TSalesHeader.Validate("No.");
                                TSalesHeader."Sell-to Customer Name" := TCustomer.Name;
                                TSalesHeader.Validate("Sell-to Customer Name");
                                TSalesHeader."Sell-to Contact No." := TRegPart.ID;
                                TSalesHeader."Sell-to Contact" := TRegPart.Name;
                                TSalesHeader."Scheduled Seminar ID" := ID;
                                TSalesHeader.Insert(true);

                                SalesLineNo := 0;
                                SalesLineNo := SalesLineNo + 1;
                                Clear(TSalesLine);
                                TSalesLine.Reset();
                                TSalesLine.Init();
                                TSalesLine."Document Type" := TSalesHeader."Document Type";
                                TSalesLine.Validate("Document Type");
                                TSalesLine."Document No." := TSalesHeader."No.";
                                TSalesLine."Line No." := SalesLineNo;
                                TSalesLine.Type := TSalesLine.Type::"G/L Account";
                                TSalesLine.Validate(Type);
                                TSalesLine."No." := '6610';
                                TSalesLine.Validate("No.");
                                TSalesLine.Description := Format(TRegPart.Name);
                                TSalesLine.Quantity := 1;
                                TSalesLine.Validate(Quantity);
                                TSalesLine."Unit Price" := TSeminarInfo."Seminar Price";
                                TSalesLine.Validate("Unit Price");
                                TSalesLine.Insert(true);

                                TAddExp.SetRange(TAddExp."Schedule Seminar ID", ID);
                                if TAddExp.FindSet() then begin
                                    if TAddExp."Bill-To-Customer" then
                                        if TRegPart.Billable then begin
                                            SalesLineNo := SalesLineNo + 1;
                                            Clear(TSalesLine);
                                            TSalesLine.Reset();
                                            TSalesLine.Init();
                                            TSalesLine."Document Type" := TSalesHeader."Document Type";
                                            TSalesLine."Document No." := TSalesHeader."No.";
                                            TSalesLine."Line No." := SalesLineNo;
                                            TSalesLine.Type := TSalesLine.Type::"G/L Account";
                                            TSalesLine."No." := '6610';
                                            TSalesLine.Validate("No.");
                                            TSalesLine.Description := TAddExp.Remark;
                                            TSalesLine.Quantity := 1;
                                            TSalesLine.Validate(Quantity);
                                            TSalesLine."Unit Price" := TAddExp.Amount;
                                            TSalesLine.Validate("Unit Price");
                                            TSalesLine.Insert(true);
                                        end;
                                end;
                            end;
                        end;


                        // This is after processed to invoice.
                        InvoiceProcess := true;
                        Commit();

                        TSalesHeader2.SetRange(TSalesHeader2."Scheduled Seminar ID", ID);
                        PSalesInvoice.SetTableView(TSalesHeader2);
                        PSalesInvoice.LookupMode(true);
                        PSalesInvoice.Run();
                    end
                    else begin
                        if Dialog.Confirm('Invoiced has been processed! Do you wish to open Sales Invoice List?') then begin
                            TSalesHeader2.Reset();
                            TSalesHeader2.SetRange(TSalesHeader2."Scheduled Seminar ID", ID);
                            PSalesInvoice.SetTableView(TSalesHeader2);
                            PSalesInvoice.LookupMode(true);
                            PSalesInvoice.Run();
                        end;
                    end;
                end;
            }
        }
    }
}