//
//  SendSmtpMail.swift
//  BiarFoodiphone
//
//  Created by Ecc on 06/10/2023.
//

import Foundation
import SwiftSMTP
class SendSmtpMail{
    static let shared = SendSmtpMail()
   private func dateFormatter(date: Date) -> String{
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "dd.MM.yyyy"
        let dateFormat = dataFormatter.string(from: date)
       return "\(dateFormat)"
        
    }
    
    func SendEmail(invoiceData: Invoice){
        let htmlInvoice = generateHTMLInvoice2(invoiceData: invoiceData)
//        let logoAttecment = Attachment(filePath: "~/nutri2.jpeg",additionalHeaders: ["CONTENT-ID": "img001"])
        let smtp = SMTP(hostname: "smtp.strato.de", email: "biar@portfolio-emami.de", password: "Afghan2250",port: 587)
        let biarfood = Mail.User(name: "Biarfood GmbH", email: "biar@portfolio-emami.de")
        let megaman = Mail.User(name: invoiceData.customerName, email: invoiceData.email)
        let htmlAttech = Attachment(htmlContent: htmlInvoice)
//        let data = "{\"key\": \"hello world\"}".data(using: .utf8)!
//        let dataAttechment = Attachment(
//            data: data,
//            mime: "application/json",
//            name: "file.json",
//            // send as a standalone attachment
//            inline: false
//        )
        
        let mail = Mail(from: biarfood, to: [megaman],subject: "Ihre Bestellung",attachments: [htmlAttech])
        smtp.send(mail){error in
            if let error = error {
                print("Email Vesand fehlgeschlagen : \(error.localizedDescription)")
            }else{
                print("Email war erfolgreich")
            }
        }
    }
    
    
    private func generateHTMLInvoice(invoiceData: Invoice) -> String {
       var productsHtml = ""
        for product in invoiceData.products {
            let productHtml = """
            <tr class="item">
            <td>\(product.name)</td>
            <td>\(product.price)€</td>
        </tr>
        """
            productsHtml += productHtml
        }
        
        let htmlTemplate = """
        <!DOCTYPE html>
        <html>
            <head>
                <meta charset="utf-8" />
                <title>Rechnung auf Ihre Bestellungen</title>

                <style>
                    .invoice-box {
                        max-width: 800px;
                        margin: auto;
                        padding: 30px;
                        border: 1px solid #eee;
                        box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
                        font-size: 16px;
                        line-height: 24px;
                        font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
                        color: #555;
                    }

                    .invoice-box table {
                        width: 100%;
                        line-height: inherit;
                        text-align: left;
                    }

                    .invoice-box table td {
                        padding: 5px;
                        vertical-align: top;
                    }

                    .invoice-box table tr td:nth-child(2) {
                        text-align: right;
                    }

                    .invoice-box table tr.top table td {
                        padding-bottom: 20px;
                    }

                    .invoice-box table tr.top table td.title {
                        font-size: 45px;
                        line-height: 45px;
                        color: #333;
                    }

                    .invoice-box table tr.information table td {
                        padding-bottom: 40px;
                    }

                    .invoice-box table tr.heading td {
                        background: #eee;
                        border-bottom: 1px solid #ddd;
                        font-weight: bold;
                    }

                    .invoice-box table tr.details td {
                        padding-bottom: 20px;
                    }

                    .invoice-box table tr.item td {
                        border-bottom: 1px solid #eee;
                    }

                    .invoice-box table tr.item.last td {
                        border-bottom: none;
                    }

                    .invoice-box table tr.total td:nth-child(2) {
                        border-top: 2px solid #eee;
                        font-weight: bold;
                    }

                    @media only screen and (max-width: 600px) {
                        .invoice-box table tr.top table td {
                            width: 100%;
                            display: block;
                            text-align: center;
                        }

                        .invoice-box table tr.information table td {
                            width: 100%;
                            display: block;
                            text-align: center;
                        }
                    }

                    /** RTL **/
                    .invoice-box.rtl {
                        direction: rtl;
                        font-family: Tahoma, 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
                    }

                    .invoice-box.rtl table {
                        text-align: right;
                    }

                    .invoice-box.rtl table tr td:nth-child(2) {
                        text-align: left;
                    }
                </style>
            </head>

            <body>
                <div class="invoice-box">
                    <table cellpadding="0" cellspacing="0">
                        <tr class="top">
                            <td colspan="2">
                                <table>
                                    <tr>
                                        <td class="title">
                                            <img
                                                src="https://github.com/Emami-114/BiarFoodiphone/assets/114245656/707bf4b1-ffd7-4a43-9870-2f2f84be6434"
                                                style="width: 100%; max-width: 150px"
                                            />
                                        </td>

                                        <td>
                                            Invoice #: 123<br />
                                            Created: \(invoiceData.createdAt.dateValue())<br />
                                            Delivery: Datum
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>

                        <tr class="information">
                            <td colspan="2">
                                <table>
                                    <tr>
                                        <td>
                                            BiarFood GmbH<br />
                                            Stauffenberg straße 12<br />
                                            07747 Jena
                                        </td>

                                        <td>
                                            \(invoiceData.customerName)<br />
                                            \(invoiceData.customerZip)
                                            \(invoiceData.customerCity)<br />
                                            \(invoiceData.email)
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>

                        <tr class="heading">
                            <td>Payment Method</td>

                            <td>\(invoiceData.paymentType)</td>
                        </tr>

                        <tr class="heading">
                            <td>Item</td>

                            <td>Price</td>
                        </tr>

                      \(productsHtml)

                        <tr class="total">
                            <td></td>

                            <td>Total: \(invoiceData.totalPrice)€</td>
                        </tr>
                    </table>
                </div>
            </body>
        </html>
        """
        
        return htmlTemplate
    }
    
    
    private func generateHTMLInvoice2(invoiceData: Invoice) -> String {
       var productsHtml = ""
        for product in invoiceData.products {
            let productHtml = """
                    <tr>
                <td>\(product.name)</td>
                 <td>\(product.quantity)</td>
               <td class="alignright">\(product.price)</td>
         </tr>
        """
            productsHtml += productHtml
        }
        
        let htmlTemplate = """
        <!DOCTYPE html>
        <html>
            <head>
                <meta charset="utf-8" />
                <title>Rechnung auf Ihre Bestellungen</title>

                <style>

               * {
                   margin: 0;
                   padding: 0;
                   font-family: "Helvetica Neue", "Helvetica", Helvetica, Arial, sans-serif;
                   box-sizing: border-box;
                   font-size: 14px;
               }

               img {
                   max-width: 100%;
               }

               body {
                   -webkit-font-smoothing: antialiased;
                   -webkit-text-size-adjust: none;
                   width: 100% !important;
                   height: 100%;
                   line-height: 1.6;
               }

               /* Let's make sure all tables have defaults */
               table td {
                   vertical-align: top;
               }

               body {
                   background-color: #f6f6f6;
               }

               .body-wrap {
                   background-color: #f6f6f6;
                   width: 100%;
               }

               .container {
                   display: block !important;
                   max-width: 600px !important;
                   margin: 0 auto !important;
                   /* makes it centered */
                   clear: both !important;
               }

               .content {
                   max-width: 600px;
                   margin: 0 auto;
                   display: block;
                   padding: 20px;
               }

               /* -------------------------------------
                   HEADER, FOOTER, MAIN
               ------------------------------------- */
               .main {
                   background: #fff;
                   border: 1px solid #e9e9e9;
                   border-radius: 3px;
               }

               .content-wrap {
                   padding: 20px;
               }

               .content-block {
                   padding: 0 0 20px;
               }

               .header {
                   width: 100%;
                   margin-bottom: 20px;
               }

               .footer {
                   width: 100%;
                   clear: both;
                   color: #999;
                   padding: 20px;
               }
               .footer a {
                   color: #999;
               }
               .footer p, .footer a, .footer unsubscribe, .footer td {
                   font-size: 12px;
               }

               /* -------------------------------------
                   TYPOGRAPHY
               ------------------------------------- */
               h1, h2, h3 {
                   font-family: "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
                   color: #000;
                   margin: 40px 0 0;
                   line-height: 1.2;
                   font-weight: 400;
               }

               h1 {
                   font-size: 32px;
                   font-weight: 500;
               }

               h2 {
                   font-size: 24px;
               }

               h3 {
                   font-size: 18px;
               }

               h4 {
                   font-size: 14px;
                   font-weight: 600;
               }

               p, ul, ol {
                   margin-bottom: 10px;
                   font-weight: normal;
               }
               p li, ul li, ol li {
                   margin-left: 5px;
                   list-style-position: inside;
               }

               /* -------------------------------------
                   LINKS & BUTTONS
               ------------------------------------- */
               a {
                   color: #1ab394;
                   text-decoration: underline;
               }

               .btn-primary {
                   text-decoration: none;
                   color: #FFF;
                   background-color: #1ab394;
                   border: solid #1ab394;
                   border-width: 5px 10px;
                   line-height: 2;
                   font-weight: bold;
                   text-align: center;
                   cursor: pointer;
                   display: inline-block;
                   border-radius: 5px;
                   text-transform: capitalize;
               }

               /* -------------------------------------
                   OTHER STYLES THAT MIGHT BE USEFUL
               ------------------------------------- */
               .last {
                   margin-bottom: 0;
               }

               .first {
                   margin-top: 0;
               }

               .aligncenter {
                   text-align: center;
               }

               .alignright {
                   text-align: right;
               }

               .alignleft {
                   text-align: left;
               }

               .clear {
                   clear: both;
               }

               /* -------------------------------------
                   ALERTS
                   Change the class depending on warning email, good email or bad email
               ------------------------------------- */
               .alert {
                   font-size: 16px;
                   color: #fff;
                   font-weight: 500;
                   padding: 20px;
                   text-align: center;
                   border-radius: 3px 3px 0 0;
               }
               .alert a {
                   color: #fff;
                   text-decoration: none;
                   font-weight: 500;
                   font-size: 16px;
               }
               .alert.alert-warning {
                   background: #f8ac59;
               }
               .alert.alert-bad {
                   background: #ed5565;
               }
               .alert.alert-good {
                   background: #1ab394;
               }

               /* -------------------------------------
                   INVOICE
                   Styles for the billing table
               ------------------------------------- */
               .invoice {
                   margin: 40px auto;
                   text-align: left;
                   width: 80%;
               }
               .invoice td {
                   padding: 5px 0;
               }
               .invoice .invoice-items {
                   width: 100%;
               }
               .invoice .invoice-items td {
                   border-top: #eee 1px solid;
               }
               .invoice .invoice-items .total td {
                   border-top: 2px solid #333;
                   border-bottom: 2px solid #333;
                   font-weight: 700;
                   width: 80%;

               }

               /* -------------------------------------
                   RESPONSIVE AND MOBILE FRIENDLY STYLES
               ------------------------------------- */
               @media only screen and (max-width: 640px) {
                   h1, h2, h3, h4 {
                       font-weight: 600 !important;
                       margin: 20px 0 5px !important;
                   }

                   h1 {
                       font-size: 22px !important;
                   }

                   h2 {
                       font-size: 18px !important;
                   }

                   h3 {
                       font-size: 16px !important;
                   }

                   .container {
                       width: 100% !important;
                   }

                   .content, .content-wrap {
                       padding: 10px !important;
                   }

                   .invoice {
                       width: 100% !important;
                   }
               }
                </style>
            </head>

            <body>
            <table class="body-wrap">
                <tbody><tr>
                    <td></td>
                    <td class="container" width="600">
                        <div class="content">
                            <table class="main" width="100%" cellpadding="0" cellspacing="0">
                                <tbody><tr>
                                    <td class="content-wrap aligncenter">
                                        <table width="100%" cellpadding="0" cellspacing="0">
                                            <tbody><tr>
                                                <td class="content-block">
                                                    <h2>Vielen Dank für Ihre Bestellung</h2>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="content-block">
                                                    <table class="invoice">
                                                        <tbody><tr>
                                                            <td>\(invoiceData.customerName)<br>RechnungNR: \(invoiceData.invoiceNum)<br>Rechnungdatum: \(dateFormatter(date: invoiceData.createdAt.dateValue()))</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table class="invoice-items" cellpadding="0" cellspacing="0">
                                                                    <tbody>
                                                                      \(productsHtml)
                                                                        <tr class="total">
                                                                        <td class="">Gesamtbetrag</td>
                                                                        <td class=""></td>

                                                                        <td class="alignright"> \(PriceReplacing(price: invoiceData.totalPrice))€</td>
                                                                    </tr>
                                                                </tbody></table>
                                                            </td>
                                                        </tr>
                                                    </tbody></table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="content-block">
                                                    <a href="#">Ansicht im Browser</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="content-block">
                                                    Biarfood GmbH Jena/Deutschland
                                                </td>
                                            </tr>
                                        </tbody></table>
                                    </td>
                                </tr>
                            </tbody></table>
                            <div class="footer">
                                <table width="100%">
                                    <tbody><tr>
                                        <td class="aligncenter content-block">Haben sie Fragen? <a href="mailto:">support@biarfood.de</a></td>


                                    </tr>
                                </tbody>
                                <tbody><tr>

                                    <td>Maßgebliche Rechtsgrundlagen
                                        Maßgebliche Rechtsgrundlagen nach der DSGVO: Im Folgenden erhalten Sie eine Übersicht der Rechtsgrundlagen der DSGVO, auf deren Basis wir personenbezogene Daten verarbeiten. Bitte nehmen Sie zur Kenntnis, dass neben den Regelungen der DSGVO nationale Datenschutzvorgaben in Ihrem bzw. unserem Wohn- oder Sitzland gelten können. Sollten ferner im Einzelfall speziellere Rechtsgrundlagen maßgeblich sein, teilen wir Ihnen diese in der Datenschutzerklärung mit.
                                        
                                        Nationale Datenschutzregelungen in Deutschland: Zusätzlich zu den Datenschutzregelungen der DSGVO gelten nationale Regelungen zum Datenschutz in Deutschland. Hierzu gehört insbesondere das Gesetz zum Schutz vor Missbrauch personenbezogener Daten bei der Datenverarbeitung (Bundesdatenschutzgesetz – BDSG). Das BDSG enthält insbesondere Spezialregelungen zum Recht auf Auskunft, zum Recht auf Löschung, zum Widerspruchsrecht, zur Verarbeitung besonderer Kategorien personenbezogener Daten, zur Verarbeitung für andere Zwecke und zur Übermittlung sowie automatisierten Entscheidungsfindung im Einzelfall einschließlich Profiling. Ferner können Landesdatenschutzgesetze der einzelnen Bundesländer zur Anwendung gelangen.
                                        
                                        Hinweis auf Geltung DSGVO und Schweizer DSG: Diese Datenschutzhinweise dienen sowohl der Informationserteilung nach dem schweizerischen Bundesgesetz über den Datenschutz (Schweizer DSG) als auch nach der Datenschutzgrundverordnung (DSGVO). Aus diesem Grund bitten wir Sie zu beachten, dass aufgrund der breiteren räumlichen Anwendung und Verständlichkeit die Begriffe der DSGVO verwendet werden. Insbesondere statt der im Schweizer DSG verwendeten Begriffe „Bearbeitung“ von „Personendaten“, "überwiegendes Interesse" und "besonders schützenswerte Personendaten" werden die in der DSGVO verwendeten Begriffe „Verarbeitung“ von „personenbezogenen Daten“ sowie "berechtigtes Interesse" und "besondere Kategorien von Daten" verwendet. Die gesetzliche Bedeutung der Begriffe wird jedoch im Rahmen der Geltung des Schweizer DSG weiterhin nach dem Schweizer DSG bestimmt.
                                        
                                        Übersicht der Verarbeitungen
                                        Die nachfolgende Übersicht fasst die Arten der verarbeiteten Daten und die Zwecke ihrer Verarbeitung zusammen und verweist auf die betroffenen Personen.
                                        
                                        Sicherheitsmaßnahmen
                                        Wir treffen nach Maßgabe der gesetzlichen Vorgaben unter Berücksichtigung des Stands der Technik, der Implementierungskosten und der Art, des Umfangs, der Umstände und der Zwecke der Verarbeitung sowie der unterschiedlichen Eintrittswahrscheinlichkeiten und des Ausmaßes der Bedrohung der Rechte und Freiheiten natürlicher Personen geeignete technische und organisatorische Maßnahmen, um ein dem Risiko angemessenes Schutzniveau zu gewährleisten.
                                        
                                        Zu den Maßnahmen gehören insbesondere die Sicherung der Vertraulichkeit, Integrität und Verfügbarkeit von Daten durch Kontrolle des physischen und elektronischen Zugangs zu den Daten als auch des sie betreffenden Zugriffs, der Eingabe, der Weitergabe, der Sicherung der Verfügbarkeit und ihrer Trennung. Des Weiteren haben wir Verfahren eingerichtet, die eine Wahrnehmung von Betroffenenrechten, die Löschung von Daten und Reaktionen auf die Gefährdung der Daten gewährleisten. Ferner berücksichtigen wir den Schutz personenbezogener Daten bereits bei der Entwicklung bzw. Auswahl von Hardware, Software sowie Verfahren entsprechend dem Prinzip des Datenschutzes, durch Technikgestaltung und durch datenschutzfreundliche Voreinstellungen.
                                        
                                        Rechte der betroffenen Personen
                                        Rechte der betroffenen Personen aus der DSGVO: Ihnen stehen als Betroffene nach der DSGVO verschiedene Rechte zu, die sich insbesondere aus Art. 15 bis 21 DSGVO ergeben:
                                        
                                        Widerspruchsrecht: Sie haben das Recht, aus Gründen, die sich aus Ihrer besonderen Situation ergeben, jederzeit gegen die Verarbeitung der Sie betreffenden personenbezogenen Daten, die aufgrund von Art. 6 Abs. 1 lit. e oder f DSGVO erfolgt, Widerspruch einzulegen; dies gilt auch für ein auf diese Bestimmungen gestütztes Profiling. Werden die Sie betreffenden personenbezogenen Daten verarbeitet, um Direktwerbung zu betreiben, haben Sie das Recht, jederzeit Widerspruch gegen die Verarbeitung der Sie betreffenden personenbezogenen Daten zum Zwecke derartiger Werbung einzulegen; dies gilt auch für das Profiling, soweit es mit solcher Direktwerbung in Verbindung steht.
                                        Widerrufsrecht bei Einwilligungen: Sie haben das Recht, erteilte Einwilligungen jederzeit zu widerrufen.
                                        Auskunftsrecht: Sie haben das Recht, eine Bestätigung darüber zu verlangen, ob betreffende Daten verarbeitet werden und auf Auskunft über diese Daten sowie auf weitere Informationen und Kopie der Daten entsprechend den gesetzlichen Vorgaben.
                                        Recht auf Berichtigung: Sie haben entsprechend den gesetzlichen Vorgaben das Recht, die Vervollständigung der Sie betreffenden Daten oder die Berichtigung der Sie betreffenden unrichtigen Daten zu verlangen.
                                        Recht auf Löschung und Einschränkung der Verarbeitung: Sie haben nach Maßgabe der gesetzlichen Vorgaben das Recht, zu verlangen, dass Sie betreffende Daten unverzüglich gelöscht werden, bzw. alternativ nach Maßgabe der gesetzlichen Vorgaben eine Einschränkung der Verarbeitung der Daten zu verlangen.
                                        Recht auf Datenübertragbarkeit: Sie haben das Recht, Sie betreffende Daten, die Sie uns bereitgestellt haben, nach Maßgabe der gesetzlichen Vorgaben in einem strukturierten, gängigen und maschinenlesbaren Format zu erhalten oder deren Übermittlung an einen anderen Verantwortlichen zu fordern.
                                        Beschwerde bei Aufsichtsbehörde: Sie haben unbeschadet eines anderweitigen verwaltungsrechtlichen oder gerichtlichen Rechtsbehelfs das Recht auf Beschwerde bei einer Aufsichtsbehörde, insbesondere in dem Mitgliedstaat ihres gewöhnlichen Aufenthaltsorts, ihres Arbeitsplatzes oder des Orts des mutmaßlichen Verstoßes, wenn Sie der Ansicht sind, dass die Verarbeitung der Sie betreffenden personenbezogenen Daten gegen die Vorgaben der DSGVO verstößt.</td>

                                </tr>
                            </tbody>
                            </table>
                            </div></div>
                    </td>
                    <td></td>
                </tr>
            </tbody></table>
            </body>
        </html>
        """
        
        return htmlTemplate
    }
    
}

