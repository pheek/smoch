#!/usr/bin/python
#
# 2020 Create QR-Codes for museum
#
# (c) phi
#


## install fpdf first:
## python -m pip install fpdf
from fpdf import FPDF;

## install python-mysql first:
## python -m pip install mysql-connector-python
import mysql.connector as mariadb;

## install qr-code first
## python -m pip install opencv-python qrcode
import qrcode;

## Create a QR-Code PNG in /img/ folder.
##
def create_temp_qrCode(id):
	url = "https://www.smoch.ch/erfindung.php/";
	filename = "img/" + id + ".png";
	qr = qrcode.QRCode(
    version=1,
    error_correction=qrcode.constants.ERROR_CORRECT_L,
    box_size=10,
    border=4,
	)
	qr.add_data(url + id);
	qr.make(fit=True);
	img = qr.make_image(fill_color="#000", back_color="#bf0");
	img.save(filename);


## Test PDF
## Create the pdf
pdf = FPDF();




## Handle a single "Exponat"
def handle_single_exponat(x):
	pdf.add_page();

  # add qr code		
	create_temp_qrCode(x[0]);
	pdf.image("img/" + x[0] + ".png", 10, 8, 40);

	pdf.set_font("Courier", size=10);
	##print(">>>>" + x[0] + "<<<");
	pdf.cell(43);
	text = "https://www.smoch.ch/erfindung.php/" + x[0];
	pdf.cell(200, 6, txt=text, ln=1, align="L");

	pdf.set_font("times", size=12);
	pdf.cell(43);
	text = "Erfindung: " + x[1] + " (" + x[2] + ")";
	pdf.cell(200, 6, txt=text, ln=1, align="L");

	pdf.set_font("times", size=11);
	pdf.cell(43);
	text = "Exponat: " + x[5] + " (" + x[4] + ")";
	pdf.cell(200, 6, txt=text, ln=1, align="L");

	pdf.set_font("times", size=10);
	pdf.cell(43);
	text = "Inventar Nr: " + x[6];
	pdf.cell(200, 6, txt=text, ln=1, align="L");

	
## DB Connection

mydb = mariadb.connect(
  host    ="localhost",
  user    ="smoch"    ,
  password="123"      ,
  database="smoch"
);

mycursor = mydb.cursor();

mycursor.execute("SELECT * FROM `vw_erfindungsexponat`");

myresult = mycursor.fetchall();

for ex in myresult:
  handle_single_exponat(ex);


#STORE the PDF at the end
pdf.output("qr-codes.pdf");
