page 50020 "Scheduled Seminar Card Archive"
{
    // 2020-01-13  LCY   Created this page to show based on the seminar status. Add a process to switch status.

    Caption = 'Scheduled Seminar Card';
    PageType = Card;
    SourceTable = "Scheduled Seminar";
    Editable = false;

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
                }
                field("Seminar ID"; "Seminar ID")
                {
                    Caption = 'Seminar ID';
                    ApplicationArea = All;
                }
                field("Room ID"; "Room ID")
                {
                    Caption = 'Room ID';
                    ApplicationArea = All;
                }
                field("Instructor ID"; "Instructor ID")
                {
                    Caption = 'Instructor ID';
                    ApplicationArea = All;
                }
                field("Seminar Date"; "Seminar Date")
                {
                    Caption = 'Seminar Date';
                    ApplicationArea = All;
                }
                field("Seminar Start Time"; "Seminar Start Time")
                {
                    Caption = 'Start Time';
                    ApplicationArea = All;
                }
                field("Seminar End Time"; "Seminar End Time")
                {
                    Caption = 'End Time';
                    ApplicationArea = All;
                }
                field("Minimum Participant"; "Minimum Participant")
                {
                    Caption = 'Minimum Participant';
                    ApplicationArea = All;
                }
                field("Maximum Participant"; "Maximum Participant")
                {
                    Caption = 'Maximum Participant';
                    ApplicationArea = All;
                }
                field("Total Registered Participants"; "Total Registered Participants")
                {
                    Caption = 'Total Reg. Participants';
                    ApplicationArea = All;
                }
            }

            part("Seminar Add Exp List Part"; "Seminar Add Exp List Part")
            {
                Caption = 'Seminar Additional Expenses';
                SubPageLink = "Schedule Seminar ID" = field (ID);
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
            action(Email)
            {
                ApplicationArea = All;
                Caption = 'Email';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsCancelled;

                trigger OnAction();
                var
                    SmtpMail: Codeunit "SMTP Mail";
                    SmtpMailSetup: Record "SMTP Mail Setup";
                    TRegPart: Record "Seminar Reg Participant";
                    TSeminarInfo: Record "Seminar Info";
                    LblMailSubject: Label 'Seminar %1';
                    LblMailBody: Label '<h1>Hi %1,</h1><br> The Seminar <u><b>%2</b></u> that you registered is <u><b>%3</b></u>.<br>The Seminar is on <u><b>%4</b></u> which is from <b>%5</b> to <b>%6</b>.<br> <h3>Thank You!</h3>';
                    MailSubject: Text;
                    MailBody: Text;
                    SenderName: Text;
                    SenderAddress: Text;
                    Recipient: Text;
                begin
                    TRegPart.Reset();
                    TRegPart.SetFilter(TRegPart."Schedule Seminar ID", '%1', ID);
                    TSeminarInfo.Get("Seminar ID");
                    SmtpMailSetup.Get();

                    if TRegPart.FindSet() then begin
                        repeat
                            MailSubject := StrSubstNo(LblMailSubject, TSeminarInfo."Seminar Name");
                            MailBody := StrSubstNo(LblMailBody, TRegPart.Name, TSeminarInfo."Seminar Name", Status, "Seminar Date", "Seminar Start Time", "Seminar End Time");
                            SenderName := 'Seminar Management';
                            SenderAddress := Format(SmtpMailSetup."User ID");
                            Recipient := Format(TRegPart."E-Mail");
                            SmtpMail.CreateMessage(SenderName, SenderAddress, Recipient, MailSubject, MailBody, true);
                            SmtpMail.Send();
                        until TRegPart.Next() = 0;
                        Message('Email Sent!');
                    end;
                end;
            }

            action(PostedSalesInvoices)
            {
                ApplicationArea = All;
                Caption = 'Posted Sales Invoices';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsArchieve;

                trigger OnAction();
                var
                    TSalesInvHeader: Record "Sales Invoice Header";
                    PPostedSalesInvoice: Page "Posted Sales Invoices";
                begin
                    TSalesInvHeader.Reset();
                    TSalesInvHeader.SetRange(TSalesInvHeader."Scheduled Seminar ID", ID);
                    PPostedSalesInvoice.SetTableView(TSalesInvHeader);
                    PPostedSalesInvoice.LookupMode(true);
                    PPostedSalesInvoice.Run();
                end;
            }
        }
    }

    var
        IsCancelled: Boolean;
        IsArchieve: Boolean;

    trigger OnAfterGetRecord();
    begin
        if Status = Status::Cancelled then
            IsCancelled := true;

        if Status = Status::Archieve then
            IsArchieve := true;
    end;
}
